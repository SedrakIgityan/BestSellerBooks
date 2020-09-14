//
//  OrderActionSheetViewModel.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct OrderActionSheetViewModel: ActionSheetViewModelProtocol {
    
    var selectedActionSheetButton: AlertButtonText?
    
    var title: String = "Order By"
    
    var message: String = "Do you want order list?"
    
    var buttonActions: [AlertButtonText]
}
