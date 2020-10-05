//
//  AccountViewModelInterface.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxCocoa

protocol AccountViewModelInterface {
    var title: BehaviorRelay<String> { get }

    var avatarImage: BehaviorRelay<UIImage> { get }
    var login: BehaviorRelay<String> { get }
    var email: BehaviorRelay<String> { get }
    var followers: BehaviorRelay<String> { get }
    var following: BehaviorRelay<String> { get }
    var favoriteCount: BehaviorRelay<String> { get }
    var signoutButtonTitle: BehaviorRelay<String> { get }

    var isControllerActive: BehaviorRelay<Bool> { get }
    var errorMessage: PublishRelay<String> { get }

    var output: AccountOutput { get }

    func signOut()
}
