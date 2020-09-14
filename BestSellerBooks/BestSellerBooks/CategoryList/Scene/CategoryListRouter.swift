//
//  CategoryListRouter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible to describe routes
protocol CategoryListRouterProtocol {
    
    /// Specify routes here
    func navigateToBookList(_ books: [Book])
}


// MARK: - Router -

final class CategoryListRouter: CategoryListRouterProtocol {
    weak var viewController: CategoryListViewController!

    
    // MARK: - Initializers -
    
    /// - parameter viewController: Specify viewcontroller
    init(viewController: CategoryListViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: Routing
    
    func navigateToBookList(_ books: [Book]) {
        let bookListViewController: BookListViewController = BookListViewController.instantiateFromStoryboard(books: books)
        
        viewController.navigationController?.pushViewController(bookListViewController, animated: true)
    }
}
