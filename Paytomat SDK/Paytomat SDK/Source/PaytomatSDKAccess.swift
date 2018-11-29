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
    var appInfo: PaytomatSDK.AppInfo { get }
    var isWalletInstalled: Bool { get }
    @discardableResult
    func login(request: LoginRequest) -> Bool
    @discardableResult
    func transfer(request: TransferRequest) -> Bool
    func parseResult(from url: URL) -> URLResult?
}

extension PaytomatSDK: PaytomatSDKAccess {
    public struct AppInfo {
        public let name: String
        public let url: URL?
        public let iconUrl: String?
        public let description: String?
    }
    
    public var appInfo: AppInfo {
        return AppInfo(name: "Paytomat",
                       url: URL(string: "https://paytomat.com/"),
                       iconUrl: nil,
                       description: "Multi-currency wallet")
    }
    
    public var isWalletInstalled: Bool {
        guard let url = URL(string: "paytomat://") else { return false }
        return UIApplication.shared.canOpenURL(url)
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
    
    public func parseResult(from url: URL) -> PaytomatSDK.URLResult? {
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
    
    private func parseSuccess(action: SimpleWallet.Action,
                              queryItems: [URLQueryItem]) -> PaytomatSDK.URLResult {
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
                            queryItems: [URLQueryItem]) -> PaytomatSDK.URLResult {
        let errorCodeStr = queryItems.first(where: { $0.name == "errorCode" })?.value ?? ""
        let errorCode = ErrorCode(errorCodeStr)
        switch action {
        case .login:
            return .login(.error(errorCode.loginError))
        case .transfer:
            return .transfer(.error(errorCode.transferError))
        }
    }
    
    private func parseCancel(action: SimpleWallet.Action) -> PaytomatSDK.URLResult {
        switch action {
        case .login:
            return .login(.cancel)
        case .transfer:
            return .transfer(.cancel)
        }
    }
}
