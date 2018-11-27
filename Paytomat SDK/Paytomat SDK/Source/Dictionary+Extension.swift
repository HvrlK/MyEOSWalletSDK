//
//  Dictionary+Extension.swift
//  PaytomatSDK
//
//  Created by Alex Melnichuk on 11/26/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

extension Dictionary where Value == Any? {
    var withoutOptionalKeys: [Key: Any] {
        var dict: [Key: Any] = [:]
        for (k, v) in self {
            if let v = v {
                dict[k] = v
            }
        }
        return dict
    }
}
