//
//  QuoteTableViewCell.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

final class QuoteTableViewCell: RxTableViewCell {
    private let bodyLabel = UILabel()
    private let authorLabel = UILabel()
    private let tagsLabel = UILabel()

    var viewModel: QuoteTableViewCellViewModelInterface?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
    }

    func setup(with viewModel: QuoteTableViewCellViewModelInterface) {
        self.viewModel = viewModel

        setupView()
        setupRxBindings(with: viewModel)
    }
}

private extension QuoteTableViewCell {
    /* View */
    func setupView() {
        setupBodyLabel()
        setupAuthorLabel()
        setupTagsLabel()
    }
    
    func setupBodyLabel() {
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .italicSystemFont(ofSize: 24)
        bodyLabel.textColor = .label
        addSubview(bodyLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
    }
    
    func setupAuthorLabel() {
        authorLabel.font = .systemFont(ofSize: 20)
        authorLabel.textColor = .secondaryLabel
        addSubview(authorLabel)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            authorLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8)
        ])

    }
    
    func setupTagsLabel() {
        addSubview(tagsLabel)
        tagsLabel.font = .systemFont(ofSize: 16)
        tagsLabel.textColor = .tertiaryLabel

        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tagsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tagsLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            tagsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    /* Rx Bindings */
    func setupRxBindings(with viewModel: QuoteTableViewCellViewModelInterface) {
        bindBodyLabel(with: viewModel)
        bindAuthorLabel(with: viewModel)
        bindTagsLabel(with: viewModel)
    }
    
    func bindBodyLabel(with viewModel: QuoteTableViewCellViewModelInterface) {
        viewModel.body.bind(to: bodyLabel.rx.text).disposed(by: bag)
    }

    func bindAuthorLabel(with viewModel: QuoteTableViewCellViewModelInterface) {
        viewModel.author.bind(to: authorLabel.rx.text).disposed(by: bag)
    }

    func bindTagsLabel(with viewModel: QuoteTableViewCellViewModelInterface) {
        viewModel.tags.bind(to: tagsLabel.rx.text).disposed(by: bag)
    }
}
