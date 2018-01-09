//
//  PickerViewDataSource.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import UIKit

class CharacterPickerViewDataSource: NSObject, UIPickerViewDataSource {
    
    var data = [Character]()
    
    override init() {
        super.init()
    }
    
    func characterDataUpdate(with characters: [Character]) {
        data = characters
    }
    
    // MARK: Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
    }
    
    
}
