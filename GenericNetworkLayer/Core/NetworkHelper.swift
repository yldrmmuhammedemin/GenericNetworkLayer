//
//  NetworkHelper.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation

enum HTTPMethods:String{
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes:String, Error{
    case invalidData = "invalid data"
    case invalidURL = "invalid url"
    case generalError = "Error"
}
class NetworkHelper{
    // MARK: - Singleton and URL declaration
    static let shared = NetworkHelper()
    
    let baseURL = "https://jsonplaceholder.typicode.com/"
    
    let header = ["Auth":"Bearer "]
    
}
