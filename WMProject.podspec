Pod::Spec.new do |s|
s.name         = 'WMProject'
s.version      = '1.0.1'
s.summary      = 'default configuration'
s.homepage     = 'https://github.com/cloudhm/WMProject'
s.license      = 'LICENSE'
s.authors      = { 'cloudhm' => 'cloud.huang@whatsmode.com'}
s.platform     = :ios, '10.0'
s.source       = { :git => 'https://github.com/cloudhm/WMProject.git',:tag =>s.version}
s.requires_arc  = true
s.swift_version = '4.0'
s.default_subspec = 'Core'
s.static_framework = true
s.subspec 'Core' do |core|
  core.source_files = 'Classes/Core/*.{swift}'
  core.dependency 'SDWebImage'
end

end


