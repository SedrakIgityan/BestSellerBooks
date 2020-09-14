//
//  Book.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct Book: Codable {
    let bookImageURLString: String
    let buyLinks: [BuyLink]
    let bookAuthor: String
    let bookTitle: String
    let rank: Int
    let bookDescription: String
    
    enum CodingKeys: String, CodingKey {
        case bookImageURLString = "book_image"
        case buyLinks = "buy_links"
        case bookAuthor = "author"
        case bookTitle = "title"
        case bookDescription = "description"
        case rank
    }
}
