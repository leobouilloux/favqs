//
//  FavoritesFactoryInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

protocol FavoritesFactoryInterface {
    func makeFavoritesPresentable(with viewModel: FavoritesViewModelInterface) -> Presentable
}
