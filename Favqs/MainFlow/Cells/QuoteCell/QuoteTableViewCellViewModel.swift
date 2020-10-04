//
//  QuoteTableViewCellViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

final class QuoteTableViewCellViewModel: QuoteTableViewCellViewModelInterface {
    let author: BehaviorRelay<String>
    let body: BehaviorRelay<String>
    let tags: BehaviorRelay<String>
    
    init(quote: Quote) {
        self.author = BehaviorRelay<String>(value: quote.author)
        self.body = BehaviorRelay<String>(value: quote.body)
        self.tags = BehaviorRelay<String>(value: quote.tags.joined(separator: ", "))
    }
}
