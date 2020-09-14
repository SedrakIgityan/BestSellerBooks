//
//  CategoryListViewController.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible for viewcontroller input events
protocol CategoryListViewControllerInput: CategoryListPresenterOutput {
    
}

/// Responsible for view controller output events
protocol CategoryListViewControllerOutput: AnyObject {
    
    func fetchCategoryList()
    func fetchBooks(index: Int)
}


// MARK: - View Controller -

final class CategoryListViewController: UIViewController {
    
    
    // MARK: - Properties -
    
    
    // MARK: - VIP -
    
    // Specify architecture-needed properties
    var output: CategoryListViewControllerOutput!
    var router: CategoryListRouterProtocol!
    
    
    // MARK: - Initializers -
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configure()
    }
    
    
    // MARK: - Configurators -
    
    private func configure(configurator: CategoryListConfigurator = CategoryListConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var categoryListTableView: UITableView!
    
    
    // MARK: - Data -
    
    var categoryViewModels: [CategoryViewModel] = []
    
    
    // MARK: - Lify Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    
    // MARK: - Setup -
    
    /// Responsible for doing intial setups.
    private func setup() {
        self.output.fetchCategoryList()
    }
}


// MARK: - ViewController Input IMPL -

/// Implementation of view controller input
extension CategoryListViewController: CategoryListViewControllerInput, AlertPresenter {
    
    func displayError(_ errorViewModel: ErrorViewModel) {
        self.present(viewModel: errorViewModel)
    }
    
    func displayCategories(_ categoryViewModelList: [CategoryViewModel]) {
        self.categoryViewModels = categoryViewModelList
        self.categoryListTableView.reloadData()
    }
    
    func displayBooks(_ books: [Book]) {
        self.router.navigateToBookList(books)
    }
}


// MARK: - UITableViewDataSource -

extension CategoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = categoryViewModels[indexPath.row]
        
        cell.setup(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewModels.count
    }
}


// MARK: - CategoryListViewController -

extension CategoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output.fetchBooks(index: indexPath.row)
    }
}
