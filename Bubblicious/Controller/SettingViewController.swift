//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate, CustomBackGroundViewDelegate {
    
    private let modalDisplay = CustomView()
    private var movedModalDisplayYPoint: CGFloat = 0
    private var viewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private let customBackGroundView = CustomBackGroundView()
    private var keyboardShowModalDisplayYPoint: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        self.viewFrame = self.view.frame
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
        
        let modalDisplatSize = CGSize(width: 300, height: 250)
        let modalDisplayXPoint = (viewSize.width - modalDisplatSize.width) / 2
        let modalDisplayYPoint = viewSize.height
        
        self.modalDisplay.frame = CGRect(x: modalDisplayXPoint, y: modalDisplayYPoint,
                                         width: modalDisplatSize.width, height: modalDisplatSize.height)
        modalDisplay.delegate = self
        
        self.movedModalDisplayYPoint = (viewSize.height + self.modalDisplay.frame.size.height) / 2
        UIView.animate(withDuration: 0.3, animations: {self.modalDisplay.center.y -= self.movedModalDisplayYPoint}, completion: nil)
        
        // TODO: --
        self.customBackGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.customBackGroundView.frame = self.viewFrame
        customBackGroundView.delegate = self
        self.view.addSubview(self.customBackGroundView)
        self.view.addSubview(self.modalDisplay)
    }
    
    // MARK: - CustomViewDelegate
    func CustomViewTappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
        UIView.animate(withDuration: 1.0, animations: {self.modalDisplay.center.y += self.movedModalDisplayYPoint}, completion: nil)
        self.modalDisplay.removeFromSuperview()
    }
    
    func CustomViewKeyboardWillShow(_ keyboardRect: CGRect , _ view: CustomView) {
        
        let modalDisplayBotomMargine = self.view.frame.size.height - (self.modalDisplay.frame.origin.y + self.modalDisplay.frame.height)
        if modalDisplayBotomMargine < keyboardRect.height {
            print(self.modalDisplay.center.y)
            self.keyboardShowModalDisplayYPoint = keyboardRect.height - self.modalDisplay.frame.origin.y
            UIView.animate(withDuration: 0.2,
                           animations: {self.modalDisplay.center.y -= keyboardRect.height - self.modalDisplay.frame.origin.y},
                           completion: nil)
        }
    }
    
    func CustomViewKeyboardWillHide(_ keyboardRect: CGRect , _ view: CustomView) {
        
        let modalDisplayBotomMargine = self.view.frame.size.height - (self.modalDisplay.frame.origin.y + self.modalDisplay.frame.height)
        print(self.modalDisplay.center.y)
        UIView.animate(withDuration: 0.2,
                       animations: {self.modalDisplay.center.y += self.keyboardShowModalDisplayYPoint},
                       completion: nil)
        print(self.modalDisplay.center.y)
    }
    
    
    // MARK: - CustomBackGroundViewDlegate
    func touchedCustomBackGroundView(_ view: CustomBackGroundView) {
        UIView.animate(withDuration: 1.0, animations: {self.modalDisplay.center.y += 700.0}, completion: nil)
        self.customBackGroundView.removeFromSuperview()
        self.modalDisplay.endEditing(true)
    }
}
