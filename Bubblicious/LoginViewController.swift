//
//  LoginViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/18.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailTextField.delegate = self
        mailTextField.returnKeyType = .next // returnキーの表示をnextに
        mailTextField.keyboardType = .emailAddress //キーボードに@と,を表示
        mailTextField.enablesReturnKeyAutomatically = true // 入力エリアが空の場合、returnキーを非活性にする
        mailTextField.autocapitalizationType = .none // 自動補完OFF
        mailTextField.autocorrectionType = .no // キーボード上の予測候補OFF
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .go // returnキーの表示をgoに
        passwordTextField.keyboardType = .asciiCapable // スタンダードキーボードを表示
        passwordTextField.isSecureTextEntry = true //入力した文字列を伏字に
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        
//        mailTextField.text = ""
//        passwordTextField.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func attemptLogin() {
        print("login")
//        let params = ["email": self.mailTextField.text,
//                      "password": self.passwordTextField.text]
        
        self.jumpToNextView(iconRegistered: true, isFirstLogin: true)
    }
    
    func jumpToFirstView() {
        self.performSegue(withIdentifier: "OpenFirstView", sender: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tab = storyboard.instantiateViewController(withIdentifier: "tab") as! FirstViewController
//        self.navigationController?.pushViewController(tab, animated: true)
        print("FirstView")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(mailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if textField.isEqual(passwordTextField) {
            attemptLogin()
        }
        return true
    }
    
    private func jumpToNextView(iconRegistered: Bool, isFirstLogin: Bool) {
        if isFirstLogin {
            self.jumpToFirstView()
        }
    }
}
