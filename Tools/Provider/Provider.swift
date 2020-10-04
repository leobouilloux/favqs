//
//  Provider.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

protocol Provider {
    func fetchQuotes(for page: Int, completion: @escaping (Result<[Quote], Error>) -> Void)
}
