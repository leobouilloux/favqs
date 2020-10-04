//
//  QuotesFactoryInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import Foundation

protocol QuotesFactoryInterface {
    func makeQuotesPresentable(with viewModel: QuotesViewModelInterface) -> Presentable
}
