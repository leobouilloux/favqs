//
//  QuotesCellType.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

enum QuotesCellType {
    case quote(value: Quote)

    var identifier: String {
        switch self {
        case .quote: return QuoteTableViewCell.identifier
        }
    }
}
