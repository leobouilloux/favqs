//
//  LoginViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginViewController: RxViewController {
    private let viewModel: LoginViewModelInterface
    
    private let loginTextField = TextField()
    private let passwordTextField = TextField()
    private let signInButton = UIButton()
    
    init(with viewModel: LoginViewModelInterface) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRxBindings()
    }
}

private extension LoginViewController {
    /* View */
    func setupView() {
        view.backgroundColor = .systemBackground
        setupLoginTextField()
        setupPasswordTextField()
        setupSignInButton()
    }
    
    func setupLoginTextField() {
        loginTextField.delegate = self
        loginTextField.attributedPlaceholder = NSAttributedString(
            string: viewModel.loginPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        loginTextField.autocapitalizationType = .none
        loginTextField.autocorrectionType = .no
        loginTextField.textColor = .label
        loginTextField.backgroundColor = .secondarySystemBackground
        loginTextField.keyboardType = .namePhonePad
        view.addSubview(loginTextField)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: 36),
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: viewModel.passwordPlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.defaultTextAttributes = [
            .strokeColor: UIColor.label
        ]

        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 36),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 32),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSignInButton() {
        signInButton.tintColor = .white
        signInButton.backgroundColor = .systemBlue
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        signInButton.layer.masksToBounds = true
        signInButton.layer.cornerRadius = 4
    }
    
    /* Rx Bindings */
    func setupRxBindings() {
        bindNavigationItems()
        bindSignInButton()
        bindErrorMessage()
    }
    
    func bindNavigationItems() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }
        
    func bindSignInButton() {
        viewModel.signInButtonTitle.bind(to: signInButton.rx.title()).disposed(by: bag)
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard
                    let login = self?.loginTextField.text,
                    let password = self?.passwordTextField.text
                    else { return }
                self?.viewModel.signIn(login: login, password: password)
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
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            _ = passwordTextField.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
}

