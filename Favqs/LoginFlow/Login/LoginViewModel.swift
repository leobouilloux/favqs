//
//  LoginViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxCocoa

final class LoginViewModel: LoginViewModelInterface {
    private let provider: Provider

    let title: BehaviorRelay<String>

    let loginPlaceHolder: String
    let login: BehaviorRelay<String>

    let passwordPlaceHolder: String
    let password: BehaviorRelay<String>

    let signInButtonTitle: BehaviorRelay<String>

    let errorMessage = PublishRelay<String>()

    let output = LoginOutput()

    init(with provider: Provider) {
        self.provider = provider

        self.title = BehaviorRelay<String>(value: Loc.Login.title)
        self.login = BehaviorRelay<String>(value: "")
        self.password = BehaviorRelay<String>(value: "")

        self.signInButtonTitle = BehaviorRelay<String>(value: Loc.Login.button)

        self.loginPlaceHolder = Loc.Login.login
        self.passwordPlaceHolder = Loc.Login.password
    }

    func signIn(login: String, password: String) {
        provider.signIn(login: login, password: password) { [weak self] result in
            switch result {
            case let .failure(error):
                if let error = error as? SessionError {
                    self?.errorMessage.accept(error.userFriendlyMessage)
                }
            case let .success(session):
                self?.provider.getUser(login: session.login, completion: { _ in
                    self?.output.userDidConnect.accept(())
                })
            }
        }
    }
}
