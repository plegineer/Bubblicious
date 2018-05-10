//
//  ExpandCells.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import ExpandableCell

class ExpandCell: ChangeArrowImageExpandableCell {
    static let ID = "ExpandCell"
    @IBOutlet weak var expandTitleLabel: UILabel!
}

class ExpandedCell: UITableViewCell {
    static let ID = "ExpandedCell"
    @IBOutlet weak var expandedTitleLabel: UILabel!
}

class ChangeArrowImageExpandableCell: ExpandableCell {
    
    var expandArrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initArrowImageView()
    }

    func initArrowImageView() {
        expandArrowImageView = UIImageView()
        expandArrowImageView.image = UIImage(named: "expand_right_arrow")
        self.contentView.addSubview(expandArrowImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let expandArrowImageWidth: CGFloat = 15
        let expandArrowImageHeight: CGFloat = 15
        let expandArrowImageXPoint: CGFloat = 20
        let expandArrowImageYPoint:CGFloat = (self.bounds.height - expandArrowImageHeight) / 2

        expandArrowImageView.frame = CGRect(x: expandArrowImageXPoint, y: expandArrowImageYPoint, width: expandArrowImageWidth, height: expandArrowImageHeight)
        arrowImageView.frame = .zero
    }
}
