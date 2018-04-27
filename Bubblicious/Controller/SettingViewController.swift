//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate, CustomBackGroundViewDelegate {
    
    @IBOutlet weak var defaultView: CustomView!
    @IBOutlet weak var defaultBackGroundView: CustomBackGroundView!
    @IBOutlet weak var showCustomViewButton: UIButton!
    
    private var animationCustomView: CustomView!
    private var customBackGroundView: CustomBackGroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.defaultView.delegate = self
        self.defaultBackGroundView.delegate = self
        self.defaultBackGroundView.backgroundColor = UIColor.clear
    }
    
    @objc func logout() {
        Util.clearAllSavedData()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    // MARK: - Action
    
    @IBAction func pushedShowCustomViewButton(_ sender: Any) {
        let customBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        customBackGroundView.delegate = self
        self.customBackGroundView = customBackGroundView
        self.view.addSubview(self.customBackGroundView)
        self.addAnimationCustomView()
        self.showCustomViewButton.isEnabled = false
    }
    
    // MARK: - CustomViewDelegate
    
    func customViewWillShowKeyboard(view: CustomView) {
        if view == animationCustomView {
            self.customBackGroundView.isUserInteractionEnabled = false
        }
    }
    
    func customViewWillHideKeyboard(view: CustomView) {
        if view == animationCustomView {
            self.customBackGroundView.isUserInteractionEnabled = true
        }
    }
    
    func customViewTappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
        if view == animationCustomView {
            UIView.animate(withDuration: 0.3, animations: {
                self.animationCustomView.center.y += (self.view.frame.maxY - self.defaultView.frame.minY)
            }, completion: { _ in
                self.backToDefaultView()
            })
        }
    }
    
    // MARK: - CustomBackGroundViewDlegate
    
    func customBackGroundViewTouched(_ view: CustomBackGroundView) {
        self.view.endEditing(true)
        
        if view == self.customBackGroundView {
            UIView.animate(withDuration: 0.3, animations: {
                self.animationCustomView.center.y += (self.view.frame.maxY - self.defaultView.frame.minY)
            }, completion: { _ in
                self.backToDefaultView()
            })
        }
    }

    // MARK: - Private Method
    
    private func addAnimationCustomView() {
        let animationCustomViewSize = CGSize(width: 300, height: 250)
        let animationCustomView = CustomView(frame: CGRect(
            x:(self.view.frame.size.width - animationCustomViewSize.width)/2,
            y: self.view.frame.maxY,
            width: animationCustomViewSize.width,
            height: animationCustomViewSize.height)
        )
        animationCustomView.layer.shadowColor = UIColor.black.cgColor
        animationCustomView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        animationCustomView.layer.shadowOpacity = 0.5
        animationCustomView.layer.shadowRadius = 5
        animationCustomView.delegate = self
        self.animationCustomView = animationCustomView
        self.view.addSubview(self.animationCustomView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.animationCustomView.frame.origin.y -= (self.view.frame.maxY - self.defaultView.frame.minY)
        }, completion: nil)
    }
    
    private func backToDefaultView() {
        self.animationCustomView.removeFromSuperview()
        self.customBackGroundView.removeFromSuperview()
        self.showCustomViewButton.isEnabled = true
    }
}
