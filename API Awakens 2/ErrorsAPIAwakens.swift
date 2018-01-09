//
//  ErrorsAPIAwakens.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

enum Errors_API_Awakens: Error {
    case stringNotInteger(message: String)
    case stringNotDouble(message: String)
    case requestFailed(message: String)
    case responseUnsuccessful(message: String)
    case invalidData(message: String)
    case jsonConversionFailure(message: String)
    case noJSONData(message:String)
    case invalidURL(message: String)
    case jsonParsingFailure(message: String)
    
}
