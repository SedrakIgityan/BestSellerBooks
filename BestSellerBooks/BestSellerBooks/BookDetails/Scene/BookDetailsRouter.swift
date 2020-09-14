//
//  BookDetailsRouter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible to describe routes
protocol BookDetailsRouterProtocol {
    
    /// Specify routes here
    func navigateToBuy(book: Book)
}


// MARK: - Router -

final class BookDetailsRouter: BookDetailsRouterProtocol {
    weak var viewController: BookDetailsViewController!

    
    // MARK: - Initializers -
    
    /// - parameter viewController: Specify viewcontroller
    init(viewController: BookDetailsViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: Routing
    
    func navigateToBuy(book: Book) {
        let buyViewController = BuyViewController.instantiateFromStoryboard(book: book)
        
        viewController.navigationController?.pushViewController(buyViewController, animated: true)
    }
}
