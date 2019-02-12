//
//  MDNetworkTools.swift
//  WhatsMode
//
//  Created by Brave on 2019/1/28.
//  Copyright © 2019 Yedao Inc. All rights reserved.
//

import UIKit
import Alamofire

///成功数据的回调
public typealias successCallback = (([String : Any]?) -> (Void))
///失败的回调
public typealias failedCallback = ((Error?) -> (Void))
///支持的网络请求方式
public enum MethodType {
    case get
    case post
    case put
    case delete
    public func method() -> HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .delete:
            return HTTPMethod.delete
        }
    }
}

public class MDNetworkTools {
    public static let `default`: MDNetworkTools = MDNetworkTools()
    public var baseURL : URL?
    /**
     * basic HTTP/HTTPS netwrok request method, support get/post/put/delete
     * 基本的网络请求, 支持(GET/POST/PUT/DELETE)
     */
    public func requestData(url : URL,
                            type : MethodType,
                            parameters : [String : Any]? = nil,
                            headers : HTTPHeaders? = nil,
                            success: @escaping successCallback,
                            failed: failedCallback? = nil) -> DataRequest {
        let newURL = buildURL(url: url)
        // 1.获取类型
        let method : HTTPMethod = type.method()
        let encoding : ParameterEncoding = (url.query?.isEmpty ?? true) ? JSONEncoding.default : URLEncoding.default
        // 2.发送网络请求
        return Alamofire.request(newURL,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers)
            .customizedValidate()
            .responseJSON {[weak self] (response) in
                switch response.result {
                case .success(let result):
                    self?.handleResponse(result: result, success: success, failed: failed)
                // 请求失败
                case .failure(let error):
                    failed?(error)
                }
        }
    }
    public func upload(url : URL,
                       data : Data,
                       dataInfo : (name : String, fileName : String, mimeType : String),
                       headers : HTTPHeaders? = nil,
                       success: @escaping successCallback,
                       failed: failedCallback? = nil) {
        let newURL = buildURL(url: url)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: dataInfo.name,
                                     fileName: dataInfo.fileName,
                                     mimeType: dataInfo.mimeType)
        },
                         to: newURL,
                         method: .post,
                         headers: headers)
        {[weak self] (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let data = response.data {
                        let result = try? JSONSerialization.jsonObject(with: data, options: [])
                        self?.handleResponse(result: result, success: success, failed: failed)
                    } else {
                        // no response data
                        failed?(MDNetworkStatus.default?.asErr())
                    }
                }
            case .failure(let err):
                failed?(err)
            }
        }
    }
    // MARK:
    private func buildURL(url : URL) -> URL {
        if url.host == nil && baseURL != nil {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL:false)
            urlComponents?.host = baseURL?.host
            urlComponents?.scheme = baseURL?.scheme
            let newURL = urlComponents?.url
            assert(newURL != nil)
            return newURL!
        }
        return url
    }
    // MARK: handle response
    private func handleResponse(result : Any?, success: @escaping successCallback, failed: failedCallback? = nil) {
        let status = MDNetworkStatus.deserialize(from: result as? [String : Any])
        if status?.code == MDNetworkStatus.NO_ERROR.name {
            success(result as? [String : Any])
        } else {
            failed?(status?.asErr())
        }
    }
}
extension DataRequest {
    public func customizedValidate() -> Self {
        return validate()
    }
}
