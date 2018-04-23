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
    
    private let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTextFieldProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Touch Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if mailTextField.isFirstResponder || passwordTextField.isFirstResponder {
            mailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(mailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if textField.isEqual(passwordTextField) {
            attemptLogin()
        }
        return true
    }
    
    // MARK: - Action
    @IBAction func pushedLoginButton(_ sender: Any) {
        attemptLogin()
    }
    
    // MARK: - Private Method
    private func attemptLogin() {
        
        let params = [
            "email": self.mailTextField.text!,
            "password": self.passwordTextField.text!
        ]
        
        let path = "login"
        
        self.userModel.login(params, path, callback: {(error) in
            if let error = error {
                // ログイン失敗時
                Log.d("Error\(error)")
                self.showAlert("エラー", message: error.localizedDescription)
                return
            }
            
            if let loginResult = self.userModel.loginResult {
                // ログイン成功時
                Log.d("Login Success!!")
                
                Util.saveObject(loginResult.accessToken, forKey: Const.Key.accessToken)
                Util.saveObject(loginResult.refreshToken, forKey: Const.Key.refreshToken)
                Util.saveObject(loginResult.expireDate, forKey: Const.Key.acesssTokenExpire)
                
                self.jumpToFirstView()
            }
        })
    }
    
    private func jumpToFirstView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tab = storyboard.instantiateViewController(withIdentifier: "tab")
        self.navigationController?.pushViewController(tab, animated: true)
    }
    
    private func setTextFieldProperties() {
        mailTextField.delegate = self
        mailTextField.returnKeyType = .next
        mailTextField.keyboardType = .emailAddress
        mailTextField.enablesReturnKeyAutomatically = true
        mailTextField.autocapitalizationType = .none
        mailTextField.autocorrectionType = .no
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .go
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        
        mailTextField.text = ""
        passwordTextField.text = ""
    }
}
