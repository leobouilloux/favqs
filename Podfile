source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.0'
use_frameworks!
inhibit_all_warnings!

def pods
    pod 'Alamofire'
    pod 'RealmSwift'
    pod 'RxAlamofire'
    pod 'RxCocoa'
    pod 'RxRealm'
    pod 'RxSwift'
    pod 'SwiftGen', '~> 6.0'
    pod 'SwiftLint'
end

target 'Favqs' do
    pods
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
            config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
            config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
   
        end
    end
end