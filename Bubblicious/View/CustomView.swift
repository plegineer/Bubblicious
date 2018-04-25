//
//  CustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomViewDelegate: class {
    func CustomViewTappedSaveButton(_ message: String , _ view: CustomView)
    func CustomViewKeyboardWillShow(_ keyboardRect: CGRect, _ view: CustomView)
    func CustomViewKeyboardWillHide(_ keyboardRect: CGRect, _ view: CustomView)
}

class CustomView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private var titleLabel1: UILabel!
    private var titleLabel2: UILabel!
    private var titleLabel3: UILabel!
    
    private var textField1: UITextField!
    private var textField2: UITextField!
    
    private var switchControl: UISwitch!
    private var saveButton: UIButton!
    private var switchText: String!
    
    private let dataList = ["hogehoge", "fugafuga", "fobar"]
    
    private var keyboardRect: CGRect!
    
    weak var delegate: CustomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupItems()
        addPickerView()
        setTextFieldProperties()
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = CGSize(width: 75, height: 30)
        let labelXPoint = CGFloat(15)
        self.titleLabel1.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 30), size: labelSize)
        self.titleLabel2.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 80), size: labelSize)
        self.titleLabel3.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 130), size: labelSize)
        self.addSubview(titleLabel1)
        self.addSubview(titleLabel2)
        self.addSubview(titleLabel3)
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = self.frame.size.width - textFieldSize.width - labelXPoint
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        self.addSubview(textField1)
        self.addSubview(textField2)
        
        let switchControlSize = switchControl.sizeThatFits(self.frame.size)
        let switchControlXPoint = textFieldXPoint + (textFieldSize.width / 2) - (switchControlSize.width / 2)
        self.switchControl.frame = CGRect(origin: CGPoint(x: switchControlXPoint, y: 130), size: switchControlSize)
        self.addSubview(switchControl)
        
        let buttonSize = saveButton.sizeThatFits(self.frame.size)
        let buttonXPoint = (self.frame.width - buttonSize.width) / 2
        self.saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
        self.addSubview(saveButton)
    }

    // MARK: - Touch Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
        self.delegate?.CustomViewKeyboardWillHide(self.keyboardRect, self)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField2.resignFirstResponder()
        self.delegate?.CustomViewKeyboardWillHide(self.keyboardRect, self)
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
    @objc func tappedButton(_ sender: UIButton) {
        
        let message = "\(titleLabel1.text!):\(textField1.text!)\n\(titleLabel2.text!):\(textField2.text!)\n\(switchText!)"
        self.delegate?.CustomViewTappedSaveButton(message, self)
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        textField1.resignFirstResponder()
    }
    
    @objc func switchControlTapped(_ sender: UISwitch) {
        
        if sender.isOn {
            switchText = "\(titleLabel3.text!) is On"
        } else {
            switchText = "\(titleLabel3.text!) is Off"
        }
    }
    
    // MARK: - Private Method
    private func setupItems() {
        
        self.titleLabel1 = createLabel("タイトル1")
        self.titleLabel2 = createLabel("タイトル2")
        self.titleLabel3 = createLabel("タイトル3")
        self.textField1 = createTextField("hogehoge")
        self.textField2 = createTextField("content")
        self.switchControl = createSwitchControl()
        self.saveButton = createButton("保存する")
    }
    
    private func createLabel(_ text: String) -> UILabel {
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textAlignment = .center
        
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
        switchControl.addTarget(self, action: #selector(switchControlTapped(_:)), for: UIControlEvents.valueChanged)
        
        return switchControl
    }
    
    private func createButton(_ title: String) -> UIButton {
        
        let saveButton = UIButton()
        saveButton.setTitle(title, for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        saveButton.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        self.switchText = "\(titleLabel3.text!) is Off"
        
        return saveButton
    }
    
    private func addPickerView() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.tappedPickerViewButton(_:)))
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        pickerToolBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pickerToolBar.backgroundColor = .groupTableViewBackground
        pickerToolBar.setItems([doneButton], animated: false)
        
        self.textField1.inputView = pickerView
        self.textField1.inputAccessoryView = pickerToolBar
        self.textField1.text = dataList[0]
    }
    
    private func setTextFieldProperties() {
        
        textField2.delegate = self
        textField2.enablesReturnKeyAutomatically = true
        textField2.autocapitalizationType = .none
        textField2.autocorrectionType = .no
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRect = keyboard.cgRectValue
                self.keyboardRect = keyboardRect
                self.delegate?.CustomViewKeyboardWillShow(self.keyboardRect ,self)
            }
        }
    }
}
