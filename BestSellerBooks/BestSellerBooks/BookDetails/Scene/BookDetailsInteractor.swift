//
//  BookDetailsInteractor.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//

import UIKit


// MARK: - Interactor Input -

/// Responsible for interacto input events
protocol BookDetailsInteractorInput: BookDetailsViewControllerOutput {
    
}


// MARK: - Interactor Output -

/// Responsible for interactor output events
protocol BookDetailsInteractorOutput: AnyObject {
    
    func presentBook(_ book: Book, attributedString: NSMutableAttributedString)
    func presentToFetchBook(_ book: Book)
}


// MARK: - Interactor -

final class BookDetailsInteractor {
    
    private let output: BookDetailsInteractorOutput
    private let book: Book
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Pass output of interactor
    /// - parameter book: Specify book to fetch details
    init(output: BookDetailsInteractorOutput, book: Book) {
        self.output = output
        self.book = book
    }
}


// MARK: - Interactor Input IMPL -

/// Implement interactor input events
extension BookDetailsInteractor: BookDetailsInteractorInput {
    
    func fetchBookDetails() {
        let bookDescription = book.bookDescription
        let mostRepeatedCharacter = self.getMostRepeatedCharacter(bookDescription: bookDescription)
        
        let attributedString = NSMutableAttributedString(string: bookDescription,
                                                         attributes: nil)
        for (index, character) in bookDescription.enumerated() {
            if index == bookDescription.count - 1 {
                break
            }
            
            self.colorRepeatCharacter(index: index,
                                      character: character,
                                      mostRepeatedCharacter: mostRepeatedCharacter,
                                      attributedString: attributedString)
            
            self.colorCharactersAfterA(index: index,
                                       character: character,
                                       attributedString: attributedString)
        }
        
        self.output.presentBook(book, attributedString: attributedString)
    }
    
    func fetchBook() {
        self.output.presentToFetchBook(book)
    }
    
    
    private func colorRepeatCharacter(index: Int, character: Character, mostRepeatedCharacter: String.Element?, attributedString: NSMutableAttributedString) {
        if mostRepeatedCharacter == character {
            let range = NSRange(location: index, length: 1)
            
            let colorKey: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.red
            ]
            
            attributedString.addAttributes(colorKey, range: range)
        }
    }
    
    private func colorCharactersAfterA(index: Int,
                                       character: Character,
                                       attributedString: NSMutableAttributedString) {
        if character == "a" {
            print("get in a")
            let nextIndex = index + 1
            let range = NSRange(location: nextIndex, length: 1)
            let colorKey: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.green
            ]
            
            attributedString.addAttributes(colorKey, range: range)
        }
    }
    
    private func getMostRepeatedCharacter(bookDescription: String) -> String.Element? {
        let bookDescriptionWithoutSpaces = bookDescription.replacingOccurrences(of: " ", with: "")
        
        let mappedItems = bookDescriptionWithoutSpaces.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        let maxElement = counts.values.max()
        
        let mostRepeatedCharacter = counts.first(where: { $1 == maxElement })?.key
        
        return mostRepeatedCharacter
    }
}
 
