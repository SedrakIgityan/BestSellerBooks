//
//  BookListTableViewCell.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

final class BookListTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    
    // MARK: - Setups -
    
    func setup(_ viewModel: BookListItemViewModel) {
        ImageLoadWorker.load(from: viewModel.bookImageURL, to: bookImageView)
        self.rankLabel.text = viewModel.rank
        self.authorNameLabel.text = viewModel.bookAuthorName
        self.bookTitleLabel.text = viewModel.bookName
    }
}
