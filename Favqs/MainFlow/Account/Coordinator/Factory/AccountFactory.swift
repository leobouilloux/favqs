//
//  AccountFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

final class AccountFactory: AccountFactoryInterface {
    func makeAccountPresentable(with viewModel: AccountViewModelInterface) -> Presentable {
        return AccountViewController(with: viewModel)
    }
}
