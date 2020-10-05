//
//  NSObject+Extension.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import Foundation

extension NSObject {
    var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    class var bundle: Bundle {
        return Bundle(for: self)
    }
}
