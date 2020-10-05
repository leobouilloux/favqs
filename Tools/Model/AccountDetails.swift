//
//  AccountDetails.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RealmSwift

class AccountDetails: Object, Decodable {
    @objc dynamic var email: String = ""
    @objc dynamic var privateFavoritesCount = 0

    enum CodingKeys: String, CodingKey {
        case email
        case privateFavoritesCount = "private_favorites_count"
    }

    override static func primaryKey() -> String? {
        return "email"
    }
}
