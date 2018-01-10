//
//  Character.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class Character: StarWarsEntity {
    // Name
    var name: String
    // Height
    var length: String
    // Mass
    var mass: String
    // Hair Color
    var hair_color: String
    // Skin Color
    var skin_color: String
    // Eye Color
    var eye_color: String
    // Birth Year
    var birth_year: String
    // Gender
    var gender: String
    // Homeworld
    var homeworld: String
    // Films
    var films: [Any]
    // Species
    var species: [Any]
    // Vehicles
    var vehicles: [Any]
    // Starships
    var starships: [Any]
    //  Last Edited Time Stamp
    var edited: String
    // Created Time Stamp
    var created: String
    // URL Location
    var url: String
    
    init?(json: [String: Any]) {
        struct Key {
            static let name = "name"
            static let length = "height"
            static let mass = "mass"
            static let hair_color = "hair_color"
            static let skin_color = "skin_color"
            static let eye_color = "eye_color"
            static let birth_year = "birth_year"
            static let gender = "gender"
            static let homeworld = "homeworld"
            static let films = "films"
            static let species = "species"
            static let vehicles = "vehicles"
            static let starships = "starships"
            static let edited = "edited"
            static let created = "created"
            static let url = "url"
        }
        guard let nameValue = json[Key.name] as? String,
            let lengthValue = json[Key.length] as? String,
            let massValue = json[Key.mass] as? String,
            let hairColorValue = json[Key.hair_color] as? String,
            let skinColorValue = json[Key.skin_color] as? String,
            let eyeColorValue = json[Key.eye_color] as? String,
            let birthYearValue = json[Key.birth_year] as? String,
            let genderValue = json[Key.gender] as? String,
            let homeworldValue = json[Key.homeworld] as? String,
            let filmsValue = json[Key.films] as? [Any],
            let speciesValue = json[Key.species] as? [Any],
            let vehiclesValue = json[Key.vehicles] as? [Any],
            let starshipsValue = json[Key.starships] as? [Any],
            let editedValue = json[Key.edited] as? String,
            let createdValue = json[Key.created] as? String,
            let urlValue = json[Key.url] as? String
            else { return nil }
        
        self.name = nameValue
        self.length = lengthValue
        self.mass = massValue
        self.hair_color = hairColorValue
        self.skin_color = skinColorValue
        self.eye_color = eyeColorValue
        self.birth_year = birthYearValue
        self.gender = genderValue
        self.homeworld = homeworldValue
        self.films = filmsValue
        self.species = speciesValue
        self.vehicles = vehiclesValue
        self.starships = starshipsValue
        self.edited = editedValue
        self.created = createdValue
        self.url = urlValue
    }
}




