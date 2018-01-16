//
//  findBigAndSmall.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/10/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class FindBigAndSmall {
    
    var myDictionary: [String: Double] = [:]
    var smallestOne = ""
    var largestOne = ""
    
    func currentLengthDictionaryMaker(current array: [StarWarsEntity]) -> [String: Double] {
        
        var items = array
        var itemLengthDouble: Double = 0.00
        for item in items {
            /*guard let itemLengthDouble = Double(item.length) else {
                
                return myDictionary
            }*/
            var counter = 0
            if item.length != "unknown" {
                if let myDouble = Double(item.length) {
                    itemLengthDouble = myDouble
                    counter += 1
                } else {
                    print("found 'nil' for \(items[counter])")
                }
                
            } else {
                items.remove(at: counter)
                print("found 'unknown' as string value at \(items.count) while trying to make the dictionary in the currentLengthDictionaryMaker function")
                counter += 1
            }
            
            myDictionary.updateValue(itemLengthDouble, forKey: item.name)
        }
        return myDictionary
    }
    
    
    func findLargestAndSmallest(current dictionary: [String: Double]) {
        
        let minimum = dictionary.min { a, b in a.value < b.value }
        let maximum = dictionary.max { a, b in a.value < b.value }
        guard let smallest = minimum else {
            print("couldn't find smallest item")
            return
        }
        guard let largest = maximum else {
            print("couldn't find largest item")
            return
        }
        smallestOne = smallest.key
        largestOne = largest.key
        
        return
    }
    
    
}
