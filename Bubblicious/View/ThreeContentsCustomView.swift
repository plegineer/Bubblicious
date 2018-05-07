//
//  ThreeContentsCustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/23.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ThreeContentsCustomView: CustomBaseView, UIPickerViewDelegate, UIPickerViewDataSource {

    private var topTitleLabel: UILabel!
    private var topTextField: UITextField!
    private var middleTitleLabel: UILabel!
    private var middleTextField: UITextField!
    private var bottomTitleLabel: UILabel!
    private var bottomSwitchControl: UISwitch!
    private var saveButton: UIButton!
    
    private let pickerContents = ["hogehoge", "fugafuga", "fobar"]
    
    init(frame: CGRect, withShadow: Bool) {
        super.init(frame: frame)
        self.setupItems(withShadow: withShadow)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        topTextField.resignFirstResponder()
        middleTextField.resignFirstResponder()
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
        let switchText = self.bottomSwitchControl.isOn ? "On" : "Off"
        let message = "\(topTitleLabel.text!): \(topTextField.text!)\n\(middleTitleLabel.text!): \(middleTextField.text!)\n \(bottomTitleLabel.text!): \(switchText)"
        self.delegate?.customBaseViewTappedSaveButton(message, self)
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        topTextField.resignFirstResponder()
    }
    
    // MARK: - Private Method
    private func setupItems(withShadow: Bool = false) {
        self.backgroundColor = .white
        self.setNotifications()

        if withShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 5
        }
        
        self.createItems()
    }
    
    private func createItems() {
        self.topTitleLabel = createLabel("タイトル1")
        self.middleTitleLabel = createLabel("タイトル2")
        self.bottomTitleLabel = createLabel("タイトル3")
        self.saveButton = createButton("保存する", selector: #selector(tappedSaveButton(_:)))
        self.bottomSwitchControl = createSwitchControl(selector: nil)

        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        let doneButton = UIBarButtonItem(
            title: "OK",
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
}
