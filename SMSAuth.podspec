Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "SMSAuth"
  s.summary = "SMSAuth lets you add SMS based authenticatione easily to an application."
  s.requires_arc = true

  s.version = "0.0.1"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Andrew Platkin" => "andrew.platkin@gmail.com" }
  s.homepage = "https://github.com/plattyp/SMSAuth"
  s.source = { :git => "https://github.com/plattyp/SMSAuth.git", :tag => "#{s.version}"}

  s.dependency 'Alamofire', '4.1.0'
  s.dependency 'BetterBaseClasses', '~> 1.0'
  s.dependency 'KeyClip', '1.4.0'
  s.dependency 'AlamofireObjectMapper', '4.0.1'
  s.dependency 'SwiftOverlays', '~> 3.0.0'
  s.dependency 'Font-Awesome-Swift', '~> 1.6.0'

  s.source_files = "SMSAuth", "SMSAuth/**/*.{swift,h,m}"
  s.resources = "SMSAuth/**/*.{png,jpeg,jpg,pdf,storyboard,xib,ttf}"
end
