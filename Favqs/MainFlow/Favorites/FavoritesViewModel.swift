//
//  FavoritesViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa

final class FavoritesViewModel: FavoritesViewModelInterface {
    private let provider: Provider
    
    let title = BehaviorRelay<String>(value: Loc.Favorites.title)
    
    init(provider: Provider) {
        self.provider = provider
    }
}
