//
//  BookListInteractor.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


// MARK: - Interactor Input -

/// Responsible for interacto input events
protocol BookListInteractorInput: BookListViewControllerOutput {
    
}


// MARK: - Interactor Output -

/// Responsible for interactor output events
protocol BookListInteractorOutput: AnyObject {
    
    func presentBooks(_ books: [Book])
    func presentOrderTypes(selectedActionSheetButton: AlertButtonText?)
    func presentError(_ error: AppError)
    func presentSelectedBook(_ book: Book)
}


// MARK: - Interactor -

final class BookListInteractor {
    
    private let output: BookListInteractorOutput
    private var books: [Book]
    private var searchedBooks: [Book]
    
    private var actuallyUsedBooks: [Book] {
        get {
            if isSearching {
                return searchedBooks
            }
            
            return books
        }
    }
    
    var selectedButtonText: AlertButtonText?
    var isSearching: Bool = false
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Pass output of interactor
    init(output: BookListInteractorOutput, books: [Book]) {
        self.output = output
        self.books = books
        self.searchedBooks = books
    }
}


// MARK: - Interactor Input IMPL -

/// Implement interactor input events
extension BookListInteractor: BookListInteractorInput {
    
    func fetchBooks() {
        self.output.presentBooks(self.actuallyUsedBooks)
    }
    
    func fetchOrderTypes() {
        self.output.presentOrderTypes(selectedActionSheetButton: selectedButtonText)
    }
    
    func orderBy(action: AlertButtonText) {
        self.selectedButtonText = action
        
        
        guard let rankType = RankType(rawValue: action.rawValue) else {
            return self.output.presentError(NetworkError(message: "Selected unknown rank."))
        }
        
        switch rankType {
        case .Author:
            self.books.sort(by: { $0.bookAuthor < $1.bookAuthor })
            self.fetchBooks()
        case .Title:
            self.books.sort(by: { $0.bookTitle < $1.bookTitle })
            self.fetchBooks()
        case .Rank:
            self.books.sort(by: { $0.rank < $1.rank })
            self.fetchBooks()
        }
    }
    
    func startSearch() {
        self.isSearching = true
    }
    
    func finishSearch() {
        self.isSearching = false
        self.searchedBooks = self.books
    }
    
    func search(with text: String) {
        if text.isEmpty {
            self.searchedBooks = self.books
            
            return self.fetchBooks()
        }
        
        self.searchedBooks = self.books.filter({ $0.bookTitle.lowercased().contains(text.lowercased()) })
        self.fetchBooks()
    }
    
    func fetchBook(index: Int) {
        let book = self.actuallyUsedBooks[index]
        
        self.output.presentSelectedBook(book)
    }
}
 
