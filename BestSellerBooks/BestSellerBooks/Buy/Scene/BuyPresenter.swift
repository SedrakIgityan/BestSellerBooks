//
//  BuyPresenter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import Foundation


// MARK: - Presenter Input -

/// Responsible for presenter input events
protocol BuyPresenterInput: BuyInteractorOutput {
    
}


// MARK: - Presenter Output -

/// Responsible for presenter output events
protocol BuyPresenterOutput: AnyObject {
    
    func display(buyers: [BuyerViewModel])
}


// MARK: - Presenter -

final class BuyPresenter {
    private weak var output: BuyPresenterOutput!
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Specify presenter output
    init(output: BuyPresenterOutput) {
        self.output = output
    }
}


// MARK: - Presenter Input IMPL -

/// Implementation Presenter input
extension BuyPresenter: BuyPresenterInput {
    
    func presentBuyerLinks(links: [BuyLink]) {
        let buyerViewModels = links.map({ BuyerViewModel(qrImageURLString: $0.urlString, buyerName: $0.name) })
        
        self.output.display(buyers: buyerViewModels)
    }
}
