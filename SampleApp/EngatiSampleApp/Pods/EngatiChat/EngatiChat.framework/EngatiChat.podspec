#
#  Be sure to run `pod spec lint EngatiChat.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "EngatiChat"
  s.version      = "1.4.3"
  s.summary      = "iOS Chat client for engati"
  #s.description  = <<-DESC
  #                  DESC

  s.homepage     = "https://engati.com/"
  s.license = { :type => 'Commercial'}
  s.license = { :type => 'Commercial', :text => 'Copyright 2018 Engati. All Rights Reserved.' }
  s.author             = { "Engati" => "contact@engati.com" }
  s.documentation_url = "https://s3.ap-south-1.amazonaws.com/branding-resources/bot-sdk/iOS/1.4.0/Engati_iOS_sdk.pdf"

  s.platform     = :ios
  s.swift_version = '5.0'
  s.ios.deployment_target = "10.0"
  s.source       = { :type => "zip", :http =>
  "https://github.com/Engati/Engati_SDK_iOS/raw/1.4.3/EngatiChat.framework.zip" }

  s.preserve_paths = 'EngatiChat.framework'
  s.ios.vendored_frameworks = 'EngatiChat.framework'
  s.ios.frameworks  = 'UIKit', 'AVFoundation', 'Foundation'
  s.dependency 'Socket.IO-Client-Swift', '>= 15.1.0'
  s.dependency 'AlamofireImage', '>= 4.0.0-beta.3'
  s.dependency 'Alamofire', '<= 5.0.0-beta.7'
  s.dependency 'Kingfisher'
end
