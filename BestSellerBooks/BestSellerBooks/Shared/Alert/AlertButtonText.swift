//
//  AlertButtonText.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 3/25/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

/// Typealiases for handling alert actions
typealias AlertActionCompletion              = ((AlertButtonText) -> ())?
typealias ActionSheetActionCompletion        = ((ActionSheetButtonAction) -> ())?


// MARK: - Enum -

/// Enum for specifying actions of alerts
/// Specify any text you want to be presented in alert
enum AlertButtonText: String {
    case Done = "Done"
    case Title = "Title"
    case Author = "Author"
    case Rank = "Rank"
    case Cancel = "Cancel"
}

/// Enum for action sheet actions
/// `Use this with action sheet alert`
enum ActionSheetButtonAction {
    case alreadySelected
    case selected(button: AlertButtonText)
    case cancel
}
