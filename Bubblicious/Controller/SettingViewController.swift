//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

var nagigationBarHeight: CGFloat = 0

class SettingViewController: UIViewController, CustomViewDelegate, CustomBackGroundViewDelegate {
    
    private var customView: CustomView!
    private var animationCustomView: CustomView!
    private var customBackGroundView: CustomBackGroundView!
    private var moveDistanceCustomView: CGFloat = 0
    private var overlapAnimationCustomView: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.addCustomView()
        self.addShowCustomViewButton()
    }
    
    @objc func logout() {
        
        Util.clearAllSavedData()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    @objc func TappedShowCustomViewButton(_ sender: UIButton) {
        
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
                self.animationCustomView.center.y += self.moveDistanceCustomView
            }, completion: { finished in
                self.animationCustomView.removeFromSuperview()
                self.customBackGroundView.removeFromSuperview()
            })
        }
    }
    
    // MARK: - CustomBackGroundViewDlegate
    func customBackGroundViewTouched(_ view: CustomBackGroundView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.animationCustomView.center.y += self.moveDistanceCustomView
            
        },completion: {
            finished in self.customBackGroundView.removeFromSuperview()
                        self.animationCustomView.removeFromSuperview()
        })
    }
    
    // MARK: - Private Method
    private func addShowCustomViewButton() {
        
        let showCustomViewButtonSize = CGSize(width: 200, height: 30)
        let showCustomViewButtonXPoint = (self.view.frame.size.width - showCustomViewButtonSize.width) / 2
        let showCustomViewButtonYPoint = (self.view.frame.size.height - showCustomViewButtonSize.height) / 2
            - (self.navigationController?.navigationBar.frame.size.height)!
        let showCustomViewButton = UIButton(frame: CGRect(x: showCustomViewButtonXPoint , y: showCustomViewButtonYPoint,
                                                          width: showCustomViewButtonSize.width, height: showCustomViewButtonSize.height))
        showCustomViewButton.setTitle("カスタムビューを表示", for: .normal)
        showCustomViewButton.setTitleColor(UIColor.blue, for: .normal)
        showCustomViewButton.backgroundColor = UIColor.white
        showCustomViewButton.addTarget(self, action: #selector(TappedShowCustomViewButton(_:)), for: .touchUpInside)
        self.view.addSubview(showCustomViewButton)
    }
    
    private func addAnimationCustomView() {
        
        let animationCustomViewSize = CGSize(width: 300, height: 250)
        let animationCustomViewXPoint = (self.customBackGroundView.frame.size.width - animationCustomViewSize.width) / 2
        let animationCustomViewYPoint = self.customBackGroundView.frame.size.height
        let animationCustomView = CustomView(frame: CGRect(x: animationCustomViewXPoint, y: animationCustomViewYPoint,
                                                           width: animationCustomViewSize.width, height: animationCustomViewSize.height))
        animationCustomView.layer.shadowColor = UIColor.black.cgColor
        animationCustomView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        animationCustomView.layer.shadowOpacity = 0.5
        animationCustomView.layer.shadowRadius = 5
        animationCustomView.delegate = self
        self.animationCustomView = animationCustomView
        self.moveDistanceCustomView = (self.customBackGroundView.frame.size.height + animationCustomViewSize.height) / 2
            + (self.navigationController?.navigationBar.frame.size.height)!
        UIView.animate(withDuration: 0.3, animations: {self.animationCustomView.frame.origin.y -= self.moveDistanceCustomView}, completion: nil)
        self.view.addSubview(self.animationCustomView)
    }
    
    // MARK: - TODO
    
    private func addCustomView() {

        let customViewSize = CGSize(width: self.view.frame.width, height: 250)
        let customViewXPoint = (self.view.frame.size.width - customViewSize.width) / 2
        let customViewYPoint: CGFloat = 0
        let customView = CustomView(frame: CGRect(x: customViewXPoint, y: customViewYPoint,
                                                           width: customViewSize.width, height: customViewSize.height))
        customView.delegate = self
        self.customView = customView
        self.moveDistanceCustomView = (self.view.frame.size.height + customViewSize.height) / 2
            + (self.navigationController?.navigationBar.frame.size.height)!
        self.view.addSubview(self.customView)
    }
}
