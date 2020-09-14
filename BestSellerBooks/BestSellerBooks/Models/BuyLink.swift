//
//  BuyLink.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct BuyLink: Codable {
    let name: String
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}
