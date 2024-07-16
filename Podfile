# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOS Task Yassir' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOS Task Yassir
  pod 'Alamofire', '4.9.0'
  pod 'SwiftyJSON'
  pod 'lottie-ios', '3.3.0'
  pod 'SDWebImage', '~> 5.0'
  pod 'SDWebImageSwiftUI'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "15.0"
    end
  end
end
