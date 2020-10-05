//
//  UserSession.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RealmSwift

class UserSession: Object, Decodable {
    @objc dynamic var token: String = ""
    @objc dynamic var login: String = ""
    @objc dynamic var email: String = ""

    enum CodingKeys: String, CodingKey {
        case token = "User-Token"
        case login
        case email
    }

    override static func primaryKey() -> String? {
        return "token"
    }
}
