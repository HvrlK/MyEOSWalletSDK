//
//  PaytomatSDKResult.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public extension PaytomatSDK {
    
    public typealias LoginResult = Result<LoginSuccess, LoginError>
    public typealias TransferResult = Result<TransferSuccess, TransferError>
    
    public enum Result<ResultType, ErrorType> {
        case success(ResultType)
        case error(ErrorType)
        case cancel
    }
    
    public struct LoginSuccess {
        public let accountName: String
    }
    
    public struct TransferSuccess {
        public let transactionId: String
    }
    
}
