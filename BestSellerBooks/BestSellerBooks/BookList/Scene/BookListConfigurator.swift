//
//  BookListConfigurator.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit


// MARK: BookListConfigurator

/// BookListConfigurator is a class responsible for configuring the VIP scene pathways for BookListViewController.
final class BookListConfigurator {
    
    /// Singleton instance of BookListConfigurator
    static let sharedInstance = BookListConfigurator()
    
    
    // MARK: - Configuration

    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: BookListViewController, books: [Book]) {
        let router = BookListRouter(viewController: viewController)
        let presenter = BookListPresenter(output: viewController)
        let interactor = BookListInteractor(output: presenter, books: books)

        viewController.output = interactor
        viewController.router = router
    }
}
