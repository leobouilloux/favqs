//
//  QuotesResponse.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import Foundation

struct QuotesResponse: Decodable {
    var page: Int
    var isLastPage: Bool
    var quotes: [Quote]

    enum CodingKeys: String, CodingKey {
        case page
        case isLastPage = "last_page"
        case quotes
    }
}
