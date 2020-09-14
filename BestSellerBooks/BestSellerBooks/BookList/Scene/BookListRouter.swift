//
//  BookListRouter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible to describe routes
protocol BookListRouterProtocol {
    
    /// Specify routes here
    func navigateDetails(_ book: Book)
}


// MARK: - Router -

final class BookListRouter: BookListRouterProtocol {
    weak var viewController: BookListViewController!

    
    // MARK: - Initializers -
    
    /// - parameter viewController: Specify viewcontroller
    init(viewController: BookListViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: Routing
    
    func navigateDetails(_ book: Book) {
        let bookDetailsViewController = BookDetailsViewController.instantiateFromStoryboard(book: book)
        
        viewController.navigationController?.pushViewController(bookDetailsViewController, animated: true)
    }
}
