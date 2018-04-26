//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate, CustomBackGroundViewDelegate {
    
    private var modalDisplay: CustomView!
    private var customBackGroundView: CustomBackGroundView!
    private var didWillMoveModalDisplayYPoint: CGFloat = 0
    private var overlapModalDisplay: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let showModalButtonSize = CGSize(width: 100, height: 30)
        let showModalButtonXPoint = (self.view.frame.size.width - showModalButtonSize.width) / 2
        let showModalButtonYPoint = (self.view.frame.size.height - showModalButtonSize.height) / 2 - (self.navigationController?.navigationBar.frame.size.height)!
        let showModalButton = UIButton(frame: CGRect(x: showModalButtonXPoint , y: showModalButtonYPoint,
                                                     width: showModalButtonSize.width, height: showModalButtonSize.height))
        
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
        
        let customBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        customBackGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        customBackGroundView.delegate = self
        self.customBackGroundView = customBackGroundView
        self.view.addSubview(self.customBackGroundView)
        
        let modalDisplaySize = CGSize(width: 300, height: 250)
        let modalDisplayXPoint = (self.customBackGroundView.frame.size.width - modalDisplaySize.width) / 2
        let modalDisplayYPoint = self.customBackGroundView.frame.size.height
        let modalDisplay = CustomView(frame: CGRect(x: modalDisplayXPoint, y: modalDisplayYPoint,
                                                    width: modalDisplaySize.width, height: modalDisplaySize.height))
        modalDisplay.layer.shadowColor = UIColor.black.cgColor
        modalDisplay.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        modalDisplay.layer.shadowOpacity = 0.5
        modalDisplay.layer.shadowRadius = 5
        modalDisplay.delegate = self
        self.modalDisplay = modalDisplay
        self.didWillMoveModalDisplayYPoint = (self.customBackGroundView.frame.size.height + modalDisplaySize.height) / 2 + (self.navigationController?.navigationBar.frame.size.height)!
        UIView.animate(withDuration: 0.3, animations: {self.modalDisplay.frame.origin.y -= self.didWillMoveModalDisplayYPoint}, completion: nil)
        self.view.addSubview(self.modalDisplay)
    }
    
    // MARK: - CustomViewDelegate
    func CustomViewTappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
        UIView.animate(withDuration: 0.3, animations: {
            self.modalDisplay.center.y += self.didWillMoveModalDisplayYPoint
        }, completion: nil)
        self.modalDisplay.removeFromSuperview()
    }
    
    func CustomViewKeyboardWillShow(_ keyboardRect: CGRect , _ view: CustomView) {
        
        self.overlapModalDisplay = (self.customBackGroundView.frame.size.height - self.modalDisplay.frame.origin.y) - (self.modalDisplay.frame.size.height + keyboardRect.height)
        if overlapModalDisplay < 0 {
            UIView.animate(withDuration: 0.3,
                           animations: {self.modalDisplay.frame.origin.y -= abs(self.overlapModalDisplay)},
                           completion: nil)
        }
    }
    
    func CustomViewKeyboardWillHide(_ keyboardRect: CGRect , _ view: CustomView) {
        UIView.animate(withDuration: 0.3,
                       animations: {self.modalDisplay.center.y += abs(self.overlapModalDisplay)},
                       completion: nil)
    }
    
    // MARK: - CustomBackGroundViewDlegate
    func touchedCustomBackGroundView(_ view: CustomBackGroundView) {
        UIView.animate(withDuration: 0.3, animations: {self.modalDisplay.center.y += self.didWillMoveModalDisplayYPoint}, completion: nil)
        self.customBackGroundView.removeFromSuperview()
        self.modalDisplay.endEditing(true)
    }
}
