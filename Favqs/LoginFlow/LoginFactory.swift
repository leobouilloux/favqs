//
//  LoginFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

final class LoginFactory {
    func makeLoginPresentable(with viewModel: LoginViewModelInterface) -> Presentable {
        return LoginViewController(with: viewModel)
    }
}
