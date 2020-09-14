//
//  NetworkWorker.swift
//  BestSellerBooks
//
//  Created by Sedrak Igityan on 8/19/20.
//  Copyright © 2020 Sedrak Igityan. All rights reserved.
//

import Foundation

typealias DataResultCompletion = (Result<Data, NetworkError>) -> ()
typealias DummyResultCompletion = (Result<Void, NetworkError>) -> ()

protocol NetworkWorkerProtocol {
    
    func fetchCategories(completion: @escaping DataResultCompletion)
}

final class NetworkWorker: NetworkWorkerProtocol {
    
    let router: Router<NetworkWorkerApi>
    
    init(router: Router<NetworkWorkerApi> = Router<NetworkWorkerApi>()) {
        self.router = router
    }
    
    static var environment: NetworkEnvironment {
        return .Production
    }
    
    
    // MARK: - Network Worker Requests -
    
    func fetchCategories(completion: @escaping DataResultCompletion) {
        router.requestData(.FetchCategories) { (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                completion(.success(data))
            case .failedWithData(let error, _):
                completion(.failure(NetworkError(message: error.localizedDescription)))
            case .failed(let error):
                completion(.failure(NetworkError(message: error.localizedDescription)))
            }
        }
    }
}
