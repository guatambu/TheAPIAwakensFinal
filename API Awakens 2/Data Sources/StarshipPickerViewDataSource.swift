//
//  StarshipPickerViewDataSource.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/5/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import UIKit

class StarshipPickerViewDataSource: NSObject, UIPickerViewDataSource {
        
    var data = [Starship]()
    
    override init() {
        super.init()
    }
    
    func starshipDataUpdate(with starships: [Starship]) {
        data = starships
    }
    
    // MARK: Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
