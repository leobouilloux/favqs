//
//  Assets.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

enum Assets {
    enum SplashScreen {
        static var avatar = UIImage(named: "avatar") ?? UIImage()
    }

    enum Icons {
        static var quoteBubbleFill = UIImage(systemName: "quote.bubble.fill") ?? UIImage()
        static var starFill = UIImage(systemName: "star.fill") ?? UIImage()
        static var starCircleFill = UIImage(systemName: "star.circle.fill") ?? UIImage()

        static var error = UIImage(systemName: "exclamationmark.circle.fill") ?? UIImage()
        static var warning = UIImage(systemName: "exclamationmark.triangle.fill") ?? UIImage()
        static var success = UIImage(systemName: "checkmark.circle.fill") ?? UIImage()
        static var info = UIImage(systemName: "info.circle.fill") ?? UIImage()

        static var chevronLeft = UIImage(systemName: "chevron.backward") ?? UIImage()
        static var close = UIImage(systemName: "xmark") ?? UIImage()

        static var personCropCircle = UIImage(systemName: "person.crop.circle") ?? UIImage()
    }
}
