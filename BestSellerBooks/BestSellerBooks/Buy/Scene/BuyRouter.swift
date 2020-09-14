//
//  BuyRouter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible to describe routes
protocol BuyRouterProtocol {
    
    /// Specify routes here
    //
}


// MARK: - Router -

final class BuyRouter: BuyRouterProtocol {
    weak var viewController: BuyViewController!

    
    // MARK: - Initializers -
    
    /// - parameter viewController: Specify viewcontroller
    init(viewController: BuyViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: Routing
    
    //
}
