//
//  QuotesViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

final class QuotesViewModel: QuotesViewModelInterface {
    private let provider: Provider

    let title = BehaviorRelay<String>(value: Loc.Quotes.title)
    
    init(provider: Provider) {
        self.provider = provider
    }
}
