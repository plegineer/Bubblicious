//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let viewSize = self.view.frame.size
        let customViewSize = CGSize(width: 300, height: 250)
        let customViewXPoint = (viewSize.width - customViewSize.width) / 2
        let customView = CustomView(frame: CGRect(x: customViewXPoint, y: 30,
                                                  width: customViewSize.width, height: customViewSize.height))
        customView.delegate = self
        self.view.addSubview(customView)
    }
    
    @objc func logout() {
        
        Util.clearAllSavedData()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    // MARK: - CustomViewDelegate
    func tappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
    }
}
