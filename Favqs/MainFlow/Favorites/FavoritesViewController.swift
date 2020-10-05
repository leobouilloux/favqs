//
//  FavoritesViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

final class FavoritesViewController: RxViewController {
    private let viewModel: FavoritesViewModelInterface
    
    private let tableView = UITableView()
    
    init(with viewModel: FavoritesViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRxBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.isControllerActive.accept(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.isControllerActive.accept(false)
    }
}

extension FavoritesViewController: UITableViewDelegate {
    /* View */
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(cell: QuoteTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /* Rx Bindings */
    func setupRxBindings() {
        bindNavigationItems()
        bindTableView()
    }
    
    func bindNavigationItems() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }
    
    func bindTableView() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: bag)
        viewModel.dataSource
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { [weak self] _, row, cellType in
                let indexPath = IndexPath(row: row, section: 0)
                
                return self?.cell(for: cellType, indexPath: indexPath) ?? UITableViewCell()
            }
            .disposed(by: bag)
    }
        
    /* Helpers */
    func cell(for cellType: FavoritesCellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = QuoteTableViewCell()
        
        switch (cellType, cell) {
        case let (.quote(value: quote), cell as QuoteTableViewCell):
            let cellViewModel = QuoteTableViewCellViewModel(quote: quote)
            cell.setup(with: cellViewModel)
        default: break
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let favQuote = viewModel.favoriteQuotes[safeIndex: indexPath.row] else { return nil }
        
        let favoriteAction = UIContextualAction(style: .normal, title: Loc.Quotes.removeFromFavorite) { [weak self] (_, _, completionHandler) in
            self?.viewModel.removeFromFavorite(quote: favQuote)
            completionHandler(true)
        }
        favoriteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

