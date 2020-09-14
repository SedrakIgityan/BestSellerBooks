//
//  AlertPresenter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 2/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

/// AlertPresenter is a protocol for presenting errors
/// Implement this protocol to show alert in view controller
protocol AlertPresenter: AnyObject {

    /// Present an alert given an response view model
    ///
    /// - parameter viewModel: The view model for the response
    /// - parameter isPresented: Completion when alert presented. `See typealias EmptyCompletion`.
    /// - parameter completionHandler: Completion when alert action tapped. `See typealias AlertActionCompletion`.
    func present(viewModel: ResponseViewModelProtocol,
                 isPresented: EmptyCompletion, completionHandler: AlertActionCompletion)
    /// Present an action sheet given an response view model
    ///
    /// - parameter viewModel: The view model to show with action sheet. `See ActionSheetViewModelProtocol`
    /// - parameter isPresented: Completion when alert presented. `See typealias EmptyCompletion`.
    /// - parameter completionHandler: Completion when alert action tapped. `See typealias ActionSheetActionCompletion`.
    func presentActionSheet(viewModel: ActionSheetViewModelProtocol, isPresented: EmptyCompletion, completionHandler: ActionSheetActionCompletion)
}


/// Extension of AlertPresenter protocol for common view controller response handler
extension AlertPresenter where Self: UIViewController {

    /// Presents an status of response for a view controller using an alert
    ///
    /// - parameter viewModel: The view model for the response
    func present(viewModel: ResponseViewModelProtocol,
                 isPresented: EmptyCompletion = nil, completionHandler: AlertActionCompletion = nil) {
        // Show alert controller here
        self.showAlert(title: viewModel.title,
                       message: viewModel.message,
                       buttons: viewModel.buttonActions, isPresented: isPresented, completionHandler: completionHandler)
    }
    
    /// Presents an status of response for a view controller using an action sheet
    ///
    /// - parameter viewModel: The view model for the response
    func presentActionSheet(viewModel: ActionSheetViewModelProtocol,
                            isPresented: EmptyCompletion = nil,
                            completionHandler: ActionSheetActionCompletion = nil) {
        // Show action sheet here
        self.showActionSheet(title: viewModel.title,
                             message: viewModel.message,
                             buttons: viewModel.buttonActions,
                             selectedButtonText: viewModel.selectedActionSheetButton,
                             isPresented: isPresented, completionHandler: completionHandler)
    }
}
