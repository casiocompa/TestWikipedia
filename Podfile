platform :ios, '15.0'

target 'TestWikipedia' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Moya'
  pod 'RealmSwift'
  pod 'TinyConstraints'
  pod 'Wormholy', :configurations => ['Debug']

end

# manually set swift version
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['CODE_SIGN_IDENTITY'] = ""
      config.build_settings.delete 'PRODUCT_BUNDLE_IDENTIFIER'
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
        xcconfig_path = config.base_configuration_reference.real_path
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
       end
    end
  end
end
