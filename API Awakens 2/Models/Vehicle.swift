//
//  Vehicle.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class Vehicle: StarWarsEntity {
    // Length
    var length: String
    // Pilots
    var pilots: [Any]
    // Crew
    var crew: String
    // Name
    var name: String
    // Films
    var films: [Any]
    // Model
    var model: String
    // Cost
    var cost_in_credits: String
    // Cargo Capacity
    var cargoCapacity: String
    // Maximum Atmosphering Speed
    var maxAtmospheringSpeed: String
    //  Last Edited Time Stamp
    var edited: String
    // Created Time Stamp
    var created: String
    // Passengers
    var passengers: String
    // Class
    var vehicle_class: String
    // Consumables
    var consumables: String
    // Make
    var make: String
    // URL Location
    var url: String
    
    /*
     init(
     name: String,
     make: String,
     costInCredits: String,
     length: String,
     vehicleClass: String,
     crew: String
     ) {
     self.name = name
     self.make = make
     self.costInCredits = costInCredits
     self.length = length
     self.vehicleClass = vehicleClass
     self.crew = crew
     
     
     "length": 10.4,
     "pilots": <__NSArray0 0x604000007d60>(
     
     )
     ,
     "crew": 1,
     "name": T-16 skyhopper,
     "films": <__NSSingleObjectArrayI 0x604000008db0>(
     https:"//swapi.co/api/films/1/"
     )
     ,
     "model": T-16 skyhopper,
     "cost_in_credits": 14500,
     "cargo_capacity": 50,
     "max_atmosphering_speed": 1200,
     "edited": 2014-12-22T18:21:15.552614Z,
     "created": 2014-12-10T16:01:52.434000Z,
     "passengers": 1,
     "vehicle_class": repulsorcraft,
     "manufacturer": Incom Corporation,
     "consumables": 0,
     "url": https:"//swapi.co/api/vehicles/6/"
     
     }
     */
    init?(json: [String: Any]) {
        struct Key {
            static let length = "length"
            static let pilots = "pilots"
            static let crew = "crew"
            static let name = "name"
            static let films = "films"
            static let model = "model"
            static let cost_in_credits = "cost_in_credits"
            static let cargoCapacity = "cargo_capacity"
            static let maxAtmospheringSpeed = "max_atmosphering_speed"
            static let edited = "edited"
            static let created = "created"
            static let passengers = "passengers"
            static let vehicle_class = "vehicle_class"
            static let consumables = "consumables"
            static let make = "manufacturer"
            static let url = "url"
        }
        guard let lengthValue = json[Key.length] as? String,
            let pilotsValue = json[Key.pilots] as? [Any],
            let crewValue = json[Key.crew] as? String,
            let nameValue = json[Key.name] as? String,
            let filmsValue = json[Key.films] as? [Any],
            let modelValue = json[Key.model] as? String,
            let costInCreditsValue = json[Key.cost_in_credits] as? String,
            let cargoCapacityValue = json[Key.cargoCapacity] as? String,
            let maxAtmospheringSpeedValue = json[Key.maxAtmospheringSpeed] as? String,
            let editedValue = json[Key.edited] as? String,
            let createdValue = json[Key.created] as? String,
            let passengersValue = json[Key.passengers] as? String,
            let vehicleClassValue = json[Key.vehicle_class] as? String,
            let consumablesValue = json[Key.consumables] as? String,
            let makeValue = json[Key.make] as? String,
            let urlValue = json[Key.url] as? String
            else { return nil }
        
        self.length = lengthValue
        self.pilots = pilotsValue
        self.crew = crewValue
        self.name = nameValue
        self.films = filmsValue
        self.model = modelValue
        self.cost_in_credits = costInCreditsValue
        self.cargoCapacity = cargoCapacityValue
        self.maxAtmospheringSpeed = maxAtmospheringSpeedValue
        self.edited = editedValue
        self.created = createdValue
        self.passengers = passengersValue
        self.vehicle_class = vehicleClassValue
        self.consumables = consumablesValue
        self.make = makeValue
        self.url = urlValue
    }
}





