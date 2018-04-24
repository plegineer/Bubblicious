//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class CustomView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let titleLabel1: UILabel
    let titleLabel2: UILabel
    let titleLabel3: UILabel
    
    let textField1: UITextField
    let textField2: UITextField
    
    let switchControl: UISwitch
    let button: UIButton
    
    var pickerView: UIPickerView
    let dataList = ["hogehoge", "fugafuga", "fobar"]
    
    override init(frame: CGRect) {

        self.titleLabel1 = UILabel()
        self.titleLabel1.text = "タイトル1"
        self.titleLabel1.textAlignment = .center
        
        self.titleLabel2 = UILabel()
        self.titleLabel2.text = "タイトル2"
        self.titleLabel2.textAlignment = .center
        
        self.titleLabel3 = UILabel()
        self.titleLabel3.text = "タイトル3"
        self.titleLabel3.textAlignment = .center
        
        self.textField1 = UITextField()
        self.textField1.text = "hogehoge"
        
        self.textField2 = UITextField()
        self.textField2.text = "content"
        
        self.switchControl = UISwitch()

        self.button = UIButton()
        self.button.setTitle("保存する", for: UIControlState.normal)
        self.button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        self.pickerView = UIPickerView()
        
        super.init(frame: frame)
        
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        pickerView.delegate = self
        pickerView.dataSource = self
    
        self.backgroundColor = .white
        self.addSubview(titleLabel1)
        self.addSubview(titleLabel2)
        self.addSubview(titleLabel3)
        self.addSubview(textField1)
        self.addSubview(textField2)
        self.addSubview(switchControl)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize1 = self.titleLabel1.sizeThatFits(self.bounds.size)
        let labelSize2 = self.titleLabel2.sizeThatFits(self.bounds.size)
        let labelSize3 = self.titleLabel3.sizeThatFits(self.bounds.size)

        self.titleLabel1.frame = CGRect(origin: CGPoint(x: 30, y: 30), size: labelSize1)
        self.titleLabel2.frame = CGRect(origin: CGPoint(x: 30, y: 80), size: labelSize2)
        self.titleLabel3.frame = CGRect(origin: CGPoint(x: 30, y: 130), size: labelSize3)
        
        let textFieldSize1 = self.textField1.sizeThatFits(self.bounds.size)
        let textFieldSize2 = self.textField2.sizeThatFits(self.bounds.size)
        let switchControlSize = self.switchControl.sizeThatFits(self.bounds.size)
        
        let textFieldXPoint = self.titleLabel1.frame.origin.x + 150
        
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize1)
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize2)
        self.switchControl.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 130), size: switchControlSize)
        
        let buttonSize = self.button.sizeThatFits(self.bounds.size)
        let buttonXPoint = (self.bounds.width - buttonSize.width) / 2
        self.button.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
    }
    
    @objc func buttonTapped(sender: Any) {
        print("保存しました")
        print(textField1.text!)
        print(textField2.text!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        self.textField1.text = dataList[row]
    }
}
