//
//  MyEOSWalletSDKURLResult.swift
//  MyEOSWallet SDK
//
//  Created by Vitalii Havryliuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public extension MyEOSWalletSDK {
    
    public enum URLResult {
        case login(LoginResult)
        case transfer(TransferResult)
    }
}
