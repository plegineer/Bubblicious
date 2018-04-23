//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let titleLabel1: UILabel
    
    override init(frame: CGRect) {

        self.titleLabel1 = UILabel()
        self.titleLabel1.text = "Hello World!"
        self.titleLabel1.textAlignment = .center
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(titleLabel1)
//        self.commonInit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = self.titleLabel1.sizeThatFits(self.bounds.size)
        
        let x = (self.bounds.width - labelSize.width) / 2
        let y = (self.bounds.height - labelSize.height) / 2
        
        let labelOrigin = CGPoint(x: x, y: y)
        
        self.titleLabel1.frame = CGRect(origin: labelOrigin, size: labelSize)
    }
    
    private func commonInit() {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
