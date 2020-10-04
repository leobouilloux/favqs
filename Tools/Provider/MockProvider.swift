//
//  MockProvider.swift
// Favqs
//
//  Created by Leo Marcotte on 30/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum MockProviderConfig {
    case success
    case generateError(ofType: Error)
}

class MockProvider: Provider {
    private let config: MockProviderConfig

    init(config: MockProviderConfig) {
        self.config = config
    }

    func fetchData(completion: @escaping (Result<[Quote], Error>) -> Void) {
    }
}
