//
//  ViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/20.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String, message: String, okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:okAction)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
