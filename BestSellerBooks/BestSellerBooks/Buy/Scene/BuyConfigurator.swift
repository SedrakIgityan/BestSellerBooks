//
//  BuyConfigurator.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit


// MARK: BuyConfigurator

/// BuyConfigurator is a class responsible for configuring the VIP scene pathways for BuyViewController.
final class BuyConfigurator {
    
    /// Singleton instance of BuyConfigurator
    static let sharedInstance = BuyConfigurator()
    
    
    // MARK: - Configuration

    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: BuyViewController,
                   book: Book) {
        let router = BuyRouter(viewController: viewController)
        let presenter = BuyPresenter(output: viewController)
        let interactor = BuyInteractor(output: presenter, book: book)

        viewController.output = interactor
        viewController.router = router
    }
}
