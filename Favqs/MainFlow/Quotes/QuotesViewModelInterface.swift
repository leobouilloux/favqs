//
//  QuotesViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

protocol QuotesViewModelInterface {
    var title: BehaviorRelay<String> { get }
}
