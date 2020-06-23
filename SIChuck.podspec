Pod::Spec.new do |s|
  s.name     = 'SIChuck'
  s.version  = '1.0'
  s.license  = 'MIT'
  s.summary  = 'Chuck UI插件'
  s.homepage = 'https://github.com/hwenxzhangling/SIChuck'
  s.social_media_url = 'https://github.com/hwenxzhangling/SIChuck'
  s.authors  = { 'wenxue' => 'hwenxue' }
  s.source   = { :git => 'https://github.com/hwenxzhangling/SIChuck.git', :tag => s.version }
  s.frameworks   = "Foundation"
  
  s.frameworks   = "Foundation"
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'

  s.ios.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.alamofire.SIChuck' }
  s.osx.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.alamofire.SIChuck' }
  s.watchos.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER' => 'com.alamofire.SIChuck-watchOS' }
 
  s.source_files = 'SIChuck/SIChuck.h'

  s.subspec 'SIChuck' do |ss|
    ss.source_files = 'SIChuck/SIChuck/.{h}'
  end

end