//
//  QuotesViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

protocol QuotesViewModelInterface {
    var title: BehaviorRelay<String> { get }
    
    var dataSource: BehaviorRelay<[QuotesCellType]> { get }
    
    var isLoading: BehaviorRelay<Bool> { get }
    var isControllerActive: BehaviorRelay<Bool> { get }

    var errorMessage: PublishRelay<String> { get }
    
    func refreshPages()
    func fetchNextPage()
}
