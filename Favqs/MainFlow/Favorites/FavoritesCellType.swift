//
//  FavoritesCellType.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

enum FavoritesCellType {
    case quote(value: Quote)

    var identifier: String {
        switch self {
        case .quote: return QuoteTableViewCell.identifier
        }
    }
}
