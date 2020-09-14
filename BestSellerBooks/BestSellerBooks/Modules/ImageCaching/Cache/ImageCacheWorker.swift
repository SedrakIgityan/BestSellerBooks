//
//  ImageCacheWorker.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

final class ImageCacheWorker {
    
    
    // MARK: - Properties -
    
    
    // MARK: - Caches -
    
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = configuration.countLimit
        return cache
    }()
    
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = configuration.memoryLimit
        return cache
    }()
    
    
    // MARK: - Multithread -
    
    private let lock = NSLock()
    
    
    // MARK: - Cache configuration -
    
    internal let configuration: ImageCachePipeline

    
    // MARK: - Initializers -
    
    /// - parameter configuration: Set configuration of image cache. `By default` ImageCachePipeline.defaultConfiguration
    init(configuration: ImageCachePipeline = ImageCachePipeline.defaultConfiguration) {
        self.configuration = configuration
    }
}


// MARK: - ImageCache Helper Methods -

extension ImageCacheWorker {
    
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }
}


// MARK: - ImageCache CRUD -

extension ImageCacheWorker: ImageCacheActionType {
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decodedImage, forKey: url as AnyObject)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
    }

    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImagesFromCache() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    
}
