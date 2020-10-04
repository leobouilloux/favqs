//
//  UITableView+Extension.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.nameOfClass, bundle: cell.bundle), forCellReuseIdentifier: cell.identifier)
    }
}
