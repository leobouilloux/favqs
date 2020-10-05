//
//  SnackBarType.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

public enum SnackBarType {
    case error
    case warning
    case success
    case info

    public var backgroundColor: UIColor {
        return .secondarySystemBackground
    }

    public var imageColor: UIColor {
        switch self {
        case .error:    return .systemRed
        case .warning:  return .systemYellow
        case .success:  return .systemGreen
        case .info:     return .systemBlue
        }
    }

    public var textColor: UIColor {
        return .label
    }

    public var image: UIImage {
        switch self {
        case .error:    return Assets.Icons.error
        case .warning:  return Assets.Icons.warning
        case .success:  return Assets.Icons.success
        case .info:     return Assets.Icons.info
        }
    }
}
