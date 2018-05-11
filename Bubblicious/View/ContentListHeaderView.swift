//
//  ContentListHeaderView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/11.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ContentListHeaderView: UIView {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    private func loadNib() {
        if let view = Bundle.main.loadNibNamed("ContentListHeaderView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.frame
            self.addSubview(view)
        }
    }
}
