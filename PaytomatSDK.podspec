Pod::Spec.new do |s|
  s.name         = "PaytomatSDK"
  s.version      = "0.0.1"
  s.swift_version = '4.2'
  s.summary      = "Access EOS account information, send EOS transfers"
  s.description  = <<-DESC 
Paytomat SDK allows to securely access EOS account information and send EOS transfers by implementing the via the Paytomat Wallet (https://paytomat.com/). 
SDK implements SimpleWallet protocol (https://github.com/southex/SimpleWallet/blob/master/README_en.md) to allow DApps to universally interact with the Paytomat Wallet.
                   DESC

  s.homepage     = "https://paytomat.com/"

  #s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author       = { "Alex Melnichuk" => "a.melnichuk@noisyminer.com" }

  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  # s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/a-melnichuk/Paytomat-SDK.git", :branch => "master", :tag => s.version.to_s }

  s.source_files  = "Paytomat SDK/Paytomat SDK/Source/**/*.swift"
  s.exclude_files = "Examples/*"
  s.frameworks = 'Foundation', 'CoreFoundation'
end
