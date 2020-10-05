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

    case quotes
    case quoteOfTheDay
    case quote(id: Int)

    var urlString: String {
        switch self {
        case .quotes: return baseURL.appendingPathComponent("quotes").absoluteString
        case .quoteOfTheDay: return baseURL.appendingPathComponent("qotd").absoluteString
        case let .quote(id): return baseURL.appendingPathComponent("quotes/\(id)").absoluteString
        }
    }
}

class NetworkProvider: Provider {
    let realmManager: Realm? = try? Realm()

    private let apiKey = "5247f8e12299d74c8e81010ebff7861e"

    lazy var headers: HTTPHeaders = {
        var authHeaders = HTTPHeaders()
        authHeaders.add(HTTPHeader(name: "Authorization", value: "Token token=\(self.apiKey)"))
        return authHeaders
    }()

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
                    self?.saveToDataBase(quotes: items.quotes)
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

    func saveToDataBase(quotes: [Quote]) {
        _ = try? realmManager?.write {
            realmManager?.add(quotes, update: .modified)
        }
    }
}
