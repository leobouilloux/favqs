//
//  AccountFactoryInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

protocol AccountFactoryInterface {
    func makeAccountPresentable(with viewModel: AccountViewModelInterface) -> Presentable
}
