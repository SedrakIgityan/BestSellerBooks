//
//  ErrorViewModel.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/8/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct ErrorViewModel: ResponseViewModelProtocol {
    var title: String = "Error"
    
    var message: String
    
    var buttonActions: [AlertButtonText] = [.Done]
    
    
    // MARK: - Initializers -
    
    /// - parameter error: Specify error to get message
    init(error: AppError) {
        self.message = error.message
    }
}
