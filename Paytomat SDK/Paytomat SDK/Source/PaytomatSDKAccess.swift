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
    var isWalletInstalled: Bool { get }
    @discardableResult
    func login(request: LoginRequest) -> Bool
    @discardableResult
    func transfer(request: TransferRequest) -> Bool
    func parseResult(from url: URL) -> URLResult?
}
