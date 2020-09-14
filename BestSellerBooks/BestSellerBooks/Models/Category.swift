//
//  Category.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct Category: Codable {
    let displayName: String
    let listImageURLString: String
    let updateState: String
   
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case listImageURLString = "list_image"
        case updateState = "updated"
        case books
    }
}
