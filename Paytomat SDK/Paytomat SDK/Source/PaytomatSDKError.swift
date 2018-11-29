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
        /// Wallet seed phrase is not entered
        case noMnemonic
        /// EOS Account is not created by the wallet
        case noAccountExists
        /// Operation failed due to device being offline
        case offline
        /// EOS Symbol encoding failed
        case invalidSymbol
        /// EOS Recipient account is not encodable
        case invalidRecipientAccount
        /// Entered amount not decodable from String to Decimal or 0 or less
        case invalidAmount
        /// Insufficient token balance
        case notEnoughBalance
        /// Unable to parse model
        case parse
        /// Undetailed error has occured
        case unknown
    }
    
    public enum LoginError: Error {
        /// Wallet seed phrase is not entered
        case noMnemonic
        /// EOS Account is not created by the wallet
        case noAccountExists
        /// Operation failed due to device being offline
        case offline
        /// Unable to parse model
        case parse
        /// Undetailed error has occured
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
