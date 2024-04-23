# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AppLock' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'MBSPasswordView', :git => 'https://github.com/tunganh123/MBS.git', :branch => 'main'

  pod 'Localize-Swift', '~> 3.2'
  pod 'lottie-ios'
  pod 'RealmSwift'
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleUserMessagingPlatform'
  # Pods for AppLock

end

target 'SiriIntent' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SiriIntent

end
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
