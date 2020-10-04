//
//  FavoritesViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

protocol FavoritesViewModelInterface {
    var title: BehaviorRelay<String> { get }
}
