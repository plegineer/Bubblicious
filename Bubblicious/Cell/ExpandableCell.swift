//
//  ExpandableCell.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import ExpandableCell

class NormalCell: UITableViewCell {
    static let ID = "NormalCell"
}

class ExpandCell: ExpandableCell {
    static let ID = "ExpandCell"
}

class ExpandedCell: UITableViewCell {
    static let ID = "ExpandedCell"
    @IBOutlet weak var titleLabel: UILabel!
}
