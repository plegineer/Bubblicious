//
//  PickerViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/27.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    let dataLis = "sample_picker_json.js"
    let dataList = ["hogehoge", "fugafuga", "fobar"]
    var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPickerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @objc func tappedPickerViewButton(_ sender: UIButton){
        textField1.resignFirstResponder()
    }
    
    private func addPickerView() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let doneButton = UIBarButtonItem(
            title: "Done", style: UIBarButtonItemStyle.done,
            target: self, action: #selector(self.tappedPickerViewButton(_:))
        )
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        pickerToolBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pickerToolBar.backgroundColor = .groupTableViewBackground
        pickerToolBar.setItems([doneButton], animated: false)
        
        self.textField1.inputView = pickerView
        self.textField1.inputAccessoryView = pickerToolBar
        self.textField1.text = dataList[0]
    }
}
