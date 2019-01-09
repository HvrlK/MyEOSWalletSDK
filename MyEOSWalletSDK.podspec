Pod::Spec.new do |s|
  s.name         = "MyEOSWalletSDK"
  s.version      = "0.0.3"
  s.swift_version = '4.2'
  s.summary      = "Access EOS account information, send EOS transfers"
  s.description  = <<-DESC 
MyEOSWallet SDK allows to securely access EOS account information and send EOS transfers by implementing the via the MyEOSWallet (https://atticlab.net). 
SDK implements SimpleWallet protocol (https://github.com/southex/SimpleWallet/blob/master/README_en.md) to allow DApps to universally interact with the MyEOSWallet.
                   DESC

  s.homepage     = "https://atticlab.net"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author       = { "Vitalii Havryliuk" => "v.havryliuk@noisyminer.com" }

  s.platform     = :ios
  s.ios.deployment_target = '11.0'
  s.requires_arc = true

  s.source       = { :git => "https://github.com/HvrlK/MyEOSWalletSDK.git", :branch => "0.0.3", :tag => s.version.to_s }

  s.source_files  = "MyEOSWallet SDK/MyEOSWallet SDK/Source/**/*.swift"
  s.exclude_files = "Examples/*"
  s.frameworks = 'Foundation', 'UIKit', 'CoreFoundation'
end
