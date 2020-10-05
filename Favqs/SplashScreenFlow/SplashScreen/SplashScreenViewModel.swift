//
//  SplashScreenViewModel.swift
// Favqs
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class SplashScreenViewModel: SplashScreenViewModelInterface {
    let title: BehaviorRelay<String>
    let avatarImage: BehaviorRelay<UIImage>
    let caption: BehaviorRelay<String>

    let output = SplashScreenOutput()

    init(with: Provider) {
        title = BehaviorRelay<String>(value: Loc.SplashScreen.title)
        avatarImage = BehaviorRelay<UIImage>(value: Assets.SplashScreen.avatar)
        caption = BehaviorRelay<String>(value: Loc.SplashScreen.avatarCaption)
    }
}
