//
//  CategoryListConfigurator.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit


// MARK: CategoryListConfigurator

/// CategoryListConfigurator is a class responsible for configuring the VIP scene pathways for CategoryListViewController.
final class CategoryListConfigurator {
    
    /// Singleton instance of CategoryListConfigurator
    static let sharedInstance = CategoryListConfigurator()
    
    
    // MARK: - Configuration

    /// Configures the VIP scene with pathways between router, view controller, interactor and presenter
    ///
    /// - parameter viewController: The view controller
    func configure(viewController: CategoryListViewController) {
        let router = CategoryListRouter(viewController: viewController)
        let presenter = CategoryListPresenter(output: viewController)
        let interactor = CategoryListInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
