//
//  NetworkResponse.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 2/14/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

enum ResponseError: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

// Http Network Response to output
struct NetworkResponse {
    
    static func fromNetworkResponse(_ response: URLResponse?, _ data: Data?, error: Error?) -> ResponseMapper {
        guard let httpURLResponse = response as? HTTPURLResponse else {
            return ResponseMapper(result: .failure(.unableToDecode), response: nil, data: data)
        }
        
        switch httpURLResponse.statusCode {
        case 200...300:
            return ResponseMapper(result: .success(()), response: httpURLResponse, data: data)
        case 401...500:
            return ResponseMapper(result: .failure(.authenticationError), response: httpURLResponse, data: data)
        case 501...599:
            return ResponseMapper(result: .failure(.badRequest), response: httpURLResponse, data: data)
        case 600:
            return ResponseMapper(result: .failure(.outdated), response: httpURLResponse, data: data)
        default:
            return ResponseMapper(result: .failure(.failed), response: httpURLResponse, data: data)
        }
    }
}
