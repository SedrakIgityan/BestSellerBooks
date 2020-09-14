//
//  BuyViewController.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/10/20.
//  Copyright (c) 2020 Sedrak Igityan. All rights reserved.
//
//

import UIKit

/// Responsible for viewcontroller input events
protocol BuyViewControllerInput: BuyPresenterOutput {
    
}

/// Responsible for view controller output events
protocol BuyViewControllerOutput: AnyObject {
    
    func fetchBuyInfo()
}


// MARK: - View Controller -

final class BuyViewController: UIViewController {
    
    
    // MARK: - Properties -
    
    
    // MARK: - VIP -
    
    // Specify architecture-needed properties
    var output: BuyViewControllerOutput!
    var router: BuyRouterProtocol!
    
    
    // MARK: - Data Source -
    
    var buyerViewModels: [BuyerViewModel] = []
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var buyerCollectionView: UICollectionView!
    
    
    // MARK: - Initializers -
    
    static func instantiateFromStoryboard(book: Book) -> BuyViewController {
        let buyViewController: BuyViewController = Storyboard.Main.instantiateFromStoryboard()!
        buyViewController.configure(book: book)
        
        return buyViewController
    }
    
    
    // MARK: - Configurator -
    
    private func configure(configurator: BuyConfigurator = BuyConfigurator.sharedInstance,
                           book: Book) {
        configurator.configure(viewController: self, book: book)
    }
    
    
    // MARK: - Lify Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buyerCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    // MARK: - Setup -
    
    /// Responsible for doing intial setups.
    private func setup() {
        self.setupBuyers()
    }
    
    private func setupBuyers() {
        self.output.fetchBuyInfo()
    }
}


// MARK: - ViewController Input IMPL -

/// Implementation of view controller input
extension BuyViewController: BuyViewControllerInput {
    
    func display(buyers: [BuyerViewModel]) {
        self.buyerViewModels = buyers
        self.buyerCollectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource -

extension BuyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.buyerViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BuyItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let viewModel: BuyerViewModel = self.buyerViewModels[indexPath.item]
        
        cell.setup(viewModel)
        
        return cell
    }
}


// MARK: - BestSellerBooks_iOS -

extension BuyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        
        return CGSize(width: collectionViewWidth / 2, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
