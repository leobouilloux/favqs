//
//  QuoteTableViewCellViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

protocol QuoteTableViewCellViewModelInterface {
    var body: BehaviorRelay<String> { get }
    var author: BehaviorRelay<String> { get }
    var tags: BehaviorRelay<String> { get }
    var favoriteImage: BehaviorRelay<UIImage> { get }
}
