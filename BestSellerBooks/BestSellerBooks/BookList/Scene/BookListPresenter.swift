//
//  BookListPresenter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import Foundation


// MARK: - Presenter Input -

/// Responsible for presenter input events
protocol BookListPresenterInput: BookListInteractorOutput {
    
}


// MARK: - Presenter Output -

/// Responsible for presenter output events
protocol BookListPresenterOutput: AnyObject {
    
    func display(_ bookItemViewModelList: [BookListItemViewModel])
    func displaySelectedBook(_ book: Book)
    func displayOrderActionSheet(_ viewModel: OrderActionSheetViewModel)
    func displayError(_ errorViewModel: ErrorViewModel)
}


// MARK: - Presenter -

final class BookListPresenter {
    private weak var output: BookListPresenterOutput!
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Specify presenter output
    init(output: BookListPresenterOutput) {
        self.output = output
    }
}


// MARK: - Presenter Input IMPL -

/// Implementation Presenter input
extension BookListPresenter: BookListPresenterInput {
    
    func presentBooks(_ books: [Book]) {
        let bookViewModelList = books.map({ BookListItemViewModel(book: $0) })
        
        self.output.display(bookViewModelList)
    }
    
    func presentSelectedBook(_ book: Book) {
        self.output.displaySelectedBook(book)
    }
    
    func presentOrderTypes(selectedActionSheetButton: AlertButtonText?) {
        let orderActionSheetViewModel = OrderActionSheetViewModel(selectedActionSheetButton: selectedActionSheetButton, buttonActions: [.Author, .Title, .Rank, .Cancel])
        
        self.output.displayOrderActionSheet(orderActionSheetViewModel)
    }
    
    func presentError(_ error: AppError) {
        let errorViewModel = ErrorViewModel(error: error)
        
        self.output.displayError(errorViewModel)
    }
}
