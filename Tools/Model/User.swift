//
//  User.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RealmSwift

class User: Object, Decodable {
    @objc dynamic var login: String = ""
    @objc dynamic var pictureURL: String = ""
    @objc dynamic var publicFavoritesCount: Int = 0
    @objc dynamic var followers: Int = 0
    @objc dynamic var following: Int = 0

    var accountDetails: AccountDetails?

    enum CodingKeys: String, CodingKey {
        case login
        case pictureURL = "pic_url"
        case publicFavoritesCount = "public_favorites_count"
        case followers
        case following
        case accountDetails = "account_details"
    }

    override static func primaryKey() -> String? {
        return "login"
    }
}
