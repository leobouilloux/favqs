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

    public var image: UIImage { //TODO: Put real images here
        switch self {
        case .error:    return UIImage(systemName: "xmark.circle.fill")!
        case .warning:  return UIImage(systemName: "exclamationmark.triangle.fill")!
        case .success:  return UIImage(systemName: "checkmark.circle.fill")!
        case .info:     return UIImage(systemName: "info.circle.fill")!
        }
    }
}
