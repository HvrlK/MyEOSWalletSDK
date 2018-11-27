//
//  PaytomatSDKSimpleWallet.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public extension PaytomatSDK {
    
    public typealias LoginRequest = SimpleWallet.LoginRequest
    public typealias TransferRequest = SimpleWallet.TransferRequest
    
    public class SimpleWallet {
        enum Action: String {
            case login = "login"
            case transfer = "transfer"
        }
        enum ProtocolName: String {
            case paytomat = "Paytomat"
        }
    }
}

extension PaytomatSDK.SimpleWallet {
    
    public struct LoginRequest: ToDictionaryConvertible {
        private struct Keys {
            static let appName = "dappName"
            static let appIcon = "dappIcon"
            static let appVersion = "dappVersion"
            static let appDescription = "loginMemo"
            static let loginUrl = "loginUrl"
            static let action = "action"
            static let uuID = "uuID"
            static let callbackUrl = "callback"
        }
        
        public let appName: String
        public let appIcon: String?
        public let appVersion: String?
        public let appDescription: String?
        public let uuID: String
        public let loginUrl: String
        public let callbackUrl: String?
        
        public init(appName: String,
                    appIcon: String?,
                    appVersion: String?,
                    appDescription: String?,
                    uuID: String,
                    loginUrl: String,
                    callbackUrl: String?) {
            self.appName = appName.trimmed()
            self.appIcon = appIcon?.trimmed()
            self.appVersion = appVersion?.trimmed()
            self.appDescription = appDescription?.trimmed()
            self.uuID = uuID.trimmed()
            self.loginUrl = loginUrl.trimmed()
            self.callbackUrl = callbackUrl?.trimmed()
        }
        
        func asDictionary() -> [String : Any?] {
            return [
                Keys.appName: appName,
                Keys.appIcon: appIcon,
                Keys.appVersion: appVersion,
                Keys.appDescription: appDescription,
                Keys.uuID: uuID,
                Keys.loginUrl: loginUrl,
                Keys.callbackUrl: callbackUrl,
                Keys.action: Action.login.rawValue
            ]
        }
    }
    
    struct LoginResponse {
        
    }
    
    public struct TransferRequest: ToDictionaryConvertible {
        
        private struct Keys {
            static let appName = "dappName"
            static let appIcon = "dappIcon"
            static let appVersion = "dappVersion"
            static let appDescription = "desc"
            static let to = "to"
            static let amount = "amount"
            static let contract = "contract"
            static let symbol = "symbol"
            static let precision = "precision"
            static let memo = "dappData"
            static let action = "action"
            static let callbackUrl = "callback"
        }
        
        public let appName: String
        public let appIcon: String?
        public let appVersion: String?
        public let appDescription: String?
        public let to: String
        public let amount: Decimal
        public let contract: String
        public let symbol: String
        public let precision: UInt8
        public let memo: String?
        public let callbackUrl: String?
        
        public init(appName: String,
                    appIcon: String?,
                    appVersion: String?,
                    appDescription: String?,
                    to: String,
                    amount: Decimal,
                    contract: String,
                    symbol: String,
                    precision: UInt8,
                    memo: String?,
                    callbackUrl: String?) {
            guard amount >= 0 else {
                preconditionFailure("TransferRequest.init amount cannot be negative")
            }
            self.appName = appName.trimmed()
            self.appIcon = appIcon?.trimmed()
            self.appVersion = appVersion?.trimmed()
            self.appDescription = appDescription?.trimmed()
            self.to = to.trimmed()
            self.amount = amount
            self.contract = contract.trimmed()
            self.symbol = symbol.trimmed()
            self.precision = precision
            self.memo = memo?.trimmed()
            self.callbackUrl = callbackUrl?.trimmed()
        }
        
        func asDictionary() -> [String : Any?] {
            return [
                Keys.appName: appName,
                Keys.appIcon: appIcon,
                Keys.appVersion: appVersion,
                Keys.appDescription: appDescription,
                Keys.to: to,
                Keys.amount: amount.description,
                Keys.contract: contract,
                Keys.symbol: symbol,
                Keys.precision: precision,
                Keys.memo: memo,
                Keys.callbackUrl: callbackUrl,
                Keys.action: Action.transfer.rawValue
            ]
        }
        
    }
}

