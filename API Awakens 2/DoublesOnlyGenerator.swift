//
//  DoublesOnlyGenerator.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

extension String {
    var doublesOnly: String {
        let doubles = self.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression, range:nil)
        return doubles
    }
}
