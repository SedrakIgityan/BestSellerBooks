//
//  BookDetailsViewController.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible for viewcontroller input events
protocol BookDetailsViewControllerInput: BookDetailsPresenterOutput {
    
}

/// Responsible for view controller output events
protocol BookDetailsViewControllerOutput: AnyObject {
    
    func fetchBookDetails()
    func fetchBook()
}


// MARK: - View Controller -

final class BookDetailsViewController: UIViewController {
    
    
    // MARK: - Properties -
    
    
    // MARK: - VIP -
    
    // Specify architecture-needed properties
    var output: BookDetailsViewControllerOutput!
    var router: BookDetailsRouterProtocol!
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookAuthorNameLabel: UILabel!
    
    
    // MARK: - Initializers -
    
    static func instantiateFromStoryboard(book: Book) -> BookDetailsViewController {
        let bookListViewController: BookDetailsViewController = Storyboard.Main.instantiateFromStoryboard()!
        bookListViewController.configure(book: book)
        
        return bookListViewController
    }
    
    
    // MARK: - Configurator -
    
    private func configure(configurator: BookDetailsConfigurator = BookDetailsConfigurator.sharedInstance,
                           book: Book) {
        configurator.configure(viewController: self, book: book)
    }
    
    
    // MARK: - Lify Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    
    // MARK: - Setup -
    
    /// Responsible for doing intial setups.
    private func setup() {
        self.setupContent()
    }
    
    private func setupContent() {
        self.output.fetchBookDetails()
    }
    
    
    // MARK: - IBActions -
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        self.output.fetchBook()
    }
}


// MARK: - ViewController Input IMPL -

/// Implementation of view controller input
extension BookDetailsViewController: BookDetailsViewControllerInput {
    
    func displayBookDetails(_ viewModel: BookDetailsViewModel) {
        ImageLoadWorker.load(from: viewModel.bookImageURL, to: self.bookImageView)
        self.bookAuthorNameLabel.text = viewModel.authorName
        self.bookDescriptionLabel.attributedText = viewModel.bookDescription
        self.bookTitleLabel.text = viewModel.bookName
    }
    
    func displayFetchBook(_ book: Book) {
        self.router.navigateToBuy(book: book)
    }
}
