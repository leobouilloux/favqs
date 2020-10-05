//
//  Provider.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation
import RealmSwift

protocol Provider {
    var realmManager: Realm? { get }

    func signIn(login: String, password: String, completion: @escaping (Result<UserSession, Error>) -> Void)
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    func fetchQuotes(for page: Int, completion: @escaping (Result<[Quote], Error>) -> Void)

    func getUser(login: String, completion: @escaping (Result<User, Error>) -> Void)

    func saveToken(token: String)

    func wipeData()
}
