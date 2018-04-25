//
//  CustomBackGroundView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/25.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomBackGroundViewDelegate: class {
    func touchedCustomBackGroundView(_ view: CustomBackGroundView)
}

class CustomBackGroundView: UIView {
    weak var delegate: CustomBackGroundViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.delegate?.touchedCustomBackGroundView(self)
    }
}
