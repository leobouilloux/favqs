//
//  RxTableViewCell.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxSwift
import UIKit

class RxTableViewCell: UITableViewCell {
    var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        bag = DisposeBag()
    }
}
