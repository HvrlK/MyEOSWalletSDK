//
//  PaytomatSDKAccess.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation
import UIKit

protocol PaytomatSDKAccess where Self: PaytomatSDK {
    func appInfo() -> AppInfo
    func test() -> Any?
    @discardableResult
    func login(request: LoginRequest) -> Bool
    @discardableResult
    func transfer(request: TransferRequest) -> Bool
    func parseResult(from url: URL) -> URLResult
}

extension PaytomatSDK: PaytomatSDKAccess {
    public struct AppInfo {
        let name: String
        let url: URL?
        let iconUrl: String?
        let description: String?
    }
    
    public func appInfo() -> PaytomatSDK.AppInfo {
        return AppInfo(name: "Paytomat",
                       url: URL(string: "https://paytomat.com/"),
                       iconUrl: nil,
                       description: "Multi-currency wallet")
    }
    
    public func login(request: LoginRequest) -> Bool {
        guard let url = request.paytomatUrl(),
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
    
    public func transfer(request: TransferRequest) -> Bool {
        guard let url = request.paytomatUrl(),
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
    
    public func test() -> Any? {
        print("__PAYTOMAT_SDK_TEST!22")
        return nil
    }
    
    public func parseResult(from url: URL) -> PaytomatSDK.URLResult {
        return .unsupported(.unsupported)
    }
}
