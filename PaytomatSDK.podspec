Pod::Spec.new do |s|
  s.name         = "PaytomatSDK"
  s.version      = "0.0.1"
  s.summary      = "Access EOS account information, send EOS transfers"
  s.description  = <<-DESC 
Paytomat SDK allows to securely access EOS account information and send EOS transfers by implementing the via the Paytomat Wallet (https://paytomat.com/). 
SDK implements SimpleWallet protocol (https://github.com/southex/SimpleWallet/blob/master/README_en.md) to allow DApps to universally interact with the Paytomat Wallet.
                   DESC

  s.homepage     = "https://paytomat.com/"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Alex Melnichuk" => "a.melnichuk@noisyminer.com" }

  s.platform     = :ios
  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  # s.platform     = :ios, "5.0"

  s.source       = { :git => "https://melnichukal2@bitbucket.org/noisyminer/paytomat-sdk.git", :tag => "#{s.version}" }
  # s.source       = { :git => "http://EXAMPLE/PaytomatSDK.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Paytomat SDK/Source/**/*.swift"
  s.exclude_files = "Examples"
  # s.public_header_files = "Classes/**/*.h"
  s.frameworks = 'Foundation', 'CoreFoundation'
end
