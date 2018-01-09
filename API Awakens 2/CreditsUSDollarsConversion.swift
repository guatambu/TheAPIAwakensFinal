//
//  CreditsUSDollarsConversion.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class CreditsUSDollarsConversion {
    
    func convertCreditsToUSDollars(_ costInCredits: Double, _ rate: Double) -> Double {
        let dollars = costInCredits * rate
        return dollars
    }
    
    func convertUSDollarsToCredits(_ costInDollars: Double, _ rate: Double) -> Double {
        let credits = costInDollars / rate
        return credits
    }
}
