//
//  SnackBar.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

public class SnackBar: UIView {
    var type: SnackBarType = .error {
        didSet { updateView(with: type) }
    }
    var imageView = UIImageView()
    var messageLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        sharedInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        sharedInit()
    }

    private func sharedInit() {
        setupView()
    }

    func setupView() {
        backgroundColor = type.backgroundColor

        setupImageView()
        setupMessageLabel()
    }

    func updateView(with type: SnackBarType) {
        backgroundColor = type.backgroundColor
        imageView.image = type.image
        imageView.tintColor = type.imageColor
        messageLabel.textColor = type.textColor
    }

    func setupImageView() {
        imageView.image = type.image
        imageView.tintColor = type.imageColor
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
    }

    func setupMessageLabel() {
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        messageLabel.textColor = type.textColor
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
