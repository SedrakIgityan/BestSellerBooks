//
//  ImageCacheCRUD.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

protocol ImageCacheActionType: Any {
    
    var configuration: ImageCachePipeline { get }
    
    /// Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    /// Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    /// Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    /// Removes all images from the cache
    func removeAllImagesFromCache()
    /// Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}
