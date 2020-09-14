//
//  ResponseViewModel.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 9/8/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

protocol ResponseViewModelProtocol {
    var title: String { get }
    var message: String { get }
    var buttonActions: [AlertButtonText] { get }
}
