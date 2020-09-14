//
//  NetworkWorkerTypes.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 2/14/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - Enum -

/// Need to specify type of network
enum NetworkEnvironment {
    // Be careful this will be used for network connection.
    
    case QA          // When use for test
    case Production  // When use for upload to production
    case Development // When use for upload to development
}


/// Need to specify requests
public enum NetworkWorkerApi {
    
    
    // MARK: - Statics in enum -
    
    static let ServerUrlProd = "https://api.nytimes.com/svc/books/v3"   // URL for network requests to prod
    static let ServerUrlQA   = "http://localhost:8080/"                 // URL for network requests for test
    static let ServerUrlDev  = "https://api.nytimes.com/svc/books/v3"   // URL for network requests to dev
    static let FrontUrlProd  = "https://api.nytimes.com/svc/books/v3"   // URL for redirection
    static let FrontUrlQA    = "https://api.nytimes.com/svc/books/v3"   // URL for redirection for test
    static let FrontUrlDev   = "https://api.nytimes.com/svc/books/v3"   // URL for redirection to dev
    
    
    // MARK: - Request types -
    
    // --- Specify all request types here --- //
    case FetchCategories
}


// MARK: - EndPointType -

/// Implement `EndPointType` to add info for network layer
extension NetworkWorkerApi: EndPointType {
    
    
    // MARK: - Custom properties -
    
    /// For specifying base url as `string`.
    var baseUrlString: String {
        switch NetworkWorker.environment {
        case .Development:
            return NetworkWorkerApi.ServerUrlDev
        case .Production:
            return NetworkWorkerApi.ServerUrlProd
        case .QA:
            return NetworkWorkerApi.ServerUrlQA
        }
    }
    
    
    // MARK: - Protocol Implemented properties -
    
    /// Specify network base url
    /// If network invalid function `throw fatalError`
    var baseUrl: URL {
        /// Create url from string
        guard let url = URL(string: baseUrlString) else { fatalError("baseURL could not be configured.") }
        
        return url
    }
    
    /// Specify endpoint paths for requests.
    var path: String {
        switch self {
        case .FetchCategories:
            return "/lists/overview.json"
        }
    }
    
    /// Specify application header used ing app
    /// Example `Add authorization token here`.
    var headers: Headers {
        /// Header dict
        /// "Authorization" - Set authentication token
        /// TODO: Change this to current authorization token
        let headers = [ "Content-Type": "application/json" ]
        
        return headers
    }
    
    /// Specify requests and to do tasks here.
    var task: HTTPTask {
        /// Do requests here
        switch self {
        case .FetchCategories:
            let dict = [
                "api-key": "HmAb01GemP3S1VWFCujh4xO85YGjM4UP"
            ]
            
            return .requestParameters(bodyEncoding: .url(parameters: .unordered(dict)))
        }
    }
    
    /// Specify method of url requests.
    var httpMethod: HTTPMethod {
        switch self {
        case .FetchCategories:
            return .Get
        }
    }
}
