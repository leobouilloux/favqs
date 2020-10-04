//
//  SnackBarController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

public class SnackBarController {
    var snackBarTopConstraint = NSLayoutConstraint()

    var parentView: UIView?
    let snackBar = SnackBar()

    func setup(in controller: UIViewController) {
        parentView = controller.view

        guard let parentView = self.parentView else { return }

        parentView.addSubview(snackBar)

        snackBar.translatesAutoresizingMaskIntoConstraints = false

        snackBarTopConstraint = snackBar.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            snackBarTopConstraint,
            snackBar.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 16),
            snackBar.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -16)
        ])
        snackBar.layer.cornerRadius = 15
        snackBarTopConstraint.constant = -56
        snackBar.isHidden = true
    }

    public func error(message: String) {
        snackBar.type = .error
        snackBar.messageLabel.text = message
        animate()
    }

    public func warning(message: String) {
        snackBar.type = .warning
        snackBar.messageLabel.text = message
        animate()
    }

    public func success(message: String) {
        snackBar.type = .success
        snackBar.messageLabel.text = message
        animate()
    }

    public func info(message: String) {
        snackBar.type = .info
        snackBar.messageLabel.text = message
        animate()
    }

    private func animate() {
        snackBar.isHidden = false
        parentView?.bringSubviewToFront(snackBar)
        self.snackBarTopConstraint.constant = 16

        UIView.animate(withDuration: 1, animations: {
            self.parentView?.layoutIfNeeded()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 + 1) {
            self.snackBarTopConstraint.constant = -self.snackBar.frame.height
            UIView.animate(withDuration: 1, animations: {
                self.parentView?.layoutIfNeeded()
            }, completion: { _ in
                self.snackBar.isHidden = true
            })
        }
    }
}
