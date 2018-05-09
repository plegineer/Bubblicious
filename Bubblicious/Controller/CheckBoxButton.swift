//
//  CheckBoxButton.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/09.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "checkBox_on")! as UIImage
    let uncheckedImage = UIImage(named: "checkBox_off")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
