//
//  BookListItemViewModel.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct BookListItemViewModel {
    let bookImageURL: URL
    let bookName: String
    let bookAuthorName: String
    let rank: String
    
    init(book: Book) {
        self.bookImageURL = URL(string: book.bookImageURLString)!
        self.bookName = book.bookTitle
        self.bookAuthorName = book.bookAuthor
        self.rank = book.rank.description
    }
}
