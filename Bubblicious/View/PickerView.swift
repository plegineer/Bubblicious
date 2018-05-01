//
//  PickerView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/01.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    func pickerViewTappedSaveButton(_ message: String, _ view: PickerView)
    func pickerViewWillShowKeyboard(view: PickerView)
    func pickerViewWillHideKeyboard(view: PickerView)
}

class PickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: PickerViewDelegate?
    
    private var textField1: UITextField!
    private var textField2: UITextField!
    
    private let dataLis = "sample_picker_json.js"
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
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = (self.frame.size.width - textFieldSize.width) / 2
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        self.addSubview(self.textField1)
        self.addSubview(self.textField2)
    }
    
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
        return dataList.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        self.textField1.text = dataList[row]
    }
    
    // MARK: - Private Method
    private func setupItems() {
        self.backgroundColor = .white
        self.createItems()
        //        self.setupNotification()
    }
    
    // MARK: - Action
    @objc func tappedSaveButton(_ sender: UIButton) {
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
        let message = "\(textField1.text!)\n\(textField2.text!)\n"
        self.delegate?.pickerViewTappedSaveButton(message, self)
    }
    
    private func createItems() {
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
        //        textField2.delegate = self
        textField2.enablesReturnKeyAutomatically = true
        textField2.autocapitalizationType = .none
        textField2.autocorrectionType = .no
        self.textField2 = textField2
    }
    
    private func createTextField(_ placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        textField1.resignFirstResponder()
    }
    
}
