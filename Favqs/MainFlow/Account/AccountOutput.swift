//
//  AccountOutput.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxCocoa

final class AccountOutput {
    let userDidSignout = PublishRelay<Void>()
}
