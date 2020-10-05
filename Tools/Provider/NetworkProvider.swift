//
//  NetworkProvider.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Alamofire
import RealmSwift

private enum Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://favqs.com/api") else { fatalError("Endpoint base url is not valid") }
        return url
    }

    case session
    case users(login: String)
    case quotes
    case quoteOfTheDay
    case quote(id: Int)

    var urlString: String {
        switch self {
        case .session: return baseURL.appendingPathComponent("session").absoluteString
        case let .users(login): return baseURL.appendingPathComponent("users/\(login)").absoluteString
        case .quotes: return baseURL.appendingPathComponent("quotes").absoluteString
        case .quoteOfTheDay: return baseURL.appendingPathComponent("qotd").absoluteString
        case let .quote(id): return baseURL.appendingPathComponent("quotes/\(id)").absoluteString
        }
    }
}

class NetworkProvider: Provider {
    let realmManager: Realm? = try? Realm()
    private let apiKey: String
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader(name: "Authorization", value: "Token token=\(apiKey)"))
        
        if let session = realmManager?.objects(UserSession.self).first {
            headers.add(HTTPHeader(name: "User-Token", value: session.token))
        }
        return headers
    }

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func signIn(login: String, password: String, completion: @escaping (Result<UserSession, Error>) -> Void) {
        let parameters: Parameters = [
            "user": [
                "login": login,
                "password": password
            ]
        ]

        AF.request(Endpoint.session.urlString,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers
        )
        .validate()
        .responseJSON { [weak self] response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let session = try decoder.decode(UserSession.self, from: data)
                    self?.saveSessionToDataBase(session: session)
                    completion(.success(session))
                } catch {
                    do {
                        let sessionError = try decoder.decode(UserSessionError.self, from: data)
                        completion(.failure(sessionError.error))
                    } catch {
                        completion(.failure(NetworkError.jsonDecodeFailed))
                    }
                }
            } else if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(NetworkError.errorReceived))
            } else {
                completion(.failure(NetworkError.noDataReceived))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(Endpoint.session.urlString,
                   method: .delete,
                   headers: headers
        )
        .validate()
        .responseJSON { [weak self] response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let sessionError = try decoder.decode(UserSessionError.self, from: data)
                    completion(.failure(sessionError.error))
                } catch {
                    completion(.success(()))
                }
            } else if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(NetworkError.errorReceived))
            } else {
                completion(.failure(NetworkError.noDataReceived))
            }
        }

    }

    func fetchQuotes(for page: Int, completion: @escaping (Result<[Quote], Error>) -> Void) {
        let parameters: Parameters = [
            "page": page
        ]

        AF.request(Endpoint.quotes.urlString,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers
        )
        .validate()
        .responseJSON { [weak self] response in
            if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    let items = try decoder.decode(QuotesResponse.self, from: data)
                    self?.saveQuotesToDataBase(quotes: items.quotes)
                    completion(.success(items.quotes))
                } catch {
                    completion(.failure(NetworkError.jsonDecodeFailed))
                }
            } else if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(NetworkError.errorReceived))
            } else {
                completion(.failure(NetworkError.noDataReceived))
            }
        }
    }

    func getUser(login: String, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request(Endpoint.users(login: login).urlString,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers
        )
        .validate()
        .responseJSON { [weak self] response in
            if let data = response.data {
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data)
                    self?.saveUserToDataBase(user: user)
                    completion(.success(user))
                } catch {
                    completion(.failure(NetworkError.jsonDecodeFailed))
                }
            } else if let error = response.error {
                print(error.localizedDescription)
                completion(.failure(NetworkError.errorReceived))
            } else {
                completion(.failure(NetworkError.noDataReceived))
            }
        }
    }

    func saveSessionToDataBase(session: UserSession) {
        _ = try? realmManager?.write {
            realmManager?.add(session, update: .modified)
        }
    }
    
    func saveUserToDataBase(user: User) {
        _ = try? realmManager?.write {
            realmManager?.add(user, update: .modified)
        }
    }

    func saveQuotesToDataBase(quotes: [Quote]) {
        _ = try? realmManager?.write {
            realmManager?.add(quotes, update: .modified)
        }
    }

    func wipeData() {
        _ = try? realmManager?.write {
            realmManager?.deleteAll()
        }
    }
}
