Paytomat SDK   
==============
Paytomat Wallet SDK allows iOS client apps to:
- **Get EOS Account**: Request EOS Authorization for an EOS Account.
- **Transfer EOS**: Send EOS and EOS Tokens.
- **Communicate via Simple Wallet**: DApp can interact with wallet via [Simple Wallet protocol](https://github.com/southex/SimpleWallet/blob/master/README_en.md)
 
## Installation
### Step 1: Add framework 
##### CocoaPods
1. Add `pod 'PaytomatSDK'` to Podfile
2. Run `pod install`
### Step 2: Configure Info.plist 
1. In Xcode, right-click your project's Info.plist file and select Open As -> Source Code.
2. Insert the following XML snippet into the body of your file just before the final </dict> element. (URL type can also be added via Xcode in TARGETS -> {your target} -> Info tab -> URL Types)
```xml
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Viewer</string>
			<key>CFBundleURLName</key>
			<string>{YOUR BUNDLE ID}</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>{YOUR APP SCHEME}</string>
			</array>
		</dict>
	</array>
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>paytomat</string>
</array>
```
### Step 3: Configure SDK in AppDelegate
Setup is required before accessing `PaytomatSDK.shared` instance
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    PaytomatSDK.setup()
}
```

## Usage examples

### Check if wallet is installed
```swift
PaytomatSDK.shared.isWalletInstalled
```

### Launch EOS Account request
```swift
 let request = PaytomatSDK.LoginRequest(appName: "{YOUR APP NAME}",
                                        appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
                                        appVersion: "1.0",
                                        appDescription: "{YOUR APP DESCRIPTION}",
                                        uuID: "{YOUR APP UUID}", // Needed only for Simple Wallet protocol
                                        loginUrl: nil, // Needed only for Simple Wallet protocol
                                        callbackUrl: "{YOUR APP SCHEME}://eos.io")
        PaytomatSDK.shared.login(request: request)
```

### Launch EOS Transfer request
```swift
let request = PaytomatSDK.TransferRequest(appName: "Examples",
                                          appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
                                          appVersion: "1.0",
                                          appDescription: "Example description",
                                          to: "{RECIPIENT ACCOUNT}",
                                          amount: 0.0001,
                                          contract: "eosio.token",
                                          symbol: "EOS",
                                          precision: 4,
                                          memo: nil,
                                          callbackUrl: "PaytomatSDKExamples://eos.io")
        PaytomatSDK.shared.transfer(request: request)
```
### Read wallet response 
Handle wallet response in AppDelegate
```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let result = PaytomatSDK.shared.parseResult(from: url) else {
            print("Url result parse error")
            return false
        }
        switch result {
        case .login(let result):
            switch result {
            case .success(let success):
                let accountName = success.accountName
                print("Login success, account: \(accountName)")
            case .error(let error):
                print("Login error: \(error)")
            case .cancel:
                print("Login cancel")
            }
        case .transfer(let result):
            switch result {
            case .success(let success):
                let transactionId = success.transactionId
                print("Transfer success, transactionId: \(transactionId)")
            case .error(let error):
                print("Transfer error: \(error)")
            case .cancel:
                print("Transfer cancel")
            }
        }
        return true
    }
```
