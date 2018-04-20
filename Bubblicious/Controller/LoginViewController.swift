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
    
    // TODO: privateつけて
    let webApiManager = WebApiManager.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTextFieldProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func attemptLogin() {
        let params = ["email": self.mailTextField.text!,
                      "password": self.passwordTextField.text!]
        
        print("Login Success!!")
    
        // TODO: ---直して
        WebApiManager.sharedManager.post(callback: {(error) in
            if let error = error {
                print("Error", error)
                return
            }
            self.jumpToFirstView()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(mailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if textField.isEqual(passwordTextField) {
            attemptLogin()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if mailTextField.isFirstResponder || passwordTextField.isFirstResponder {
            mailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func pushedLoginButton(_ sender: Any) {
        
//        attemptLogin()
    }
    
    private func jumpToFirstView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tab = storyboard.instantiateViewController(withIdentifier: "tab")
        self.navigationController?.pushViewController(tab, animated: true)
    }
    
    private func setTextFieldProperties() {
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
        
        mailTextField.text = ""
        passwordTextField.text = ""
    }
}
