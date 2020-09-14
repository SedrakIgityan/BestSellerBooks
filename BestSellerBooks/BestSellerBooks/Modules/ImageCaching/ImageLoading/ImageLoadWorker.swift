//
//  ImageLoadWorker.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

typealias ImageLoadResultCompletion = (Result<UIImage, Error>) -> ()

protocol ImageLoadWorkerProtocol {
    func load(from url: URL, to imageView: UIImageView)
    static func load(from url: URL, to imageView: UIImageView)
}

final class ImageLoadWorker: ImageLoadWorkerProtocol {
    
    let urlSession: URLSession
    var cache: ImageCacheActionType
    
    private static let imageWorker = ImageLoadWorker()
    
    init(urlSession: URLSession = URLSession.shared, cache: ImageCacheActionType = ImageCacheWorker()) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    static func load(from url: URL, to imageView: UIImageView) {
        imageWorker.load(from: url, to: imageView)
    }
    
    func load(from url: URL, to imageView: UIImageView) {
        self.loadImage(from: url) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    imageView.image = image
                case .failure(let error):
                    debugPrint("Error happend while loading image \(error)")
                    imageView.image =  self?.cache.configuration.placeholderImage
                }
            }
        }
    }
    
    private func loadImage(from url: URL, completion: @escaping ImageLoadResultCompletion) {
        if let image = cache[url] {
            return completion(.success(image))
        }
        
        self.urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            if let unwrapError = error {
                completion(.failure(unwrapError))
            }
            
            if let imageData = data {
                guard let image = UIImage(data: imageData) else {
                    return completion(.failure(ImageCacheError.parseError))
                }
                
                completion(.success(image))
                self?.cache[url] = image
            }
        }.resume()
    }
}
