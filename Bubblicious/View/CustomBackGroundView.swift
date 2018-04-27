//
//  CustomBackGroundView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/25.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomBackGroundViewDelegate: class {
    func customBackGroundViewTouched(_ view: CustomBackGroundView)
}

class CustomBackGroundView: UIView {
    weak var delegate: CustomBackGroundViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.delegate?.customBackGroundViewTouched(self)
    }
}
