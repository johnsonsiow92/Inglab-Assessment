//
//  APIService.swift
//  Inglab Assessment
//
//  Created by The Lorry Online on 24/10/2022.
//

import Foundation

enum APIError: Error {
    case invalidUrl, requestError, decodingError, statusNotOk
}

struct APIService {
    
    let BaseUrl = "https://my-json-server.typicode.com"
    
    func getUserList() async throws -> [UserItem] {
        
        guard let url = URL(string:  "\(BaseUrl)/johnsonsiow92/inglab-assessment-APIs/users") else{
            throw APIError.invalidUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIError.statusNotOk
        }
        
        guard let result = try? JSONDecoder().decode([UserItem].self, from: data) else {
            throw APIError.decodingError
        }
        
        return result
    }
    
}
