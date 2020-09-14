//
//  Cell+Reusable.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


extension UITableViewCell: ReuseIdentifying {} // POP UITableViewCell reuse identifier
extension UICollectionViewCell: ReuseIdentifying {} // POP UICollectionViewCell reuse identifier

extension UITableView {

    /// Dequeue reusable table view cell cell with generic method
    /// - parameter indexPath: Indexpath of cell
    /// - parameter T: T is type of table view cell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifierStorer(), for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

    /// Register Programatic Cell
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifierStorer())
    }

    /// Register Xib cell
    func registerNib<T: UITableViewCell>(_ :T.Type, in bundle: Bundle? = nil) {
        let nib = UINib(nibName: T.reuseIdentifierStorer(), bundle: bundle)

        register(nib, forCellReuseIdentifier: T.reuseIdentifierStorer())
    }
}

extension UICollectionView {

    /// Dequeue reusable collection view cell cell with generic method
    /// - parameter indexPath: Indexpath of cell
    /// - parameter T: T is type of collection view cell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifierStorer(), for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell")
        }

        return cell
    }

    /// Register Programatic Cell
    func register<T: UICollectionViewCell>(_ :T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifierStorer())
    }
    
    /// Register Xib cell
    func registerNib<T: UICollectionViewCell>(_ :T.Type, in bundle: Bundle? = nil) {
        let nib = UINib(nibName: T.reuseIdentifierStorer(), bundle: bundle)

        register(nib, forCellWithReuseIdentifier: T.reuseIdentifierStorer())
    }
}
