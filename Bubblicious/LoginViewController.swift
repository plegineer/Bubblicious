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
        
//        mailTextField.delegate = self
//        mailTextField.returnKeyType = .next
//        mailTextField.keyboardType = .emailAddress
//        mailTextField.enablesReturnKeyAutomatically = true
//        mailTextField.autocapitalizationType = .none
//        mailTextField.autocorrectionType = .no
//        
//        passwordTextField.delegate = self
//        passwordTextField.returnKeyType = .go
//        passwordTextField.keyboardType = .asciiCapable
//        passwordTextField.isSecureTextEntry = true
//        passwordTextField.enablesReturnKeyAutomatically = true
//        passwordTextField.autocapitalizationType = .none
//        passwordTextField.autocorrectionType = .no
//        
//        mailTextField.text = ""
//        passwordTextField.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
