//
//  StarWarsAPIClient.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

class StarWarsAPIClient {
    
    let downloader = JSONDownloader()
    let findBigAndSmall = FindBigAndSmall()
    
    let session = URLSession.shared
    
    var charactersEndpoint = SWAPI.people(page: nil)
    var starshipsEndpoint = SWAPI.spaceships(page: nil)
    var vehiclesEndpoint = SWAPI.vehicles(page: nil)
    
    var pageNumber = 2
    
    var allVehiclesJSON = [String: Any]()
    var allStarshipsJSON = [String: Any]()
    var allPeopleJSON = [String: Any]()
    
    var allDownloadedPeople = [Character]()
    var allDownloadedStarships = [Starship]()
    var allDownloadedVehicles = [Vehicle]()
    
    var allDownloadedPeopleDictionary: [String: Double] = [:]
    var allDownloadedStarshipsDictionary: [String: Double] = [:]
    var allDownloadedVehiclesDictionary: [String: Double] = [:]

    
    typealias VehiclesCompletionHandler = ([Vehicle], Errors_API_Awakens?) -> Void
    typealias StarshipsCompletionHandler = ([Starship], Errors_API_Awakens?) -> Void
    typealias CharactersCompletionHandler = ([Character], Errors_API_Awakens?) -> Void
 
    
    func getCharacters(with starWarsEntityURLPath: Endpoint, completionHandler completion: @escaping CharactersCompletionHandler) {
        let task = downloader.jsonTask(with: charactersEndpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    self.findBigAndSmall.currentLengthDictionaryMaker(current: self.allDownloadedPeople)
                    self.findBigAndSmall.findLargestAndSmallest(current: self.findBigAndSmall.myDictionary)
                    completion([], Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 46?"))
                    print(Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 46?"))
                    
                    return
                }
                self.allPeopleJSON = json
                guard let results = self.allPeopleJSON["results"] as? [[String: Any]] else {
                    completion([], .jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    print(Errors_API_Awakens.jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    return
                }
                let people: [Character] = results.flatMap { Character(json: $0) }
                let sortedPeople: [Character] = people.sorted(by: {$1.name > $0.name})
                self.allDownloadedPeople.append(contentsOf: sortedPeople)
                let next = json["next"]
                if next != nil {
                    self.charactersEndpoint = SWAPI.people(page: "\(self.pageNumber)")
                    self.getCharacters(with: self.charactersEndpoint, completionHandler: completion)
                    self.pageNumber += 1
                } else {
                    self.charactersEndpoint = SWAPI.people(page: nil)
                    print("endpoint has been reset to: \(self.charactersEndpoint)")
                    self.pageNumber = 2
                    print("\(self.pageNumber)")
                    self.allPeopleJSON = [:]
                }
                self.allDownloadedPeople = self.allDownloadedPeople.sorted(by: {$1.name > $0.name})
                completion(self.allDownloadedPeople, nil)
            }
        }
        task.resume()
    }
    
    
    
    func getStarships(with starWarsEntityURLPath: Endpoint, completionHandler completion: @escaping StarshipsCompletionHandler) {
        let task = downloader.jsonTask(with: starshipsEndpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    self.findBigAndSmall.currentLengthDictionaryMaker(current: self.allDownloadedStarships)
                    self.findBigAndSmall.findLargestAndSmallest(current: self.findBigAndSmall.myDictionary)
                    completion([], Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 87?"))
                    print(Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 87?"))
                    return
                }
                self.allStarshipsJSON = json
                guard let results = self.allStarshipsJSON["results"] as? [[String: Any]] else {
                    completion([], .jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    print(Errors_API_Awakens.jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    return
                }
                let starships: [Starship] = results.flatMap { Starship(json: $0) }
                let sortedStarships: [Starship] = starships.sorted(by: {$1.name > $0.name})
                self.allDownloadedStarships.append(contentsOf: sortedStarships)
                let next = json["next"]
                if next != nil {
                    self.starshipsEndpoint = SWAPI.spaceships(page: "\(self.pageNumber)")
                    self.getStarships(with: self.starshipsEndpoint, completionHandler: completion)
                    self.pageNumber += 1
                } else {
                    self.starshipsEndpoint = SWAPI.spaceships(page: nil)
                    print("endpoint has been reset to: \(self.starshipsEndpoint)")
                    self.pageNumber = 2
                    print("\(self.pageNumber)")
                    self.allStarshipsJSON = [:]
                }
                self.allDownloadedStarships = self.allDownloadedStarships.sorted(by: {$1.name > $0.name})
                completion(sortedStarships, nil)
            }
        }
        task.resume()
    }
    
    
    func getVehicles(with starWarsEntityURLPath: Endpoint, completionHandler completion: @escaping VehiclesCompletionHandler) {
        let task = downloader.jsonTask(with: vehiclesEndpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    self.findBigAndSmall.currentLengthDictionaryMaker(current: self.allDownloadedVehicles)
                    self.findBigAndSmall.findLargestAndSmallest(current: self.findBigAndSmall.myDictionary)
                    completion([], Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 124?"))
                    print(Errors_API_Awakens.noJSONData(message: "no JSON Data - failed at StarWarsAPIClient.swift line 124?"))
                    return
                }
                self.allVehiclesJSON = json
                guard let results = self.allVehiclesJSON["results"] as? [[String: Any]] else {
                    completion([], .jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    print(Errors_API_Awakens.jsonParsingFailure(message: "failed attempt to parse JSON data - JSON data does not contain 'results'"))
                    return
                }
                let vehicles: [Vehicle] = results.flatMap { Vehicle(json: $0) }
                let sortedVehicles: [Vehicle] = vehicles.sorted(by: {$1.name > $0.name})
                self.allDownloadedVehicles.append(contentsOf: sortedVehicles)
                let next = json["next"]
                if next != nil {
                    self.vehiclesEndpoint = SWAPI.vehicles(page: "\(self.pageNumber)")
                    self.getVehicles(with: self.vehiclesEndpoint, completionHandler: completion)
                    self.pageNumber += 1
                } else {
                    self.vehiclesEndpoint = SWAPI.vehicles(page: nil)
                    print("endpoint has been reset to: \(self.vehiclesEndpoint)")
                    self.pageNumber = 2
                    print("\(self.pageNumber)")
                    self.allVehiclesJSON = [:]
                }
                self.allDownloadedVehicles = self.allDownloadedVehicles.sorted(by: {$1.name > $0.name})
                completion(sortedVehicles, nil)
            }
        }
        task.resume()
    }
    
}

