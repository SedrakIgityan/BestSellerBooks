//
//  CategoryList.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

struct CategoryList: Decodable {
    let numberOfResults: Int
    let categorires: [Category]
    let previousDateString: String
    let currentDateString: String
    
    enum CodingKeys: String, CodingKey {
        case numberOfResults = "num_results"
        case results
        case categorires = "lists"
        case previousDateString = "previous_published_date"
        case currentDateString = "published_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        numberOfResults = try values.decode(Int.self, forKey: .numberOfResults)
        let results = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .results)
        self.previousDateString = try results.decode(String.self, forKey: .previousDateString)
        self.currentDateString = try results.decode(String.self, forKey: .currentDateString)
        self.categorires = try results.decode([Category].self, forKey: .categorires)
    }
}
