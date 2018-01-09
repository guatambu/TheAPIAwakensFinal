//
//  StarshipViewModel.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

struct StarshipViewModel {
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
    var starship_class: String
    // HyperDrive Rating
    var hyperdriveRating: String
    // MGLT
    var mglt: String
    // Consumables
    var consumables: String
    // Make
    var make: String
    // URL Location
    var url: String
    
    init(model: Starship) throws {
        guard let length_Double = Double(model.length) else {
            throw Errors_API_Awakens.stringNotDouble(message: "the value of this property is a String not a Double")
        }
        self.length = "\(length_Double) m"
        self.pilots = model.pilots
        self.crew = model.crew
        self.name = model.name
        self.films = model.films
        self.model = model.model
        do {
            guard let costInCreditsInt = Int(model.cost_in_credits) else {
                throw Errors_API_Awakens.stringNotInteger(message: "the value of this property is a String not an Integer")
            }
            self.cost_in_credits = "\(costInCreditsInt)"
        } catch Errors_API_Awakens.stringNotInteger {
            self.cost_in_credits = model.cost_in_credits
        }
        self.cargoCapacity = model.cargoCapacity
        self.maxAtmospheringSpeed = model.maxAtmospheringSpeed
        self.edited = model.edited
        self.created = model.created
        self.passengers = model.passengers
        self.starship_class = model.starship_class
        self.hyperdriveRating = model.hyperdriveRating
        self.mglt = model.mglt
        self.consumables = model.consumables
        self.make = model.make
        self.url = model.url
    }
}




