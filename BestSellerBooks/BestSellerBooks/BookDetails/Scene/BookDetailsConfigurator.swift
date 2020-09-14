//
//  BookDetailsConfigurator.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit


// MARK: BookDetailsConfigurator

/// BookDetailsConfigurator is a class responsible for configuring the VIP scene pathways for BookDetailsViewController.
final class BookDetailsConfigurator {
    
    /// Singleton instance of BookDetailsConfigurator
    static let sharedInstance = BookDetailsConfigurator()
    
    
    // MARK: - Configuration

    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: BookDetailsViewController,
                   book: Book) {
        let router = BookDetailsRouter(viewController: viewController)
        let presenter = BookDetailsPresenter(output: viewController)
        let interactor = BookDetailsInteractor(output: presenter, book: book)

        viewController.output = interactor
        viewController.router = router
    }
}
