//
//  PickerView.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/01.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol PickerViewDelegate: class {
    func pickerViewTappedSaveButton(_ message: String, _ view: PickerView)
    func pickerViewWillShowKeyboard(view: PickerView)
    func pickerViewWillHideKeyboard(view: PickerView)
}

class PickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var delegate: PickerViewDelegate?
    
    private(set) var dataListPickerView: DataListPickerView?
    
    private var textField1: UITextField!
    private var textField2: UITextField!
    
    private let dataList: String = "sample_picker_json.js"
    private var dataList1: [String] = []
    private var dataList2: [String] = []

    
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
        self.textField1.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 30), size: textFieldSize)
        self.textField2.frame = CGRect(origin: CGPoint(x: textFieldXPoint, y: 80), size: textFieldSize)
        
        self.addSubview(self.textField1)
        self.addSubview(self.textField2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.textFieldShouldEndEditing(textField1)
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
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.isEditing == true {
            textField2.text = ""
            self.settingPickerView2()
        }
        return true
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
        
        let pickerView1 = createPickerView()
        pickerView1.tag = 1
        
        let textField1 = createTextField("▼選択して下さい")
        textField1.inputView = pickerView1
        textField1.inputAccessoryView = self.createPickerViewButtonItem()
        self.textField1 = textField1
        
        let textField2 = createTextField("▼選択して下さい")
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
        textField2.inputView = pickerView2
        textField2.inputAccessoryView = self.createPickerViewButtonItem()
        
        if textField1.text == self.dataListPickerView?.contentsDataList[0] {
            self.dataList2 = (self.dataListPickerView?.content1DataList)!
        } else if textField1.text == self.dataListPickerView?.contentsDataList[1] {
            self.dataList2 = (self.dataListPickerView?.content2DataList)!
        } else if textField1.text == self.dataListPickerView?.contentsDataList[2] {
            self.dataList2 = (self.dataListPickerView?.content3DataList)!
        }
    }
    
    private func createTextField(_ placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }
    
    private func jsonParse() -> JSON {
        
        print("jsonParse start")
        let filePath = Bundle.main.path(forResource: "sample_picker_json", ofType: "js")
        
        do{
            let jsonStr = try String(contentsOfFile: filePath!)
            let json: JSON = JSON.parse(jsonStr)

            print(json)
            
            self.dataListPickerView = DataListPickerView(json: json)
            
            self.dataList1 = (self.dataListPickerView?.contentsDataList)!
            self.dataList2 = (self.dataListPickerView?.content1DataList)!
            
            return json
        } catch {
            return nil
        }
    }
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        
        self.textFieldShouldEndEditing(textField1)
        textField1.resignFirstResponder()
        textField2.resignFirstResponder()
    }
}
