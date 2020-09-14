//
//  HTTPClient.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 2/13/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - URLSessionProtocol -

/// Used for creating URLSessionInstance
protocol URLSessionProtocol {
    
    
    // MARK: - Functions -
    
    // Implement to create network request
    /// - parameter request: URLRequest to create request type.
    /// - parameter completionHandler: Closue for taking result of request. `Pass result with this property`
    func dataTask(with request: URLRequest, completionHandler: @escaping NetworkRouterCompletion) -> URLSessionDataTaskProtocol
}


// MARK: - URLSessionDataTaskProtocol -

protocol URLSessionDataTaskProtocol {
    func resume() // To start task
    func cancel() // To cancel task
}


// MARK: - URLSessionDataTaskProtocol -

/// Just extend will get real function if function interfaces same.
extension URLSessionDataTask: URLSessionDataTaskProtocol {}


// MARK: - URLSession -

extension URLSession: URLSessionProtocol {
    
    
    // MARK: - Functions -
    
    /// - parameter request: URLRequest to create request type.
    /// - parameter completionHandler: Closue for taking result of request. `Pass result with this property`
    func dataTask(with request: URLRequest, completionHandler: @escaping NetworkRouterCompletion) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

/// This is protocol for creating HTTP Client.
protocol NetworkRouter: class {
    
    
    // MARK: - Properties -
    
    /// This is used for creating session. `See URLSessionProtocol`
    var session: URLSessionProtocol { get }
    /// Type is generic to specify any EndPointType. `See associatedtype`
    associatedtype EndPoint: EndPointType
    /// For request and gettings [String: Any]
    /// - parameter route: Specify request.
    /// - parameter completion: Async response. `See typealias JsonResultCompletion`
    func requestJson(_ route: EndPoint, completion: @escaping JsonResultMapperCompletion)
    /// For request and gettings Data
    /// - parameter route: Specify request.
    /// - parameter completion: Async response. `See typealias DataRouterCompletion`
    func requestData(_ route: EndPoint, completion: @escaping DataRouterCompletion)
    /// Responsible only getting request with encoded state.
    /// - parameter route: Specify request info.
    func getEncodedUrlRequest(_ route: EndPoint) -> Result<URLRequest, Error>
    /// Cancel task
    func cancel()
}


// MARK: - Network Worker -

/// Not inhering manager class. `This is Network Layer`.
final class Router<EndPoint: EndPointType>: NetworkRouter {
    
    
    // MARK: - Properties -
    
    /// Accomplish tasks with this property
    internal var session: URLSessionProtocol
    internal var task: URLSessionDataTaskProtocol?
    
    
    // MARK: - -
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    
    // MARK: - Public Functions -
    
    // --- Use this methods from outside. ---
    
    /// `See NetworkRouter`
    func getEncodedUrlRequest(_ route: EndPoint) -> Result<URLRequest, Error> {
        do {
            /// Build only requset
            let request = try self.buildRequest(from: route)
            RequestLogger.log(request: request) // Print request anyway
            
            // If successful
            return .success(request)
        } catch { // Throws error
            return .failure(error)
        }
        
    }
    
    /// `See NetworkRouter`
    func requestJson(_ route: EndPoint, completion: @escaping JsonResultMapperCompletion) {
        self.request(route) { (responseMapper) in
            
            switch responseMapper.result { // Swift 5 Result type
            case .success:
                switch responseMapper.data { // If Success. To variants with data or without
                case .some(let data):
                    completion(JSONResponseMapper(result: .success(data.toJson()), response: responseMapper.response))
                case .none:
                    completion(JSONResponseMapper(result: .success([:]), response: responseMapper.response))
                }
            case .failure(let error): // Request failed. See `ResponseError`
                debugPrint("Error occured when request json description is", error)
                completion(JSONResponseMapper(result: .failure(error), response: responseMapper.response))
            }            
        }
    }
    
    /// `See NetworkRouter`
    func requestData(_ route: EndPoint, completion: @escaping DataRouterCompletion) {
        self.request(route) { (responseMapper) in
            
            switch responseMapper.result { // Swift 5 Result type
            case .success:
                switch responseMapper.data { // If Success. To variants with data or without
                case .some(let data):
                    completion(DataResponseMapper(result: .success(data), response: responseMapper.response))
                case .none:
                    completion(DataResponseMapper(result: .failed(.noData), response: responseMapper.response))
                }
            case .failure(let error): // Request failed. See `ResponseError`
                switch responseMapper.data {
                case .some(let data):
                    completion(DataResponseMapper(result: .failedWithData(error, data), response: responseMapper.response))
                case .none:
                    completion(DataResponseMapper(result: .failed(.noData), response: responseMapper.response))
                }
                debugPrint("Error occured when request json description is", error)
            }
        }
    }
    
    /// `See NetworkRouter`
    func cancel() {
        self.task?.cancel()
    }
    
    
    // MARK: - Private Functions -
    
    // --- This is private functions of network layer. ---
    /// Request with  session to network
    /// - parameter route: Pass request.
    /// - parameter completion: Response from URLSession. `See typealias NetworkRouterCompletion`
    /// Function pass completion only in `main thread`
    func request(_ route: EndPoint, completion: @escaping HttpURLResponseRouterCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            RequestLogger.log(request: request)

            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async { // Pass response in main thread
                    completion(NetworkResponse.fromNetworkResponse(response, data, error: error))
                }
            })
        } catch { // Error happened
            /// Cant create request. And response is `nil`
            ///
            DispatchQueue.main.async { // Pass response in main thread
                completion(ResponseMapper(result: .failure(.failed), response: nil, data: nil))
            }
        }
        
        self.task?.resume()
    }
    
    /// Create url request
    /// `Function throws error`. `See try catch`
    /// - parameter route: Get all info about request from route.
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        /// Added mutable url request with append base url to path. See `URLRequest`
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        /// Add http method
        request.httpMethod = route.httpMethod.rawValue
        /// Try catch block
        do {
            switch route.task {
            case .request: // Just add content-type to default
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestHeaders(let headers):
                self.addHeaders(headers, request: &request)
            case .requestParameters(let bodyEncoding):
                try self.configureParameters(bodyEncoding: bodyEncoding, request: &request)
                
            case .requestParametersAndHeaders(let bodyEncoding,
                                              let additionalHeaders):
                
                self.addHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyEncoding: bodyEncoding, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /// Added needed encodings to request
    /// `Function throws error`. `See try catch`
    /// - parameter bodyEncoding: `For adding ParameterEncoding and set type. See ParameterEncodingType`.
    /// - parameter request: `This is inout pass by &ref`. For modifying passed request
    fileprivate func configureParameters(bodyEncoding: ParameterEncodingType, request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request)
        } catch {
            throw error
        }
    }
    
    /// Added headers to request
    /// - parameter additionalHeaders: Specify headers to add. `See typealias Headers`
    /// - parameter request:`This is inout pass by &ref`. For modifying passed request
    fileprivate func addHeaders(_ additionalHeaders: Headers, request: inout URLRequest) {
        for (key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
