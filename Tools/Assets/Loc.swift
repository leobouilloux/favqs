//
//  Loc.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import Foundation

enum Loc {
    enum Error {
        static var noDataReceived = NSLocalizedString("error.noDataReceived", comment: "")
        static var jsonDecodeFailed = NSLocalizedString("error.jsonDecodeFailed", comment: "")
        static var errorReceived = NSLocalizedString("error.errorReceived", comment: "")
        
        static var invalidLoginOrPassword = NSLocalizedString("error.invalidLoginOrPassword", comment: "")
        static var loginNotActive = NSLocalizedString("error.loginNotActive", comment: "")
        static var loginOrPasswordMissing = NSLocalizedString("error.loginOrPasswordMissing", comment: "")
        static var unexpectedLoginError = NSLocalizedString("error.unexpectedLoginError", comment: "")
    }

    enum Login {
        static var title = NSLocalizedString("login.title", comment: "")
        static var login = NSLocalizedString("login.login", comment: "")
        static var password = NSLocalizedString("login.password", comment: "")
        static var button = NSLocalizedString("login.button", comment: "")
    }
    
    enum SplashScreen {
        static var title = NSLocalizedString("splashScreen.title", comment: "")
        static var avatarCaption = NSLocalizedString("splashScreen.avatarCaption", comment: "")
    }

    enum Quotes {
        static var title = NSLocalizedString("quotes.title", comment: "")
        static var addToFavorite = NSLocalizedString("quotes.rowAction.addToFavorites", comment: "")
        static var removeFromFavorite = NSLocalizedString("quotes.rowAction.removeFromFavorites", comment: "")
    }

    enum Favorites {
        static var title = NSLocalizedString("favorites.title", comment: "")
    }
}
