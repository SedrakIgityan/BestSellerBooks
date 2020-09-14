//
//  NetworkError.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct NetworkError: AppError {
    /// Error message. `See AppError`
    var message: String
    
    
    // MARK: - Initializers -
    
    /// Get network error setting image.
    /// - parameter message: Specify error message
    init(message: String) {
        self.message = message
    }
}
