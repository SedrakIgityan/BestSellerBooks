//
//  BuyInteractor.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


// MARK: - Interactor Input -

/// Responsible for interacto input events
protocol BuyInteractorInput: BuyViewControllerOutput {
    
}


// MARK: - Interactor Output -

/// Responsible for interactor output events
protocol BuyInteractorOutput: AnyObject {
    
    func presentBuyerLinks(links: [BuyLink])
}


// MARK: - Interactor -

final class BuyInteractor {
    
    private var output: BuyInteractorOutput!
    private let qrCodeWorker: QRCodeGeneratorWorkerProtocol
    private let book: Book
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Pass output of interactor
    init(output: BuyInteractorOutput,
         book: Book,
         qrCodeWorker: QRCodeGeneratorWorkerProtocol = QRCodeGeneratorWorker()) {
        self.output = output
        self.book = book
        self.qrCodeWorker = qrCodeWorker
    }
}


// MARK: - Interactor Input IMPL -

/// Implement interactor input events
extension BuyInteractor: BuyInteractorInput {
    
    func fetchBuyInfo() {
        self.output.presentBuyerLinks(links: book.buyLinks)
    }
}
 
