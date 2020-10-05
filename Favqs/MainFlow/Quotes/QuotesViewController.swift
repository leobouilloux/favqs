//
//  QuotesViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

final class QuotesViewController: RxViewController {
    private let viewModel: QuotesViewModelInterface

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    init(with viewModel: QuotesViewModelInterface) {
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
        if viewModel.dataSource.value.isEmpty {
            viewModel.refreshPages()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel.isControllerActive.accept(false)
    }
}

extension QuotesViewController: UITableViewDelegate {
    /* View */
    func setupView() {
        setupTableView()
    }

    func setupTableView() {
        tableView.register(cell: QuoteTableViewCell.self)
        tableView.refreshControl = refreshControl
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
        bindRefreshControl()
        bindErrorMessage()
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

    func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                if self?.refreshControl.isRefreshing == true {
                    self?.viewModel.refreshPages()
                }
            })
            .disposed(by: bag)
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                if !isLoading {
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                    }
                }
            })
            .disposed(by: bag)
    }

    func bindErrorMessage() {
        viewModel.errorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.snackBarController.error(message: errorMessage)
                }
            })
            .disposed(by: bag)

    }

    /* Helpers */
    func cell(for cellType: QuotesCellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = QuoteTableViewCell()

        switch (cellType, cell) {
        case let (.quote(value: quote), cell as QuoteTableViewCell):
            let cellViewModel = QuoteTableViewCellViewModel(quote: quote)
            cell.setup(with: cellViewModel)
        default: break
        }
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
                if !viewModel.isLoading.value {
                    viewModel.fetchNextPage()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let quote = viewModel.quotes[safeIndex: indexPath.row] else { return nil }
        let title: String
        let backgroundColor: UIColor
        if quote.isFavorite {
            title = Loc.Quotes.removeFromFavorite
            backgroundColor = .red
        } else {
            title = Loc.Quotes.addToFavorite
            backgroundColor = .blue
        }

        let favoriteAction = UIContextualAction(
            style: .normal,
            title: title) { [weak self] _, _, completionHandler in
            self?.viewModel.toggleIsFavorite(for: quote)
            completionHandler(true)
        }
        favoriteAction.backgroundColor = backgroundColor
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
