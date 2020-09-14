//
//  CircledCornerView.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/11/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

final class CircledCornerView: UIView {

    
    // MARK: - Life Cycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.makeCircle()
    }
    
    
    // MARK: - Functions -
    
    private func makeCircle() {
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
