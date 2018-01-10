//
//  MetricBritishUnitsConversion.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class MetricBritishConversion {
    
    // 1 yard = 0.9144 meter
    // 1 meter = 1.09361 yards
    
    func metersToYards(_ meters: Double) -> Double {
        let yards = (round(10 * (meters * 1.09361))/10)
        return yards
    }
    
    func yardsToMeters(_ yards: Double) -> Double {
        
        let meters = (round(10 * (yards * 0.9144))/10)
        return meters
    }
    
}
