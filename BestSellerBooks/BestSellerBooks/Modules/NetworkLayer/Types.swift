//
//  Parameters.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 2/13/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - Typealiases -

/// Simple typealiases
/// Tuple array of keys and objects. Use this when the order of items matter. `Please note that this will reduce the speed`.
public typealias OrderedParameters = [(key: String, object: Any)]
/// Just [String: Any]. Use this for giving parameters to request with no matter the order of items.
public typealias UnorderedParameters = [String: Any]
/// Just [String: String]. Use this for giving headers to request
public typealias Headers    = [String: String]
/// Comletion handler. For simple syntax of completion. Use this for giving json response.
public typealias JsonResultMapperCompletion = (_ response: JSONResponseMapper) -> ()
/// Comletion handler. For simple syntax of completion. Use this for gettings `URLSession` response.
typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()
/// Comletion handler. For simple syntax of completion from custom response handler.
typealias HttpURLResponseRouterCompletion = (_ response: ResponseMapper) -> ()
/// Comletion handler. For simple syntax of completion from custom response handler. Use thid for giving Data Response
typealias DataRouterCompletion = (_ response: DataResponseMapper) -> ()


// MARK: - Request info Protocol -

/// `Implement this protocol for giving info of your API Configurations`
/// Used for getting info about `requests`
protocol EndPointType {
    /// Specify base url of request
    var baseUrl: URL { get }
    /// Specify path of request
    var path: String { get }
    /// Specify method of request. `See HTTPMethod`
    var httpMethod: HTTPMethod  { get }
    /// Used for accomplishiong `network requests`.  `See HTTPTask`
    var task: HTTPTask { get }
    ///Used for specifying network headers.  `See typealias Headers`
    var headers: Headers { get }
}


// MARK: - Type enums -

/// Enum for http method used in requests
enum HTTPMethod: String {
    case Get    = "GET" // For Get request
    case Post   = "POST" // For Post request
    case Put    = "PUT" // For Put request
    case Patch  = "PATCH" // For Patch request
    case delete = "DELETE" // For delete request
}

/// Use this for giving parameters to request
public enum Parameters {
    case preservingOrder(OrderedParameters)
    case unordered(UnorderedParameters)
}

/// Enum for request process used
/// All actions done by HTTPTasks.
public enum HTTPTask {
    
    // Just plain request
    case request
    
    // Used for request with url and json parameters
    /// - parameter bodyEncoding: Set encoding type with corresponding asosociated typr. `See ParameterEncodingType`
    case requestParameters(bodyEncoding: ParameterEncodingType)
    
    // Used for request with url and headers
    /// - parameter headers: Specify headers. `See typealias Headers`
    case requestHeaders(headers: Headers)
    
    // Used for request with url and json and headers parameters
    /// - parameter bodyEncoding: Set encoding type with corresponding asosociated typr. `See ParameterEncodingType`
    /// - parameter headers: Specify headers. `See typealias Headers`
    case requestParametersAndHeaders(bodyEncoding: ParameterEncodingType, headers: Headers)
}

/// Network error for nil
public enum NetworkEncodingError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}


// MARK: - Mapped -

/// Structs to create response model.

// --- Specify Mappers here ---
public struct ResponseMapper {
    let result: Result<Void, ResponseError>
    let response: HTTPURLResponse?
    let data: Data?
}

public struct JSONResponseMapper {
    let result: Result<[String: Any], Error>
    let response: HTTPURLResponse?
}

public struct DataResponseMapper {
    let result: DataResponseResult
    let response: HTTPURLResponse?
}

enum DataResponseResult {
    case success(Data)
    case failed(ResponseError)
    case failedWithData(Error, Data)
}
