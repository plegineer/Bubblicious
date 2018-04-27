//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate, CustomBackGroundViewDelegate {
    
    @IBOutlet var customView: CustomView!
    
    private var animationCustomView: CustomView!
    private var customBackGroundView: CustomBackGroundView!
    private var animationCustomViewMoveDistance: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.customView.delegate = self
    }
    
    @objc func logout() {
        
        Util.clearAllSavedData()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    @IBAction func pushedShowCustomButton(_ sender: Any) {
        let customBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        customBackGroundView.delegate = self
        self.customBackGroundView = customBackGroundView
        self.view.addSubview(self.customBackGroundView)
        self.addAnimationCustomView()
    }
    
    // MARK: - CustomViewDelegate
    func customViewTappedSaveButton(_ message: String, _ view: CustomView) {
        
        self.showAlert("保存完了", message: message)
        
        if view == animationCustomView {
            UIView.animate(withDuration: 0.3, animations: {
                self.animationCustomView.center.y += self.animationCustomViewMoveDistance
            }, completion: { _ in
                self.animationCustomView.removeFromSuperview()
                self.customBackGroundView.removeFromSuperview()
            })
        }
    }
    
    // MARK: - CustomBackGroundViewDlegate
    func customBackGroundViewTouched(_ view: CustomBackGroundView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.animationCustomView.center.y += self.animationCustomViewMoveDistance
        }, completion: { _ in
            self.customBackGroundView.removeFromSuperview()
            self.animationCustomView.removeFromSuperview()
        })
    }
    
    // MARK: - Private Method
    private func addAnimationCustomView() {
        
        let animationCustomViewSize = CGSize(width: 300, height: 250)
        let animationCustomViewXPoint = (self.customBackGroundView.frame.size.width - animationCustomViewSize.width) / 2
        let animationCustomViewYPoint = self.customBackGroundView.frame.size.height
        let animationCustomView = CustomView(frame: CGRect(
            x: animationCustomViewXPoint,
            y: animationCustomViewYPoint,
            width: animationCustomViewSize.width,
            height: animationCustomViewSize.height)
        )
        animationCustomView.layer.shadowColor = UIColor.black.cgColor
        animationCustomView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        animationCustomView.layer.shadowOpacity = 0.5
        animationCustomView.layer.shadowRadius = 5
        
        animationCustomView.delegate = self
        self.animationCustomView = animationCustomView
        self.animationCustomViewMoveDistance = (self.customBackGroundView.frame.size.height + animationCustomViewSize.height) / 2
        
        UIView.animate(withDuration: 0.3, animations: {
            self.animationCustomView.frame.origin.y -= self.animationCustomViewMoveDistance
        }, completion: nil)
        
        self.view.addSubview(self.animationCustomView)
    }
}
