//
//  CategoryTableViewCell.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryUpdateStateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // MARK: - Setup -
    
    func setup(_ viewModel: CategoryViewModel) {
        self.categoryTitleLabel.text = viewModel.categoryTitle
        self.categoryUpdateStateButton.setTitle(viewModel.categoryUpdateState, for: .normal)
        self.dateLabel.text = String(format: "%@ | %@", viewModel.oldDate, viewModel.currentDate)
        
        ImageLoadWorker.load(from: viewModel.categoryImageURL, to: self.categoryImageView)
    }
    
    
    // MARK: - IBActions -
    
    
}
