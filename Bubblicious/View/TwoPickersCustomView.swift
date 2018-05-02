//
//  TwoPickersCustomView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/01.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol PickerViewDelegate: class {
    func pickerViewTappedSaveButton(_ message: String, _ view: TwoPickersCustomView)
    func pickerViewWillShowKeyboard(view: TwoPickersCustomView)
    func pickerViewWillHideKeyboard(view: TwoPickersCustomView)
}

class TwoPickersCustomView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var delegate: PickerViewDelegate?
    
    private(set) var dataListPickerView: DataListPickerView!
    
    private var textField1: UITextField!
    private var textField2: UITextField!
    private var saveButton: UIButton!
    
    private let dataList: String = "sample_picker_json.js"
    private var dataList1: [String] = []
    private var dataList2: [String] = []
    private var listCheck: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupItems()
        self.jsonParse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupItems()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textFieldSize = CGSize(width: 150, height: 30)
        let textFieldXPoint = (self.frame.size.width - textFieldSize.width) / 2
        textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        let buttonSize = saveButton.sizeThatFits(self.frame.size)
        let buttonXPoint = (self.frame.width - buttonSize.width) / 2
        saveButton.frame = CGRect(origin: CGPoint(x: buttonXPoint, y: 180), size: buttonSize)
        
        self.addSubview(textField1)
        self.addSubview(textField2)
        self.addSubview(saveButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !(textField1.text == self.listCheck) {
            textField2.text = ""
            self.settingPickerView2()
        }
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
            textField1.text = dataList1[row]
        } else {
            textField2.text = dataList2[row]
        }
    }
    
    // MARK: - Action
    
    @objc func tappedSaveButton(_ sender: UIButton) {
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
        if !(textField1.text == self.listCheck) {
            textField2.text = ""
            self.settingPickerView2()
        } else {
            let message = "\(textField1.text!)\n\(textField2.text!)\n"
            self.delegate?.pickerViewTappedSaveButton(message, self)
        }
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        
        if !(textField1.text == self.listCheck) {
            textField2.text = ""
            self.settingPickerView2()
        }
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
    
    // MARK: - Private Method
    
    private func setupItems() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.backgroundColor = .white
        
        self.createItems()
        self.setupNotification()
    }
    
    private func createItems() {
        saveButton = createButton("保存する")
        
        let pickerView1 = createPickerView()
        pickerView1.tag = 1
        
        let textField1 = createTextField("▼選択して下さい")
        textField1.inputView = pickerView1
        textField1.inputAccessoryView = self.createPickerViewButtonItem()
        self.textField1 = textField1
        
        let textField2 = createTextField("▼選択して下さい")
        textField2.isEnabled = false
        self.textField2 = textField2
    }
    
    private func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }
    
    private func createPickerViewButtonItem() -> UIToolbar {
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
        return pickerToolBar
    }
    
    private func settingPickerView2() {
        let pickerView2 = createPickerView()
        pickerView2.tag = 2
        textField2.isEnabled = true
        textField2.inputView = pickerView2
        textField2.inputAccessoryView = self.createPickerViewButtonItem()
        
        if textField1.text == self.dataListPickerView.contentsDataList[0] {
            self.dataList2 = self.dataListPickerView.content1DataList
        } else if textField1.text == self.dataListPickerView.contentsDataList[1] {
            self.dataList2 = self.dataListPickerView.content2DataList
        } else if textField1.text == self.dataListPickerView.contentsDataList[2] {
            self.dataList2 = self.dataListPickerView.content3DataList
        }
        self.listCheck = textField1.text!
    }
    
    private func createTextField(_ placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }
    
    private func createButton(_ title: String) -> UIButton {
        let saveButton = UIButton()
        saveButton.setTitle(title, for: UIControlState.normal)
        saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        saveButton.addTarget(self, action: #selector(tappedSaveButton(_:)), for: .touchUpInside)
        return saveButton
    }
    
    private func jsonParse() {
        var jsonString: String!
        if let filePath = Bundle.main.path(forResource: "sample_picker_json", ofType: "js") {
            do {
                jsonString = try String(contentsOfFile: filePath)
                let json: JSON = JSON(parseJSON: jsonString)
                self.dataListPickerView = DataListPickerView(json: json)
                self.dataList1 = self.dataListPickerView.contentsDataList
                self.dataList2 = self.dataListPickerView.content1DataList
            } catch {
                Log.p("jsonファイルが見込めません")
            }
        } else {
            Log.p("指定されたファイルが見つかりません")
        }
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        self.delegate?.pickerViewWillShowKeyboard(view: self)
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        self.delegate?.pickerViewWillHideKeyboard(view: self)
    }
}
