Pod::Spec.new do |s|
s.name         = 'WMProject'
s.version      = '1.0.11'
s.summary      = 'default configuration'
s.homepage     = 'https://github.com/cloudhm/WMProject'
s.license      = 'LICENSE'
s.authors      = { 'cloudhm' => 'cloud.huang@whatsmode.com'}
s.platform     = :ios, '10.0'
s.source       = { :git => 'https://github.com/cloudhm/WMProject.git',:tag =>s.version}
s.requires_arc  = true
s.swift_version = '4.0'
s.default_subspec = 'Core', 'Components'
s.static_framework = true

s.subspec 'Addition' do |addition|
  addition.source_files = 'Classes/Addition/*.{swift}'
end

s.subspec 'Animator' do |animator|
  animator.source_files = 'Classes/Animator/*.{swift}'
end

s.subspec 'Components' do |components|
  components.source_files = 'Classes/Components/Selection/*.{swift}'
  components.source_files = 'Classes/Components/DatePicker/*.{swift}'
  components.dependency 'SnapKit'
  components.dependency 'WMProject/Animator'
end

s.subspec 'Core' do |core|
  core.source_files = 'Classes/Core/*.{swift}'
  core.dependency 'SDWebImage'
  core.dependency 'WMProject/Addition'
  core.dependency 'WMProject/Animator'
end

end


