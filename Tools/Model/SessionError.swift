//
//  SessionError.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

enum SessionError: Error {
    case invalidLoginOrPassword
    case loginOrPasswordMissing
    case loginNotActive
    case unexpectedError
    
    var userFriendlyMessage: String {
        switch self {
        case .invalidLoginOrPassword: return Loc.Error.invalidLoginOrPassword
        case .loginOrPasswordMissing: return Loc.Error.loginOrPasswordMissing
        case .loginNotActive: return Loc.Error.loginNotActive
        case .unexpectedError: return Loc.Error.unexpectedLoginError
        }
    }
}
