//
//  String+Extension.swift
//  PaytomatSDK
//
//  Created by Alex Melnichuk on 11/26/18.
//  Copyright © 2018 Baltic International Group OU. All rights reserved.
//

import Foundation

extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
