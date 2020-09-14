//
//  QRCodeGeneratorWorker.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/11/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

protocol QRCodeGeneratorWorkerProtocol {
    func generateQRCode(from string: String, completionHandler: @escaping (UIImage?) -> ())
    func setQRCode(from string: String, imageView: UIImageView)
    static func setQRCode(from string: String, imageView: UIImageView)
}

final class QRCodeGeneratorWorker: QRCodeGeneratorWorkerProtocol {
    
    let workerQueue: DispatchQueue
    
    static let shreadInstance = QRCodeGeneratorWorker()
    
    init(queue: DispatchQueue = DispatchQueue(label: "com.bestsellerBooks.QR", qos: .userInitiated)) {
        self.workerQueue = queue
    }
    
    static func setQRCode(from string: String, imageView: UIImageView) {
        self.shreadInstance.setQRCode(from: string, imageView: imageView)
    }
    
    func setQRCode(from string: String, imageView: UIImageView) {
        self.generateQRCode(from: string) { (image) in
            imageView.image = image
        }
    }
    
    func generateQRCode(from string: String, completionHandler: @escaping (UIImage?) -> ()) {
        workerQueue.async {
            let data = string.data(using: String.Encoding.ascii)

            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)

                if let output = filter.outputImage?.transformed(by: transform) {
                    DispatchQueue.main.async {
                        completionHandler(UIImage(ciImage: output))
                    }
                    
                    return
                }
            }

            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
        
    }
}
