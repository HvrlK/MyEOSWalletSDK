//
//  AppDelegate.swift
//  Examples
//
//  Created by Alex Melnichuk on 11/12/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import UIKit
import PaytomatSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        PaytomatSDK.setup(configuration: PaytomatSDK.Configuration())
        print("Paytomat info: \(PaytomatSDK.shared.appInfo)")
        print("Paytomat Wallet installed: \(PaytomatSDK.shared.isWalletInstalled)")
        return true
    }
    
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
}

