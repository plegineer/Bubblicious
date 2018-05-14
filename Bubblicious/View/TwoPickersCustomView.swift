//
//  TwoPickersCustomView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/01.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class TwoPickersCustomView: CustomBaseView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var firstTextField: UITextField!
    private var firstPickerView: UIPickerView!
    private var secondTextField: UITextField!
    private var secondPickerView: UIPickerView!
    private var saveButton: UIButton!
    
    private let pickerData: PickerData = PickerData()
    private var selectedFirstPickerContent: String = ""
    
    init(frame: CGRect, withShadow: Bool) {
        super.init(frame: frame)
        self.setupItems(withShadow: withShadow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = (self.frame.size.width - textFieldSize.width) / 2
        firstTextField.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        secondTextField.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        let buttonSize = saveButton.sizeThatFits(self.frame.size)
        let buttonXPoint = (self.frame.width - buttonSize.width) / 2
        saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
        
        self.addSubview(firstTextField)
        self.addSubview(secondTextField)
        self.addSubview(saveButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.firstPickerView {
            return self.pickerData.keys().count
        } else {
            return self.pickerData.values(key: selectedFirstPickerContent).count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.firstPickerView {
            return self.pickerData.keys()[row]
        } else {
            return self.pickerData.values(key: selectedFirstPickerContent)[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        if pickerView == self.firstPickerView {
            let selectedContent = self.pickerData.keys()[row]
            firstTextField.text = selectedContent
            self.selectedFirstPickerContent = selectedContent
            self.secondTextField.text = nil
            self.secondTextField.isEnabled = true
        } else {
            secondTextField.text = self.pickerData.values(key: selectedFirstPickerContent)[row]
        }
    }
    
    // MARK: - Action
    
    @objc func tappedSaveButton(_ sender: UIButton) {
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
        let message = "\(firstTextField.text!)\n\(secondTextField.text!)\n"
        self.delegate?.customBaseViewTappedSaveButton(message, self)
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
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
        self.saveButton = createButton("保存する", selector: #selector(tappedSaveButton(_:)))
        
        let firstTextField = createTextField("▼選択して下さい")
        let firstPickerView = createPickerView()
        firstTextField.inputView = firstPickerView
        firstTextField.inputAccessoryView = self.createPickerViewButtonItem()
        self.firstTextField = firstTextField
        self.firstPickerView = firstPickerView
        
        let secondTextField = createTextField("▼選択して下さい")
        let secondPickerView = createPickerView()
        secondTextField.isEnabled = false
        secondTextField.inputView = secondPickerView
        secondTextField.inputAccessoryView = self.createPickerViewButtonItem()
        self.secondTextField = secondTextField
        self.secondPickerView = secondPickerView
    }
    
    private func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }
    
    private func createPickerViewButtonItem() -> UIToolbar {
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
        return pickerToolBar
    }
}
