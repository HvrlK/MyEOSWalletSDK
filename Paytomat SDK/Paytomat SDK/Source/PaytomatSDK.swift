//
//  PaytomatSDK.swift
//  Paytomat SDK
//
//  Created by Alex Melnichuk on 11/24/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

public final class PaytomatSDK {
    
    public static var shared: PaytomatSDK {
        guard let shared = _shared else {
            preconditionFailure("PaytomatSDK must be initialized with PaytomatSDK.setup(configuration:) before accessing shared instance")
        }
        return shared
    }
    
    private static var _shared: PaytomatSDK? = nil
    
    public static func setup(configuration: Configuration) {
        _shared = PaytomatSDK(configuration: configuration)
    }
    
    // MARK: Public methods
   
    // MARK: Module methods
    
    // MARK: Private methods
    
    private init(configuration: Configuration) {
        
    }
}

// MARK: PaytomatSDK+Configuration

public extension PaytomatSDK {
    public struct Configuration {
        public init() {
            
        }
    }
}
