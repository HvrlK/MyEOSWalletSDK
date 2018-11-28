//
//  PaytomatSDKURLResult.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public extension PaytomatSDK {
    
    public enum URLResult {
        case login(LoginResult)
        case transfer(TransferResult)
    }
}
