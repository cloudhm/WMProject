Pod::Spec.new do |s|
s.name         = 'WMProject'
s.version      = '1.1.0'
s.summary      = 'default configuration'
s.homepage     = 'https://github.com/cloudhm/WMProject'
s.license      = 'LICENSE'
s.authors      = { 'cloudhm' => 'cloud.huang@whatsmode.com'}
s.platform     = :ios, '9.0'
s.source       = { :git => 'https://github.com/cloudhm/WMProject.git',:tag =>s.version}
s.requires_arc  = true
s.swift_version = '4.2'
s.default_subspec = 'Core', 'Selection', 'DatePicker', 'Share', 'Utils', 'OneSignalAddition'
s.static_framework = true

s.subspec 'Addition' do |addition|
  addition.source_files = 'Classes/Addition/*.{swift}'
end

s.subspec 'Animator' do |animator|
  animator.source_files = 'Classes/Animator/*.{swift}'
end

s.subspec 'Selection' do |selection|
  selection.source_files = 'Classes/Components/Selection/*.{swift}'
  selection.dependency 'SnapKit', '= 4.2.0'
  selection.dependency 'WMProject/Animator'
end

s.subspec 'DatePicker' do |datepicker|
  datepicker.source_files = 'Classes/Components/DatePicker/*.{swift}'
  datepicker.dependency 'SnapKit'
  datepicker.dependency 'WMProject/Animator'
end

s.subspec 'Share' do |share|
  share.source_files = 'Classes/Components/Share/*.{swift}'
  share.dependency 'FBSDKShareKit', '= 4.38.1'
end

s.subspec 'Utils' do |utils|
  utils.source_files = 'Classes/Utils/*.{swift}'
end

s.subspec 'OneSignalAddition' do |onesignal|
  onesignal.source_files = 'Classes/Components/OneSignal/*.{swift}'
  onesignal.dependency 'OneSignal', '= 2.9.3'
end

s.subspec 'Core' do |core|
  core.source_files = 'Classes/Core/*.{swift}'
  core.dependency 'SDWebImage'
  core.dependency 'SDWebImage/GIF'
  core.dependency 'WMProject/Addition'
  core.dependency 'WMProject/Animator'
end

end


