//
//  ProfileTableViewCell.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/09.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier: String = "profileCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
