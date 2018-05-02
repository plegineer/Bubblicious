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

    private var topTitleLabel: UILabel!
    private var topTextField: UITextField!
    
    private var middleTitleLabel: UILabel!
    private var middleTextField: UITextField!
    
    private var bottomTitleLabel: UILabel!
    private var bottomSwitchControl: UISwitch!
    
    private var saveButton: UIButton!
    private var switchText: String!
    
    private let pickerContents = ["hogehoge", "fugafuga", "fobar"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.backgroundColor = .white

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
        self.topTitleLabel.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 30), size: labelSize)
        self.middleTitleLabel.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 80), size: labelSize)
        self.bottomTitleLabel.frame = CGRect(origin: CGPoint(x: labelXPoint, y: 130), size: labelSize)
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = self.frame.size.width - textFieldSize.width - labelXPoint
        self.topTextField.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        self.middleTextField.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        let switchControlSize = bottomSwitchControl.sizeThatFits(self.frame.size)
        let switchControlXPoint = textFieldXPoint + (textFieldSize.width / 2) - (switchControlSize.width / 2)
        self.bottomSwitchControl.frame = CGRect(origin: CGPoint(x: switchControlXPoint, y: 130), size: switchControlSize)
        
        let buttonSize = saveButton.sizeThatFits(self.frame.size)
        let buttonXPoint = (self.frame.width - buttonSize.width) / 2
        self.saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
        
        self.addSubview(self.topTitleLabel)
        self.addSubview(self.middleTitleLabel)
        self.addSubview(self.bottomTitleLabel)
        self.addSubview(self.topTextField)
        self.addSubview(self.middleTextField)
        self.addSubview(self.bottomSwitchControl)
        self.addSubview(self.saveButton)
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContents.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        self.topTextField.text = pickerContents[row]
    }
    
    // MARK: - Action
    @objc func tappedSaveButton(_ sender: UIButton) {
        topTextField.resignFirstResponder()
        middleTextField.resignFirstResponder()
        let message = "\(topTitleLabel.text!):\(topTextField.text!)\n\(middleTitleLabel.text!):\(middleTextField.text!)\n\(switchText!)"
        self.delegate?.customViewTappedSaveButton(message, self)
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        topTextField.resignFirstResponder()
    }
    
    @objc func tappedSwitchControl(_ sender: UISwitch) {
        if sender.isOn {
            switchText = "\(bottomTitleLabel.text!) is On"
        } else {
            switchText = "\(bottomTitleLabel.text!) is Off"
        }
    }
    
    // MARK: - Private Method
    private func setupItems() {
        self.createItems()
        self.setNotifications()
    }
    
    private func createItems() {
        self.topTitleLabel = createLabel("タイトル1")
        self.middleTitleLabel = createLabel("タイトル2")
        self.bottomTitleLabel = createLabel("タイトル3")
        self.saveButton = createButton("保存する")
        self.bottomSwitchControl = createSwitchControl()

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
        
        let topTextField = createTextField("▼選択して下さい")
        topTextField.inputView = pickerView
        topTextField.inputAccessoryView = pickerToolBar
        self.topTextField = topTextField
        
        let middleTextField = createTextField("入力して下さい")
        middleTextField.delegate = self
        middleTextField.enablesReturnKeyAutomatically = true
        middleTextField.autocapitalizationType = .none
        middleTextField.autocorrectionType = .no
        self.middleTextField = middleTextField
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
        let bottomSwitchControl = UISwitch()
        bottomSwitchControl.addTarget(self, action: #selector(self.tappedSwitchControl(_:)), for: UIControlEvents.valueChanged)
        return bottomSwitchControl
    }
    
    private func createButton(_ title: String) -> UIButton {
        let saveButton = UIButton()
        saveButton.setTitle(title, for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        saveButton.addTarget(self, action: #selector(tappedSaveButton(_:)), for: .touchUpInside)
        self.switchText = "\(bottomTitleLabel.text!) is Off"
        return saveButton
    }
    
    private func setNotifications() {
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
