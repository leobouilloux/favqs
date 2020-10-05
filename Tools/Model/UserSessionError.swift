//
//  UserSessionError.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

struct UserSessionError: Decodable {
    var code: Int
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "error_code"
        case message
    }
    
    var error: SessionError {
        switch code {
        case 21: return .invalidLoginOrPassword
        case 22: return .loginNotActive
        case 23: return .loginOrPasswordMissing
        default: return .unexpectedError
        }
    }
}
