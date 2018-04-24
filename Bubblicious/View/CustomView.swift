//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class CustomView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let titleLabel1: UILabel
    private let titleLabel2: UILabel
    private let titleLabel3: UILabel
    
    private let textField1: UITextField
    private let textField2: UITextField
    
    private let switchControl: UISwitch
    private let saveButton: UIButton
    private var switchText: String
    
    private let pickerView1: UIPickerView
    private let pickerView2: UIPickerView
    private let dataList1 = ["hogehoge", "fugafuga", "fobar"]
    private let dataList2 = ["content1", "content2", "content3", "content4"]
    
    private var doneButton: UIBarButtonItem
    private var pickerToolBar: UIToolbar
    
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

        self.saveButton = UIButton()
        self.saveButton.setTitle("保存する", for: UIControlState.normal)
        self.saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        self.switchText = "\(titleLabel3.text!) is On"
        
        self.pickerView1 = UIPickerView()
        self.pickerView2 = UIPickerView()
        self.doneButton = UIBarButtonItem()
        self.pickerToolBar = UIToolbar()
        
        super.init(frame: frame)
        
        self.saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.switchControl.addTarget(self, action: #selector(switchControlTapped(_:)), for: UIControlEvents.valueChanged)
        
        self.doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneTapped(_:)))
        self.pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        pickerToolBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pickerToolBar.backgroundColor = .groupTableViewBackground
        pickerToolBar.setItems([doneButton], animated: false)
        
        pickerView1.tag = 1
        pickerView1.delegate = self
        pickerView1.dataSource = self
        self.textField1.inputView = pickerView1
        self.textField1.inputAccessoryView = pickerToolBar
        
        pickerView2.tag = 2
        pickerView2.delegate = self
        pickerView2.dataSource = self
        self.textField2.inputView = pickerView2
        self.textField2.inputAccessoryView = pickerToolBar

        self.backgroundColor = .white
        self.addSubview(titleLabel1)
        self.addSubview(titleLabel2)
        self.addSubview(titleLabel3)
        self.addSubview(textField1)
        self.addSubview(textField2)
        self.addSubview(switchControl)
        self.addSubview(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = CGSize(width: 100, height: 30)
        let labelXPoint = self.bounds.size.width / 2 - (30 + labelSize.width)

        self.titleLabel1.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 30), size: labelSize)
        self.titleLabel2.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 80), size: labelSize)
        self.titleLabel3.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 130), size: labelSize)

        let textFieldXPoint = self.bounds.size.width / 2 + 30
        
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: labelSize)
        self.textField1.borderStyle = UITextBorderStyle.roundedRect
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: labelSize)
        self.textField2.borderStyle = UITextBorderStyle.roundedRect
        
        let switchControlSize = self.switchControl.sizeThatFits(self.bounds.size)
        self.switchControl.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 130), size: switchControlSize)
        
        let buttonSize = self.saveButton.sizeThatFits(self.bounds.size)
        let buttonXPoint = (self.bounds.width - buttonSize.width) / 2
        self.saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
    }

    // MARK: - Touch Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return dataList1.count
        } else {
            return dataList2.count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return dataList1[row]
        } else {
            return dataList2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        
        if pickerView.tag == 1 {
            self.textField1.text = dataList1[row]
        } else {
            self.textField2.text = dataList2[row]
        }
    }
    
    // MARK: - Action
    @objc func buttonTapped(_ sender: UIButton) {
        
        print("保存しました")
        print("\(titleLabel1.text!) is \(textField1.text!)")
        print("\(titleLabel2.text!) is \(textField2.text!)")
        print(switchText)
    }
    
    @objc func doneTapped(_ sender: UIButton){
        
        textField2.resignFirstResponder()
        textField1.resignFirstResponder()
    }
    
    @objc func switchControlTapped(_ sender: UISwitch) {
        
        if sender.isOn {
            switchText = "\(titleLabel3.text!) is On"
        } else {
            switchText = "\(titleLabel3.text!) is Off"
        }
    }
}
