//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomViewDelegate: class {
    func customViewTappedSaveButton(_ message: String , _ view: CustomView)
    func customViewWillShowKeyboard(view: CustomView)
    func customViewWillHideKeyboard(view: CustomView)
}

class CustomView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    weak var delegate: CustomViewDelegate?

    private var titleLabel1: UILabel!
    private var titleLabel2: UILabel!
    private var titleLabel3: UILabel!
    
    private var textField1: UITextField!
    private var textField2: UITextField!
    
    private var switchControl: UISwitch!
    private var saveButton: UIButton!
    private var switchText: String!
    
    private let dataList = ["hogehoge", "fugafuga", "fobar"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupItems()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = CGSize(width: 75, height: 30)
        let labelXPoint = CGFloat(15)
        self.titleLabel1.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 30), size: labelSize)
        self.titleLabel2.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 80), size: labelSize)
        self.titleLabel3.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 130), size: labelSize)
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = self.frame.size.width - textFieldSize.width - labelXPoint
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        let switchControlSize = switchControl.sizeThatFits(self.frame.size)
        let switchControlXPoint = textFieldXPoint + (textFieldSize.width / 2) - (switchControlSize.width / 2)
        self.switchControl.frame = CGRect(origin: CGPoint(x: switchControlXPoint, y: 130), size: switchControlSize)
        
        let buttonSize = saveButton.sizeThatFits(self.frame.size)
        let buttonXPoint = (self.frame.width - buttonSize.width) / 2
        self.saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
        
        self.addSubview(self.titleLabel1)
        self.addSubview(self.titleLabel2)
        self.addSubview(self.titleLabel3)
        self.addSubview(self.textField1)
        self.addSubview(self.textField2)
        self.addSubview(self.switchControl)
        self.addSubview(self.saveButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField2.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        self.textField1.text = dataList[row]
    }
    
    // MARK: - Action
    @objc func tappedSaveButton(_ sender: UIButton) {
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
        let message = "\(titleLabel1.text!):\(textField1.text!)\n\(titleLabel2.text!):\(textField2.text!)\n\(switchText!)"
        self.delegate?.customViewTappedSaveButton(message, self)
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        textField1.resignFirstResponder()
    }
    
    @objc func tappedSwitchControl(_ sender: UISwitch) {
        if sender.isOn {
            switchText = "\(titleLabel3.text!) is On"
        } else {
            switchText = "\(titleLabel3.text!) is Off"
        }
    }
    
    // MARK: - Private Method
    private func setupItems() {
        self.backgroundColor = .white
        self.createItems()
        self.setupNotification()
    }
    
    private func createItems() {
        self.titleLabel1 = createLabel("タイトル1")
        self.titleLabel2 = createLabel("タイトル2")
        self.titleLabel3 = createLabel("タイトル3")
        self.saveButton = createButton("保存する")
        self.switchControl = createSwitchControl()

        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItemStyle.done,
            target: self,
            action: #selector(self.tappedPickerViewButton(_:))
        )
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        pickerToolBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pickerToolBar.backgroundColor = .groupTableViewBackground
        pickerToolBar.setItems([doneButton], animated: false)
        
        let textField1 = createTextField("▼選択して下さい")
        textField1.inputView = pickerView
        textField1.inputAccessoryView = pickerToolBar
        self.textField1 = textField1
        
        let textField2 = createTextField("入力して下さい")
        textField2.delegate = self
        textField2.enablesReturnKeyAutomatically = true
        textField2.autocapitalizationType = .none
        textField2.autocorrectionType = .no
        self.textField2 = textField2
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }
    
    private func createTextField(_ placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }
    
    private func createSwitchControl() -> UISwitch {
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(self.tappedSwitchControl(_:)), for: UIControlEvents.valueChanged)
        return switchControl
    }
    
    private func createButton(_ title: String) -> UIButton {
        let saveButton = UIButton()
        saveButton.setTitle(title, for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        saveButton.addTarget(self, action: #selector(tappedSaveButton(_:)), for: .touchUpInside)
        self.switchText = "\(titleLabel3.text!) is Off"
        return saveButton
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        self.delegate?.customViewWillShowKeyboard(view: self)
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        self.delegate?.customViewWillHideKeyboard(view: self)
    }
}
