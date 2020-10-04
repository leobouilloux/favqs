//
//  Quote.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RealmSwift

class Quote: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var tags: [String] = []
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var author: String = ""
    @objc dynamic var upvoteCount: Int = 0
    @objc dynamic var downvoteCount: Int = 0
    @objc dynamic var favoriteCount: Int = 0
    @objc dynamic var url: URL?
    @objc dynamic var body: String = ""
//    "author_permalink": "linus-torvalds",
//    "dialogue": false,
}
