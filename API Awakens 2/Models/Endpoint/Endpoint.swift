//
//  Endpoint.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum SWAPI {
    case films(page: String?)
    case people(page: String?)
    case planets(page: String?)
    case spaceships(page: String?)
    case species(page: String?)
    case vehicles(page: String?)
}

extension SWAPI: Endpoint {
    var base: String {
        return "https://swapi.co"
    }
    
    var path: String {
        switch self {
        case .films: return "/api/films/"
        case .people: return "/api/people/"
        case .planets: return "/api/planets/"
        case .spaceships: return "/api/starships/"
        case .species: return "/api/species/"
        case .vehicles: return "/api/vehicles/"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .films(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
            
        case .people(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
            
        case .planets(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
            
        case .spaceships(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
            
        case .species(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
            
        case .vehicles(let page):
            var result = [URLQueryItem]()
            
            if let page = page {
                let pageNumber = URLQueryItem(name: "page", value: page)
                result.append(pageNumber)
            }
            return result
        }
    }

}






