//
//  BookDetailsPresenter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import Foundation


// MARK: - Presenter Input -

/// Responsible for presenter input events
protocol BookDetailsPresenterInput: BookDetailsInteractorOutput {
    
}


// MARK: - Presenter Output -

/// Responsible for presenter output events
protocol BookDetailsPresenterOutput: AnyObject {
    
    func displayBookDetails(_ viewModel: BookDetailsViewModel)
    func displayFetchBook(_ book: Book)
}


// MARK: - Presenter -

final class BookDetailsPresenter {
    private weak var output: BookDetailsPresenterOutput!
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Specify presenter output
    init(output: BookDetailsPresenterOutput) {
        self.output = output
    }
}


// MARK: - Presenter Input IMPL -

/// Implementation Presenter input
extension BookDetailsPresenter: BookDetailsPresenterInput {
    
    func presentBook(_ book: Book, attributedString: NSMutableAttributedString) {
        let bookDetailsViewModel = BookDetailsViewModel(authorName: book.bookAuthor,
                                                        description: attributedString,
                                                        imageURLString: book.bookImageURLString,
                                                        name: book.bookTitle)
        
        self.output.displayBookDetails(bookDetailsViewModel)
    }
    
    
    func presentToFetchBook(_ book: Book) {
        self.output.displayFetchBook(book)
    }
}
