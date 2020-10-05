//
//  QuotesFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

final class QuotesFactory: QuotesFactoryInterface {
    func makeQuotesPresentable(with viewModel: QuotesViewModelInterface) -> Presentable {
        return QuotesViewController(with: viewModel)
    }
}
