//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class CustomView: UIView, UIPickerViewDelegate {
    
    let titleLabel1: UILabel
    var textField1: UITextField
    let switchControl: UISwitch
    let button: UIButton
    let picker: UIPickerView
    let dataList: [String] = ["hogehoge", "fugafuga", "fobar"]
    
    override init(frame: CGRect) {

        self.titleLabel1 = UILabel()
        self.titleLabel1.text = "Hello World!"
        self.titleLabel1.textAlignment = .center
        
        self.textField1 = UITextField()
        self.textField1.textAlignment = .center
        
        self.switchControl = UISwitch()
        
        self.button = UIButton()
        self.button.setTitle("保存する", for: UIControlState.normal)
        self.button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        self.picker = UIPickerView()
        self.picker.showsSelectionIndicator = true
        
        super.init(frame: frame)
        
        self.button.addTarget(self,
                              action: #selector(buttonTapped),
                              for: .touchUpInside)
        self.backgroundColor = .white
        self.addSubview(titleLabel1)
        self.addSubview(textField1)
        self.addSubview(switchControl)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = self.titleLabel1.sizeThatFits(self.bounds.size)
        
        let x = (self.bounds.width - labelSize.width) / 2
        let y = (self.bounds.height - labelSize.height) / 2
        
        self.titleLabel1.frame = CGRect(origin: CGPoint(x: x, y: y),
                                        size: labelSize)
        self.textField1.frame = CGRect(origin: CGPoint(x: x, y: y + 50.0),
                                       size: labelSize)
        self.textField1.borderStyle = .roundedRect
        self.switchControl.frame = CGRect(origin: CGPoint(x: x, y: y + 100.0),
                                          size: labelSize)
        self.button.frame = CGRect(origin: CGPoint(x: x, y: y + 150.0),
                                   size: labelSize)
    }
    
    @objc func buttonTapped(sender: Any) {
        print("保存しました")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("titleRorRow")
        return dataList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField1.text = dataList[row]
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}