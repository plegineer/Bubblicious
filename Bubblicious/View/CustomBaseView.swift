//
//  CustomBaseView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol CustomBaseViewDelegate: class {
    func customBaseViewTappedSaveButton(_ message: String , _ view: CustomBaseView)
}

class CustomBaseView: UIView {
    
    weak var delegate: CustomBaseViewDelegate?
    
    var isKeyBoardOpen: Bool = false
    
    func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }
    
    func createTextField(_ placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }
    
    func createSwitchControl(selector: Selector?) -> UISwitch {
        let switchControl = UISwitch()
        if let selector = selector {
            switchControl.addTarget(self, action: selector, for: UIControlEvents.valueChanged)
        }
        return switchControl
    }
    
    func createButton(_ title: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    func setNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        self.isKeyBoardOpen = true
    }
    
    @objc func keyboardDidHide(notification: Notification?) {
        self.isKeyBoardOpen = false
    }
}

extension CustomBaseView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
