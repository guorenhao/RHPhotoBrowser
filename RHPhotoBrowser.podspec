#
#  Be sure to run `pod spec lint RHPhotoBrowser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RHPhotoBrowser"
  s.version      = "1.0.3"
  s.summary      = "RHPhotoBrowser 是一款简单的图片浏览器"
  s.homepage     = "https://github.com/guorenhao/RHPhotoBrowser"
  s.license      = "MIT"
  s.author       = {"Abner_G" => "grh_1990@126.com"}
  s.platform     = :ios, "8.0"   
  s.source       = {:git => "https://github.com/guorenhao/RHPhotoBrowser.git", :tag => s.version}
  s.source_files = "RHPhotoBrowser/*.{h,m}"
  s.frameworks   = "UIKit"
  s.requires_arc = true
  s.dependency "SDWebImage", "~> 4.2.3"
  s.dependency "RHProgressHUD", "~> 1.0.0"

end
