//
//  ExpandableTableHeaderView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/14.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol ExpandableTableHeaderViewDelegate {
    func toggleSection(_ header: ExpandableTableHeaderView, section: Int)
}

class ExpandableTableHeaderView: UITableViewHeaderFooterView {
    
    static let height: CGFloat = 50
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var delegate: ExpandableTableHeaderViewDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        if let cell = gestureRecognizer.view as? ExpandableTableHeaderView {
            self.delegate?.toggleSection(self, section: cell.section)
        }
    }
    
    func setCollapsed(_ collapsed: Bool) {
        if collapsed {
            self.arrowImageView.image = UIImage(named: "arrow_default")
        } else {
            self.arrowImageView.image = UIImage(named: "arrow_expanded")
        }
    }
    
    private func loadNib() {
        if let view = Bundle.main.loadNibNamed("ExpandableTableViewHeaderView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.frame
            self.addSubview(view)
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(_:))))
        }
    }
}
