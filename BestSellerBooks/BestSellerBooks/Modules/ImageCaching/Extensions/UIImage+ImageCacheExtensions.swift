//
//  UIImage+ImageCacheExtensions.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

/// Responsible for encdoing and decoding images
extension UIImage {
    
    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        
        return UIImage(cgImage: decodedImage)
    }
    
    var diskSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    }
}
