//
//  StringToEndpoint.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/12/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import Foundation

struct StringToEndpoint {
    
    let urlString: String
    let endpoint: URLRequest
    
    init?(urlString: String) {
        self.urlString = urlString
        guard let urlComponents = URLComponents(string: urlString) else {
            print(Errors_API_Awakens.noURLStringPResent(message: "there was no valid URL string"))
            return nil
        }
        let url = urlComponents.url
        self.endpoint = URLRequest(url: url!)
    }
    
}
