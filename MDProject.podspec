Pod::Spec.new do |s|
s.name         = 'MDProject'
s.version      = '1.4.26'
s.summary      = 'default configuration'
s.homepage     = 'https://git.socialeras.com/cloud.huang/MDProject'
s.license      = 'LICENSE'
s.authors      = { 'cloudhm' => 'cloud.huang@whatsmode.com'}
s.platform     = :ios, '10.0'
s.source       = { :git => 'https://git.socialeras.com/cloud.huang/MDProject.git',:tag =>s.version}
s.requires_arc  = true
s.swift_version = '4.2'
s.default_subspec = 'Core', 'Selection', 'DatePicker', 'Share', 'Utils', 'OneSignalAddition', 'Counter'
s.static_framework = true

s.subspec 'Addition' do |addition|
  addition.source_files = 'Classes/Addition/*/*.{swift}'
  addition.dependency 'SDWebImage'
  addition.dependency 'SDWebImage/GIF'
end

s.subspec 'Animator' do |animator|
  animator.source_files = 'Classes/Animator/*.{swift}'
end

s.subspec 'Selection' do |selection|
  selection.source_files = 'Classes/Components/Selection/*.{swift}'
  selection.dependency 'SnapKit', '= 4.2.0'
  selection.dependency 'MDProject/Animator'
end

s.subspec 'DatePicker' do |datepicker|
  datepicker.source_files = 'Classes/Components/DatePicker/*.{swift}'
  datepicker.dependency 'SnapKit'
  datepicker.dependency 'MDProject/Animator'
end

s.subspec 'Share' do |share|
  share.source_files = 'Classes/Components/Share/*.{swift}'
  share.dependency 'FacebookShare', '= 0.5.0'
end

s.subspec 'Utils' do |utils|
  utils.source_files = 'Classes/Utils/*.{swift}'
end

s.subspec 'Counter' do |counter|
  counter.source_files = 'Classes/Components/Counter/*.{swift}'
end

s.subspec 'OneSignalAddition' do |onesignal|
  onesignal.source_files = 'Classes/Components/OneSignal/*.{swift}'
  onesignal.dependency 'OneSignal', '= 2.9.3'
end

s.subspec 'Core' do |core|
  core.source_files = 'Classes/Core/*/*.{swift}'
  core.dependency 'MDProject/Addition'
  core.dependency 'MDProject/Animator'
  core.dependency 'Alamofire'
  core.dependency 'HandyJSON', '=4.2.0'
end

end


