//
//  BuyItemCollectionViewCell.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/11/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

final class BuyItemCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var buyerImageView: UIImageView!
    @IBOutlet weak var buyerNameLabel: UILabel!
    
    
    // MARK: - Setups -
    
    func setup(_ viewModel: BuyerViewModel) {
        QRCodeGeneratorWorker.setQRCode(from: viewModel.qrImageURLString, imageView: buyerImageView) 
        self.buyerNameLabel.text = viewModel.buyerName
    }
}
