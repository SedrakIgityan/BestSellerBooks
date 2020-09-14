//
//  BookListViewController.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityanvorgyan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible for viewcontroller input events
protocol BookListViewControllerInput: BookListPresenterOutput {
    
}

/// Responsible for view controller output events
protocol BookListViewControllerOutput: AnyObject {
    
    func fetchBooks()
    func fetchBook(index: Int)
    func fetchOrderTypes()
    func orderBy(action: AlertButtonText)
    func finishSearch()
    func startSearch()
    func search(with text: String)
}


// MARK: - View Controller -

final class BookListViewController: UIViewController {
    
    
    // MARK: - Properties -
    
    /// Search controller
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        
        controller.delegate = self
//        controller.definesPresentationContext = true
        controller.searchBar.delegate = self
        controller.searchResultsUpdater = self
        controller.searchBar.isTranslucent = false
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = true
        controller.searchBar.sizeToFit()
        
        return controller
    }()
    
    
    // MARK: - VIP -
    
    // Specify architecture-needed properties
    var output: BookListViewControllerOutput!
    var router: BookListRouterProtocol!
    
    
    // MARK: - DataSource -
    
    var bookViewModels: [BookListItemViewModel] = []
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var bookListTableView: UITableView!
    
    
    // MARK: - Initializers -
    
    static func instantiateFromStoryboard(books: [Book]) -> BookListViewController {
        let bookListViewController: BookListViewController = Storyboard.Main.instantiateFromStoryboard()!
        bookListViewController.configure(books: books)
        
        return bookListViewController
    }
    
    
    // MARK: - Configurator -
    
    private func configure(configurator: BookListConfigurator = BookListConfigurator.sharedInstance, books: [Book]) {
        configurator.configure(viewController: self, books: books)
    }
    
    
    // MARK: - Lify Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    
    // MARK: - Setup -
    
    /// Responsible for doing intial setups.
    private func setup() {
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        self.output.fetchBooks()
    }
    
    
    // MARK: - IBActions -
    
    @IBAction func byRankTapped(_ sender: UIButton) {
        self.output.fetchOrderTypes()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        self.present(searchController, animated: true, completion: { [weak self] in
            self?.output.startSearch()
        })
    }
}


// MARK: - ViewController Input IMPL -

/// Implementation of view controller input
extension BookListViewController: BookListViewControllerInput, AlertPresenter {
    
    func display(_ bookItemViewModelList: [BookListItemViewModel]) {
        self.bookViewModels = bookItemViewModelList
        self.bookListTableView.reloadData()
    }
    
    func displaySelectedBook(_ book: Book) {
        self.router.navigateDetails(book)
    }
    
    func displayOrderActionSheet(_ viewModel: OrderActionSheetViewModel) {
        self.presentActionSheet(viewModel: viewModel) { [weak self] (action) in
            switch action {
            case .alreadySelected: break
            case .selected(let buttonText):
                self?.output.orderBy(action: buttonText)
            case .cancel:
                break
            }
        }
    }
    
    func displayError(_ errorViewModel: ErrorViewModel) {
        self.present(viewModel: errorViewModel)
    }
}


// MARK: - UITableViewDataSource -

extension BookListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookItemTableViewCell: BookListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = self.bookViewModels[indexPath.row]
        
        bookItemTableViewCell.setup(viewModel)
        
        return bookItemTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - UITableViewDelegate -

extension BookListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            searchController.dismiss(animated: true, completion: nil)
        }
        self.output.fetchBook(index: indexPath.row)
    }
}


// MARK: - UISearchControllerDelegate -

extension BookListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.output.finishSearch()
    }
}


// MARK: - UISearchResultsUpdating -

extension BookListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text else {
            return
        }

        self.output.search(with: searchedText)
    }
}
