//
//  URLEncoding.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 2/13/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - Protocol -

/// `This is global protocol for all encodings`.
public protocol ParameterEncoding {
    /// Request for encoding
    /// - parameter urlRequest: `This is inout pass by &ref`. For modifying passed request
    /// - parameter parameters: Specify parameter to include in request
    /// `Function throws error`. `See try catch`
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}


// MARK: - Enum -

/// Responsible for calling outside of class and handle encoding type
public enum ParameterEncodingType {
    
    
    // MARK: - Cases -
    
    case url(parameters: Parameters) // URL Encoding
    case json(parameters: UnorderedParameters) // JSON Encoding
    
    
    // MARK: - Functions -
    
    /// `Function throws error`. `See try catch`
    /// - parameter urlRequest: `This is inout pass by &ref`. For modifying passed request
    public func encode(urlRequest: inout URLRequest) throws {
        do {
            var encoding: ParameterEncoding!
            var parameters: Parameters! // Set parameter
            
            switch self {
            case .json(let jsonParameters):
                encoding = JSONEncoding()
                parameters = .unordered(jsonParameters)
            case .url(let urlParameters):
                encoding = URLParameterEncoding()
                parameters = urlParameters
            }
            
            try encoding.encode(urlRequest: &urlRequest, with: parameters)
        } catch {
            throw error
        }
    }
}


// MARK: - Struct -

/// Encdoings are created with structs

/// Responsible for url encoding with `form`
public struct URLParameterEncoding: ParameterEncoding {
    
    
    // MARK: - Encode -
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkEncodingError.missingURL }
        
        /// Check if parameter isn't empty
        /// Create url component. `See URLComponents`
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) {
            Self.appendQueryItems(urlComponents: &urlComponents, parameters: parameters, urlRequest: &urlRequest) // For adding queries
            
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    
    // MARK: - Helper methods -
    
    /// Responsible for adding quesry items
    /// - parameter urlComponents: `This is inout pass by &ref`. For modifying passed urlcomponents
    /// - parameter parameters: Specify parameters to add
    /// - parameter urlComponents: `This is inout pass by &ref`. For setting urlcomponents to its
    static func appendQueryItems(urlComponents: inout URLComponents, parameters: Parameters, urlRequest: inout URLRequest) {
        urlComponents.queryItems = [URLQueryItem]() // Set to default as init. See `Array`
        
        switch parameters {
        case .preservingOrder(let items):
            self.appendQueryItemsOrdered(urlComponents: &urlComponents, parameters: items, urlRequest: &urlRequest)
        case .unordered(let items):
            self.appendQueryItemsUnordered(urlComponents: &urlComponents, parameters: items, urlRequest: &urlRequest)
        }
    }
    
    // Same function but for different type
    static func appendQueryItemsOrdered(urlComponents: inout URLComponents, parameters: OrderedParameters, urlRequest: inout URLRequest) {
        for (key,value) in parameters { // get key as dict key and value as dict value
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)) // Add query item.
            urlComponents.queryItems?.append(queryItem) // add to query item array
        }
        urlRequest.url = urlComponents.url // Set request url as urlComponents url
    }
    
    static func appendQueryItemsUnordered(urlComponents: inout URLComponents, parameters: UnorderedParameters, urlRequest: inout URLRequest) {
        for (key,value) in parameters { // get key as dict key and value as dict value
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)) // Add query item.
            urlComponents.queryItems?.append(queryItem) // add to query item array
        }
        urlRequest.url = urlComponents.url // Set request url as urlComponents url
    }
}

/// Responsible for json encoding with `application/json`
public struct JSONEncoding: ParameterEncoding {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            switch parameters {
            /// `No need of ordered collection`
            ///  Preserving order don't matter
            /// Parameters send by json
            case .preservingOrder(_): break
            case .unordered(let parameters): // Json encoding
                let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonAsData
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil { // Set type to application/json
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            }
        } catch {
            throw error
        }
    }
}

