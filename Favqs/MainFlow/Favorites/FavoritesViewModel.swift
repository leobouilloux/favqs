//
//  FavoritesViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RealmSwift
import RxCocoa
import RxRealm
import RxSwift

final class FavoritesViewModel: FavoritesViewModelInterface {
    private let provider: Provider

    let title = BehaviorRelay<String>(value: Loc.Quotes.title)

    let isControllerActive = BehaviorRelay<Bool>(value: false)

    var favoriteQuotes = [Quote]()
    let dataSource = BehaviorRelay<[FavoritesCellType]>(value: [])

    private let bag = DisposeBag()
    private var dataBaseDisposable: Disposable?

    private var pageIndex = 1

    init(provider: Provider) {
        self.provider = provider

        bindIsControllerActive()
    }

    private func setupDataSource(with quotes: [Quote]) {
        var cells = [FavoritesCellType]()
        quotes.forEach { quote in
            cells.append(.quote(value: quote))
        }
        dataSource.accept(cells)
    }

    func bindIsControllerActive() {
        isControllerActive
            .subscribe(onNext: { [weak self] isControllerActive in
                if isControllerActive {
                    self?.watchDataBase()
                } else {
                    self?.dataBaseDisposable?.dispose()
                }
            })
            .disposed(by: bag)
    }

    private func watchDataBase() {
        guard let objects = provider.realmManager?.objects(Quote.self) else { return }

        dataBaseDisposable = Observable.array(from: objects)
            .subscribe(onNext: { [weak self] quotes in
                let favoriteQuotes = quotes.filter { $0.isFavorite == true }
                self?.favoriteQuotes = favoriteQuotes
                self?.setupDataSource(with: favoriteQuotes)
            })
    }

    func removeFromFavorite(quote: Quote) {
        let quoteCopy = Quote(value: quote)
        quoteCopy.isFavorite = false

        _ = try? provider.realmManager?.write {
            provider.realmManager?.add(quoteCopy, update: .modified)
        }
    }
}
