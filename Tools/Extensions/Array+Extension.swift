//
//  Array+Extension.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
