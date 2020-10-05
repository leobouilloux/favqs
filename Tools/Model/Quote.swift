//
//  Quote.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RealmSwift

class Quote: Object, Decodable {
    @objc dynamic var id: Int = 0
    var tags: List<String> = List<String>()
    @objc dynamic var author: String = ""
    @objc dynamic var body: String = ""
    
    @objc dynamic var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case tags
        case author
        case body
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
