//
//  DeepLinkOption.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

enum DeepLinkURLConstants {}

public enum DeepLinkOption {
    public static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            URLComponents(url: url, resolvingAgainstBaseURL: true) != nil {
        }
        return nil
    }

    public static func build(with url: URL) -> DeepLinkOption? {
        let options = parse(url: url)
        switch options.screen {
        default: return nil
        }
    }

    private static func parse(url: URL) -> (screen: String, arguments: [String]) {
        let screen = url.host ?? ""
        var components = url.pathComponents
        components.removeAll { $0 == "/" }
        return (screen: screen, arguments: components)
    }
}
