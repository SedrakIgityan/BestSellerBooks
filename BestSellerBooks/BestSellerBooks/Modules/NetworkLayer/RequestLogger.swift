//
//  RequestLogger.swift
//  NetworkLayer
//
//  Created by Sedrak Igityan on 2018/03/11.
//  Copyright © 2018 Sedrak Igityan. All rights reserved.
//

import Foundation

/// Responsible for logging network work
final class RequestLogger {
    
    
    // MARK: - Functions -
    
    // --- Specify static functions ---
    /// Function for logging request content.
    /// - parameter request: URLRequest to print
    static func log(request: URLRequest) {
        
        debugPrint("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { debugPrint("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? "" // Get url as string
        let urlComponents = NSURLComponents(string: urlAsString) // Converts to NSURLComponents. `See NSURLComponents`
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : "" // Get method if exist
        let path = "\(urlComponents?.path ?? "")" // Get endpoint path if exist
        let query = "\(urlComponents?.query ?? "")" // Get queries if exist
        let host = "\(urlComponents?.host ?? "")" // Get host if exist
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """ // This is print property. Added url method and host
        for (key,value) in request.allHTTPHeaderFields ?? [:] { // Get http header item
            logOutput += "\(key): \(value) \n" // Add http header item to log output
        }
        if let body = request.httpBody { // Get http body if exist
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")" // Get http body as string. See `utf8 encoding`.
        }
        
        // Print all output
        debugPrint(logOutput)
    }
    
    /// Print response
    /// - parameter response: Given response to print
    static func log(response: URLResponse) {}
}
