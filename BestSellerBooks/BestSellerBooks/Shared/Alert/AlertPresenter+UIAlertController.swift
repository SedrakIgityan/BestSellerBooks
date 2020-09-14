//
//  AlertPresenter+UIAlertController.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 3/25/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

/// Responsible for presenting alert controller
extension AlertPresenter where Self: UIViewController {
    
    /// - parameter title: Title of alert
    /// - parameter message: Message of alert
    /// - parameter isPresented: Block of completion. Do actions when alert has just presented. `See typealias EmptyCompletion`
    /// - parameter completionHandler: Block of completion: Handle actions of alert. `See typealias AlertActionCompletion`
    func showAlert(title: String, message: String,
                   buttons: [AlertButtonText], isPresented: EmptyCompletion, completionHandler: AlertActionCompletion) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        buttons.forEach { (buttonText) in
            let alertAction = UIAlertAction(title: buttonText.rawValue, style: .default) { (action) in
                completionHandler?(buttonText)
            }
            
            controller.addAction(alertAction)
        }
        
        self.present(controller, animated: true, completion: isPresented)
    }
    
    /// Responsible for presenting action sheet
    /// - parameter title: Title of action sheet
    /// - parameter message: Message of action sheet
    /// - parameter buttons: Button of action sheet to show
    /// - parameter selectedButtonText: Give selected button to show with checkmark. `Please give with button text seperated`
    /// - parameter isPresented: Block of completion. Do actions when action sheet has just presented. `See typealias EmptyCompletion`
    /// - parameter completionHandler: Block of completion: Handle actions of action sheet. `See typealias ActionSheetActionCompletion`
    func showActionSheet(title: String, message: String, buttons: [AlertButtonText], selectedButtonText: AlertButtonText?, isPresented: EmptyCompletion, completionHandler: ActionSheetActionCompletion) {
        let actionSheetAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet).centered(self.view)
        /// Get whole buttons with selected button if exist
        /// Fill actions of alert controller
        /// Loop on array with index
        buttons.enumerated().forEach { (index, buttonText) in
            /// Check if one button is cancel
            /// If `Cancel` set correspoding `style`
            let style: UIAlertAction.Style = (buttonText == .some(.Cancel)) ? .cancel : .default
            
            /// Create alert action with style
            let alertAction = UIAlertAction(title: buttonText.rawValue, style: style) { (action) in
                /// Pass model
                
                /// If button is already selected
                if buttonText == selectedButtonText {
                    /// Pass as selected
                    completionHandler?(.alreadySelected)
                    
                    return
                }
                
                if buttonText == .Cancel {
                    /// Pass as canceled
                    completionHandler?(.cancel)
                    
                    return
                }
                
                /// If not
                /// Pass index with -1. `To vanish the selected button index`
                completionHandler?(.selected(button: buttonText))
            }
            
            /// Set appearance
            if buttonText == selectedButtonText {
                alertAction.setValue(true, forKey: "checked")
            }
            
            /// Add to controller
            actionSheetAlertController.addAction(alertAction)
        }
        
        /// Present controller
        self.present(actionSheetAlertController, animated: true, completion: isPresented)
    }
}


// MARK: - UIAlertController -

/// Responsible for making fixes for specific alert controll features
extension UIAlertController {
    
    /// Responsible for making alert centered pop up for `iPad`
    /// Without this app will be `crashed`in iPad
    /// - parameter superView: Specify superview as popover source view
    func centered(_ superview: UIView) -> UIAlertController {
        if let popoverController = self.popoverPresentationController {
            /// Set source of popover
            popoverController.sourceView = superview
            popoverController.sourceRect = superview.bounds
            
            /// Remove arrow of pop over
            popoverController.permittedArrowDirections = []
        }
        
        return self
    }
}
