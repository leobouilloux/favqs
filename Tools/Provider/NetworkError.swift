//
//  NetworkError.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

enum NetworkError: Error {
    case jsonDecodeFailed
    case errorReceived
    case noDataReceived

    var userFriendlyErrorMessage: String {
        switch self {
        case .jsonDecodeFailed: return Loc.Error.jsonDecodeFailed
        case .errorReceived: return Loc.Error.errorReceived
        case  .noDataReceived: return Loc.Error.noDataReceived
        }
    }
}
