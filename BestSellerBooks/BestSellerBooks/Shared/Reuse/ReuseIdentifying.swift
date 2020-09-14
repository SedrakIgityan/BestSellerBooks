//
//  ReuseIdentifying.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


// MARK: - Protocol -


// MARK: - ReuseIdentifying -

/// Protocol responsible for getting reuse idenitfier
/// Protocol extends UIView. `Mean implement only UIView subclasses`
protocol ReuseIdentifying: UIView {
    /// Function to get identifier. `Static function`
    static func reuseIdentifierStorer() -> String
}


// MARK: - ReuseIdentifying extension -

/// Default implementation
/// Gets the class description name
extension ReuseIdentifying {
    
    static func reuseIdentifierStorer() -> String {
        let reuseIdentifier = String(describing: Self.self)
        return reuseIdentifier
    }
}

