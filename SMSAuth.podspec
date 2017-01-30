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
  s.source = { :git => "git@github.com:plattyp/SMSAuth.git", :tag => "#{s.version}"}

  s.dependency 'Alamofire', '~> 3.0'
  s.dependency 'KeyClip', '~> 1.3.3'
  s.dependency 'AlamofireObjectMapper', '~> 2.0'

  s.source_files = "SMSAuth/**/*.{swift}"
  s.resources = "SMSAuth/**/*.{png,jpeg,jpg,storyboard,xib}"
end
