//
//  ImageCachePipeline.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

/// Responsible for setting configuration for image cache
struct ImageCachePipeline {
    let countLimit: Int
    let memoryLimit: Int
    let placeholderImage: UIImage?

    static let defaultConfiguration = ImageCachePipeline(countLimit: 100, memoryLimit: 1024 * 1024 * 100, placeholderImage: nil) // 100 MB
}
