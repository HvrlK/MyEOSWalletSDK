//
//  PaytomatSDKAccess.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

protocol PaytomatSDKAccess where Self: PaytomatSDK {
    func appInfo() -> AppInfo
    func test() -> Any?
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
    
    public func test() -> Any? {
        print("__PAYTOMAT_SDK_TEST!")
        return nil
    }
    
    public func parseResult(from url: URL) -> PaytomatSDK.URLResult {
        return .unsupported(.unsupported)
    }
}
