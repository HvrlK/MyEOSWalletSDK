//
//  DictionaryConvertible.swift
//  PaytomatSDK
//
//  Created by Alex Melnichuk on 11/26/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation


protocol FromDictionaryConvertible {
    init?(dict: [String: Any])
}

protocol ToDictionaryConvertible {
    func asDictionary() -> [String: Any?]
}

protocol DictionaryConvertible: ToDictionaryConvertible, FromDictionaryConvertible {
    
}

extension ToDictionaryConvertible {
    func jsonData() -> Data {
        guard let json = try? JSONSerialization.data(withJSONObject: asDictionary(), options: []) else {
            return Data()
        }
        return json
    }
    
    func jsonString() -> String {
        return String(data: jsonData(), encoding: .utf8) ?? ""
    }
    
    func paytomatUrl() -> URL? {
        guard var components = URLComponents(string: "paytomat://eos.io") else { return nil }
        let queryItem = URLQueryItem(name: "param", value: jsonString())
        components.queryItems = [queryItem]
        return components.url
    }
}
