//
//  CustomBackGroundView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/25.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomBackGroundViewDelegate: class {
    func customBackGroundViewTouched(_ view: CustomBackGroundView)
}

class CustomBackGroundView: UIView {
    
    weak var delegate: CustomBackGroundViewDelegate?
    
    let minAlpha: CGFloat = 0
    let maxAlpha: CGFloat = 0.6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(maxAlpha)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.delegate?.customBackGroundViewTouched(self)
    }
}
