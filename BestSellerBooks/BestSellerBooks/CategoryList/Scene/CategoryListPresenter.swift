//
//  CategoryListPresenter.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import Foundation


// MARK: - Presenter Input -

/// Responsible for presenter input events
protocol CategoryListPresenterInput: CategoryListInteractorOutput {
    
}


// MARK: - Presenter Output -

/// Responsible for presenter output events
protocol CategoryListPresenterOutput: AnyObject {
    func displayError(_ errorViewModel: ErrorViewModel)
    func displayCategories(_ categoryViewModelList: [CategoryViewModel])
    func displayBooks(_ books: [Book])
}


// MARK: - Presenter -

final class CategoryListPresenter {
    private weak var output: CategoryListPresenterOutput!
    
    
    // MARK: - Initializers -
    
    /// - parameter output: Specify presenter output
    init(output: CategoryListPresenterOutput) {
        self.output = output
    }
}


// MARK: - Presenter Input IMPL -

/// Implementation Presenter input
extension CategoryListPresenter: CategoryListPresenterInput {
    
    func presentList(_ list: CategoryList) {
        let categoryViewModelList = list.categorires.map { (category) -> CategoryViewModel in
            let categoryImageURL = URL(string: category.listImageURLString)!
            
            return CategoryViewModel(categoryImageURL: categoryImageURL,
                                     categoryTitle: category.displayName,
                                     categoryUpdateState: category.updateState)
        }
        
        self.output.displayCategories(categoryViewModelList)
    }
    
    func presentBookList(categoryList: CategoryList, index: Int) {
        let category = categoryList.categorires[index]
        let books = category.books
        
        self.output.displayBooks(books)
    }
    
    func presentError(_ error: NetworkError) {
        let errorViewModel = ErrorViewModel(error: error)
        
        self.output.displayError(errorViewModel)
    }
}
