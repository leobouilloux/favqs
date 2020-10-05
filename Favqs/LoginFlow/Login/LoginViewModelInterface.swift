//
//  LoginViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxCocoa

protocol LoginViewModelInterface {
    var title: BehaviorRelay<String> { get }

    var login: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    var signInButtonTitle: BehaviorRelay<String> { get }

    var loginPlaceHolder: String { get }
    var passwordPlaceHolder: String { get }

    var errorMessage: PublishRelay<String> { get }

    var output: LoginOutput { get }

    func signIn(login: String, password: String)
}
