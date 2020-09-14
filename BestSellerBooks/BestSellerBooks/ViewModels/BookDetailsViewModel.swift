//
//  BookDetailsViewModel.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct BookDetailsViewModel {
    let authorName: String
    let bookDescription: NSAttributedString
    let bookImageURL: URL
    let bookName: String
    
    
    init(authorName: String,
         description: NSAttributedString,
         imageURLString: String,
         name: String) {
        self.authorName = authorName
        self.bookDescription = description
        self.bookImageURL = URL(string: imageURLString)!
        self.bookName = name
    }
}
