//
//  QuotesViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RealmSwift
import RxCocoa
import RxRealm
import RxSwift

final class QuotesViewModel: QuotesViewModelInterface {
    private let provider: Provider

    let title = BehaviorRelay<String>(value: Loc.Quotes.title)
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isControllerActive = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String>()
    
    let dataSource = BehaviorRelay<[QuotesCellType]>(value: [])
    
    private let bag = DisposeBag()
    private var dataBaseDisposable: Disposable?
    
    private var pageIndex = 1
    
    init(provider: Provider) {
        self.provider = provider
        
        bindIsControllerActive()
    }
    
    func refreshPages() {
        self.isLoading.accept(true)
        dataSource.accept([])
        for page in 1...pageIndex {
            fetchQuotes(for: page)
        }
    }
    
    func fetchNextPage() {
        pageIndex += 1
        fetchQuotes(for: pageIndex)
    }
    
    private func fetchQuotes(for page: Int) {
        provider.fetchQuotes(for: page) { [weak self] result in
            switch result {
            case .success: self?.isLoading.accept(false)
            case let .failure(error):
                if let error = error as? NetworkError {
                    self?.errorMessage.accept(error.userFriendlyErrorMessage)
                }
            }
        }
    }
    
    func setupDataSource(with quotes: [Quote]) {
        var cells = dataSource.value
        quotes.forEach { (quote) in
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
        guard let realm = try? Realm() else { return }
        let objects = realm.objects(Quote.self)
        
        dataBaseDisposable = Observable.array(from: objects)
            .subscribe(onNext: { [weak self] quotes in
                self?.setupDataSource(with: quotes)
            })
    }
}
