//
//  CharacterViewModel.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    
    // Character ID
    let id: Int
    // Character Name
    let name: String
    // Born
    let birth_year: String
    // Home
    let homeworld: String
    // Height
    let height: String
    // Eyes
    let eye_color: String
    // Hair
    let hair_color: String
    
    init(model: Character) throws{
        self.id = 1
        self.name = model.name
        self.birth_year = model.birth_year
        self.homeworld = model.homeworld
        do {
            guard let heightInt = Int(model.length) else {
                throw Errors_API_Awakens.stringNotInteger(message: "the value of this property is a String not an Integer")
            }
            self.height = "\(heightInt)"
        } catch Errors_API_Awakens.stringNotInteger {
            self.height = model.length
        }
        self.eye_color = model.eye_color
        self.hair_color = model.hair_color
    }
    
}


