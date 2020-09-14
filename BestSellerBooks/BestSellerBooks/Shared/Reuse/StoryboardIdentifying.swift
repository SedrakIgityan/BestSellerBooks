//
//  StoryboardIdentifying.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import UIKit

/// Enum responsible for specifying storyboards.
/// `When add some storyboard add it also here`
enum Storyboard: String {
    
    
    // MARK: - Cases -
    
    // --- Specify cases here ---
    case Main               = "Main" // Main storyboard
    case Launch             = "Launch" // Launch storyboard
    
    
    // MARK: - Properties -
    
    /// Instance for creating storyboard from cases by `rawValue`.
    /// `Warning` bundle is nil. For different bunldes please choose `correct bundle`.
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
    
    
    // MARK: - Functions -
    
    // --- Specify functions here ---
    
    
    // MARK: - ViewController Initializer -
    
    /// Generic method for getting specified view controller with one call.
    /// - parameter T: Swift generic type. Here `Current type viewController`.
    func instantiateFromStoryboard<T: UIViewController>() -> T? {
        // get a class name and demangle for classes in Swift
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last { /// Getting class name as string. Example 'BestSellerBooksdev.ExampleViewController'. See `NSStringFromClass`
            return self.instance.instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}
