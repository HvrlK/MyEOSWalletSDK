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
        
    }
    
    public enum LoginError: Error {
        case mnemonicNotEntered
        case noAccountExists
    }
    
    public enum UnsupportedURL: Error {
        case unsupported
    }
}
