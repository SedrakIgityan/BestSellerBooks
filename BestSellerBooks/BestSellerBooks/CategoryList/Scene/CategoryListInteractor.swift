//
//  CategoryListInteractor.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//

import Foundation


// MARK: - Interactor Input -

/// Responsible for interacto input events
protocol CategoryListInteractorInput: CategoryListViewControllerOutput {
    
}


// MARK: - Interactor Output -

/// Responsible for interactor output events
protocol CategoryListInteractorOutput: AnyObject {
    func presentError(_ error: NetworkError)
    func presentList(_ list: CategoryList)
    func presentBookList(categoryList: CategoryList, index: Int)
}


// MARK: - Interactor -

final class CategoryListInteractor {
    
    private let output: CategoryListInteractorOutput
    private let networkWorker: NetworkWorkerProtocol
    
    var categoryList: CategoryList?
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Pass output of interactor
    init(output: CategoryListInteractorOutput,
         networkWorker: NetworkWorkerProtocol = NetworkWorker()) {
        self.output = output
        self.networkWorker = networkWorker
    }
}


// MARK: - Interactor Input IMPL -

/// Implement interactor input events
extension CategoryListInteractor: CategoryListInteractorInput {
    
    func fetchCategoryList() {
        self.networkWorker.fetchCategories { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let categoryList = try JSONDecoder().decode(CategoryList.self, from: data)
                    
                    self?.categoryList = categoryList
                    self?.output.presentList(categoryList)
                } catch {
                    self?.output.presentError(.init(message: "Can not get list. List is in incorrect format"))
                }
            case .failure(let error):
                self?.output.presentError(error)
            }
        }
    }
    
    func fetchBooks(index: Int) {
        guard let categoryList = categoryList else {
            return
        }
        
        self.output.presentBookList(categoryList: categoryList, index: index)
    }
}
 
