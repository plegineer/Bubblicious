//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView = UIPickerView()
    var label = UILabel()
    
    let dataList: [String] = ["hogehoge", "fugafuga", "fobar"]
//    let customView: UIView

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let customView = CustomView(frame: self.view.bounds)

        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.view.addSubview(customView)
        
        self.view.backgroundColor = UIColor(red: 0.87, green: 1.0, blue: 0.94, alpha: 1.0)
        
        // PickerView のサイズと位置
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        pickerView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        // PickerViewはスクリーンの中央に設定
        pickerView.center = self.view.center
        
        // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Label 位置はPickerViewより150上に設定、高さを２行表示分とる
        let yPosition = pickerView.frame.origin.y
        label.frame = CGRect(x: 0, y: yPosition - 100, width: self.view.frame.width, height: 100)
        
        // ラベルを２行表示
        label.numberOfLines = 2
        label.text = "pickerView"
        // フォントサイズを大きく
        label.font = UIFont.systemFont(ofSize: 36)
        // テキストを中央寄せにする
        label.textAlignment = NSTextAlignment.center
        
        
        self.view.addSubview(pickerView)
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logout() {
        
        Util.clearAllSavedData()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        label.text = dataList[row]
    }
}
