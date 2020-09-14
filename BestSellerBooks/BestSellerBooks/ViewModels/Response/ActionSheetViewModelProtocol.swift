//
//  ActionSheetViewModelProtocol.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - ActionSheetViewModelProtocol -

// Gives abstract info of response
protocol ActionSheetViewModelProtocol: ResponseViewModelProtocol {
    
    
    // MARK: - Properties to override -
    
    /// Provides short info about response
    var selectedActionSheetButton: AlertButtonText? { get set }
}
