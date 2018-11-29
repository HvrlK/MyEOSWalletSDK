//
//  PaytomatSDKError.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public extension PaytomatSDK {
    public enum TransferError: Error {
        case noMnemonic
        case noAccountExists
        case offline
        case invalidSymbol
        case invalidRecipientAccount
        case invalidAmount
        case notEnoughBalance
        case parse
        case unknown
    }
    
    public enum LoginError: Error {
        case offline
        case noMnemonic
        case noAccountExists
        case parse
        case unknown
    }
    
    enum ErrorCode: Int {
        case noMnemonic = 0
        case noEosAccount = 1
        case offline = 2
        case invalidSymbol = 3
        case invalidAmount = 4
        case invalidRecipientAccount = 5
        case notEnoughBalance = 6
        case general = 2147483647 // 2^32 / 2 - 1
        
        init(_ string: String) {
            guard let intValue = Int(string) else {
                self = .general
                return
            }
            self.init(intValue)
        }
        
        init(_ value: Int) {
            self = ErrorCode(rawValue: value) ?? .general
        }
        
        var loginError: LoginError {
            switch self {
            case .noMnemonic:
                return .noMnemonic
            case .offline:
                return .offline
            case .noEosAccount:
                return .noAccountExists
            case .invalidSymbol,
                 .invalidAmount,
                 .invalidRecipientAccount,
                 .notEnoughBalance,
                 .general:
                return .unknown
            }
        }
        
        var transferError: TransferError {
            switch self {
            case .noMnemonic:
                return .noMnemonic
            case .offline:
                return .offline
            case .noEosAccount:
                return .noAccountExists
            case .notEnoughBalance:
                return .notEnoughBalance
            case .invalidSymbol:
                return .invalidSymbol
            case .invalidAmount:
                return .invalidAmount
            case .invalidRecipientAccount:
                return .invalidRecipientAccount
            case .general:
                return .unknown
            }
        }
    }

}
