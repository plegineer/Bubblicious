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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        initArrowImageView()
    }

    func initArrowImageView() {
        arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "expandCell_arrow")
        self.contentView.addSubview(arrowImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let arrowImageWidth: CGFloat = 11
        let arrowImageHeight: CGFloat = 22
        let arrowImageXPoint: CGFloat = 20
        let arrowImageYPoint:CGFloat = (self.bounds.height - arrowImageHeight) / 2

        arrowImageView.frame = CGRect(x: arrowImageXPoint, y: arrowImageYPoint, width: arrowImageWidth, height: arrowImageHeight)
    }
}
