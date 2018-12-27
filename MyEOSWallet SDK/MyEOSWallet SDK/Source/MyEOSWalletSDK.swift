//
//  MyEOSWallet.swift
//  MyEOSWallet SDK
//
//  Created by Vitalii Havryliuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import UIKit

public final class MyEOSWalletSDK: MyEOSWalletSDKAccess {
    
    public static var shared: MyEOSWalletSDK {
        guard let shared = _shared else {
            preconditionFailure("MyEOSWalletSDK must be initialized with MyEOSWalletSDK.setup(configuration:) before accessing shared instance")
        }
        return shared
    }
    
    private static var _shared: MyEOSWalletSDK? = nil
    
    /// Checks, if My EOS Wallet  is installed
    /// - returns:
    /// true if wallet installed, false otherwise
    
    public var isWalletInstalled: Bool {
        guard let url = URL(string: "myeoswallet://") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    // MARK: Public methods
    

    /// Configures shared instanse for further use.
    /// Must be called in `AppDelegate.application(_:, didFinishLaunchingWithOptions:)`
    /// ```
    /// func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ///     MyEOSWalletSDK.setup()
    ///     return true
    /// }
    /// ```
    
    public static func setup() {
        _shared = MyEOSWalletSDK(configuration: Configuration())
    }
    
    /// Requests EOS Account information from My EOS Wallet app (if installed)
    /// - returns:
    /// true if My EOS Wallet is installed, false otherwise
    /// - parameters:
    ///     - request: Information about the app that opens My EOS Wallet
    /// ```
    /// let request = MyEOSWalletSDK.LoginRequest(appName: "Examples",
    ///                                        appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
    ///                                        appVersion: "1.0",
    ///                                        appDescription: "Example description",
    ///                                        uuID: "test-uuid",
    ///                                        loginUrl: nil,
    ///                                        callbackUrl: "MyEOSWalletSDKExamples://eos.io")
    /// MyEOSWalletSDK.shared.login(request: request)
    /// ```
    
    @discardableResult
    public func login(request: LoginRequest) -> Bool {
        guard let url = request.myEOSWalletUrl(),
            UIApplication.shared.canOpenURL(url) else {
                return false
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
        return true
    }
    
    /// Transfers EOS or EOS Token using My EOS Wallett app (if installed)
    /// - returns:
    /// true if My EOS Wallet is installed, false otherwise
    /// - parameters:
    ///     - request: Transaction parameters and information about the app that opens My EOS Wallet
    /// ```
    /// let request = MyEOSWalletSDK.TransferRequest(appName: "Examples",
    ///                                           appIcon: "http://daramghaus.github.io/icontester/images/iTunesArtwork.png",
    ///                                           appVersion: "1.0",
    ///                                           appDescription: "Example description",
    ///                                           to: "metcondition",
    ///                                           amount: 0.0001,
    ///                                           contract: "eosio.token",
    ///                                           symbol: "EOS",
    ///                                           precision: 4,
    ///                                           memo: nil,
    ///                                           callbackUrl: "MyEOSWalletSDKExamples://eos.io")
    /// MyEOSWalletSDK.shared.transfer(request: request)
    /// ```
    
    @discardableResult
    public func transfer(request: TransferRequest) -> Bool {
        guard let url = request.myEOSWalletUrl(),
            UIApplication.shared.canOpenURL(url) else {
                return false
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
        return true
    }
    
    /// Parses result from url recieved by `AppDelegate.application(_:, open:, options:)`
    /// - returns:
    /// URLResult if URL format is can be parsed by the SDK, nil otherwise
    /// - parameters:
    ///     - url: URL to parse
    /// ```
    /// func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    ///     guard let result = MyEOSWallet.shared.parseResult(from: url) else {
    ///         print("Url result parse error")
    ///         return false
    ///     }
    ///     switch result {
    ///     case .login(let result):
    ///         switch result {
    ///         case .success(let success):
    ///             let accountName = success.accountName
    ///            print("Login success, account: \(accountName)")
    ///         case .error(let error):
    ///             print("Login error: \(error)")
    ///         case .cancel:
    ///             print("Login cancel")
    ///         }
    ///     case .transfer(let result):
    ///         switch result {
    ///         case .success(let success):
    ///             let transactionId = success.transactionId
    ///             print("Transfer success, transactionId: \(transactionId)")
    ///         case .error(let error):
    ///             print("Transfer error: \(error)")
    ///         case .cancel:
    ///             print("Transfer cancel")
    ///         }
    ///     }
    ///     return true
    /// }
    /// ```
    
    public func parseResult(from url: URL) -> MyEOSWalletSDK.URLResult? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let resultString = queryItems.first(where: { $0.name == "result" })?.value,
            let actionString = queryItems.first(where: { $0.name == "action" })?.value,
            let resultInt = Int(resultString),
            let result = SimpleWallet.Result(rawValue: resultInt),
            let action = SimpleWallet.Action(rawValue: actionString) else {
                return nil
        }
        
        switch result {
        case .cancel:
            return parseCancel(action: action)
        case .failure:
            return parseError(action: action, queryItems: queryItems)
        case .success:
            return parseSuccess(action: action, queryItems: queryItems)
        }
    }
    
    // MARK: Private methods
    
    private func parseSuccess(action: SimpleWallet.Action,
                              queryItems: [URLQueryItem]) -> MyEOSWalletSDK.URLResult {
        switch action {
        case .login:
            guard let accountName = queryItems.first(where: { $0.name == "accountName" })?.value else {
                return .login(.error(.parse))
            }
            let model = LoginSuccess(accountName: accountName)
            return .login(.success(model))
        case .transfer:
            guard let txID = queryItems.first(where: { $0.name == "txID" })?.value else {
                return .transfer(.error(.parse))
            }
            let model = TransferSuccess(transactionId: txID)
            return .transfer(.success(model))
        }
    }
    
    private func parseError(action: SimpleWallet.Action,
                            queryItems: [URLQueryItem]) -> MyEOSWalletSDK.URLResult {
        let errorCodeStr = queryItems.first(where: { $0.name == "errorCode" })?.value ?? ""
        let errorCode = ErrorCode(errorCodeStr)
        switch action {
        case .login:
            return .login(.error(errorCode.loginError))
        case .transfer:
            return .transfer(.error(errorCode.transferError))
        }
    }
    
    private func parseCancel(action: SimpleWallet.Action) -> MyEOSWalletSDK.URLResult {
        switch action {
        case .login:
            return .login(.cancel)
        case .transfer:
            return .transfer(.cancel)
        }
    }
    
    private init(configuration: Configuration) {
        
    }
}

// MARK: MyEOSWalletSDK+Configuration

public extension MyEOSWalletSDK {
    public struct Configuration {
        public init() {
            
        }
    }
}
