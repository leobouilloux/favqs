//
//  FavoritesFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

final class FavoritesFactory: FavoritesFactoryInterface {
    func makeFavoritesPresentable(with viewModel: FavoritesViewModelInterface) -> Presentable {
        return FavoritesViewController(with: viewModel)
    }
}
