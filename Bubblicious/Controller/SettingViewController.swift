//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate {
    
    private let ModalDisplay: CustomView = CustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let showModalButton = UIButton(frame: CGRect(x:0, y:0, width: 100, height: 30))
        showModalButton.center = self.view.center
        showModalButton.setTitle("show modal", for: .normal)
        showModalButton.setTitleColor(UIColor.blue, for: .normal)
        showModalButton.backgroundColor = UIColor.white
        showModalButton.addTarget(self, action: #selector(TappedModalButton(_:)), for: .touchUpInside)
        self.view.addSubview(showModalButton)
    }
    
    @objc func logout() {
        
        Util.clearAllSavedData()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    @objc func TappedModalButton(_ sender: UIButton) {
        
        let viewSize = self.view.frame.size
        let customViewSize = CGSize(width: 300, height: 250)
        let customViewXPoint = (viewSize.width - customViewSize.width) / 2
        let customView = CustomView(frame: CGRect(x: customViewXPoint, y: 800,
                                                  width: customViewSize.width, height: customViewSize.height))
        customView.delegate = self
        
        UIView.animate(withDuration: 1.0, animations: {customView.center.y -= 700.0}, completion: nil)
        self.view.addSubview(customView)
    }
    
    // MARK: - CustomViewDelegate
    func CustomViewTappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
    }
}
