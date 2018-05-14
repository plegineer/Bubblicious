//
//  ContentCustomTableViewCell.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/10.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ContentCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
