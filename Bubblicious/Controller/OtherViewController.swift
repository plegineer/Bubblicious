//
//  OtherViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController, CustomBaseViewDelegate {
    
    @IBOutlet weak var defaultView: ThreeContentsCustomView!
    @IBOutlet weak var defaultBackGroundView: CustomBackGroundView!
    @IBOutlet weak var showCustomViewButton: UIButton!
    @IBOutlet weak var showPickerViewButton: UIButton!
    @IBOutlet weak var jumpToSubFunctionButton: UIButton!
    
    private var animationCustomView: ThreeContentsCustomView!
    private var animationPickerView: TwoPickersCustomView!
    private var customBackGroundView: CustomBackGroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        self.defaultView.delegate = self
        self.defaultBackGroundView.delegate = self
        self.defaultBackGroundView.backgroundColor = UIColor.clear
    }
    
    @objc func logout() {
        Util.clearAllSavedData()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
    }
    
    // MARK: - IBAction
    
    @IBAction func pushedShowCustomViewButton(_ sender: Any) {
        self.addCutomViewWithAnimation(isPicker: false)
    }
    
    @IBAction func pushedPickerViewButton(_ sender: Any) {
        self.addCutomViewWithAnimation(isPicker: true)
    }
    
    @IBAction func pushedToOtherFunctionsButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "subFunctionList") as! SubFunctionListViewController
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - CustomBaseViewDelegate
    
    func customBaseViewTappedSaveButton(_ message: String, _ view: CustomBaseView) {
        self.showAlert("保存完了", message: message)
        
        if view == animationCustomView {
            let targetCustomView = view == animationCustomView ? self.animationCustomView : self.animationPickerView

            UIView.animate(withDuration: 0.3, animations: {
                targetCustomView.center.y += (self.view.frame.maxY - self.defaultView.frame.minY)
            }, completion: { _ in
                self.backToDefaultView()
            })
        }
    }
    
    func customBaseViewWillShowKeyboard(view: CustomBaseView) {
        if view == defaultView {
            self.toggleButtons(to: false)
        } else {
            self.customBackGroundView.isUserInteractionEnabled = false
        }
    }
    
    func customBaseViewWillHideKeyboard(view: CustomBaseView) {
        if view == defaultView {
            self.toggleButtons(to: true)
        } else {
            self.customBackGroundView.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Private Method
    
    private func addCustomBackGroundView() {
        let customBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        customBackGroundView.delegate = self
        self.view.addSubview(customBackGroundView)
        self.customBackGroundView = customBackGroundView
    }
    
    private func addCutomViewWithAnimation(isPicker: Bool) {
        
        self.toggleButtons(to: false)
        
        self.addCustomBackGroundView()
        
        let size = CGSize(width: 300, height: 250)
        let frame = CGRect(origin: CGPoint(x: (self.view.frame.size.width - size.width)/2, y: self.view.frame.maxY), size: size)
        let view = isPicker ? TwoPickersCustomView(frame: frame, withShadow: true) : ThreeContentsCustomView(frame: frame, withShadow: true)
        self.view.addSubview(view)
        
        if let picker = view as? TwoPickersCustomView {
            picker.delegate = self
            self.animationPickerView = picker
        }
        if let custom = view as? ThreeContentsCustomView {
            custom.delegate = self
            self.animationCustomView = custom
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin.y -= (self.view.frame.maxY - self.defaultView.frame.minY)
        }, completion: nil)
    }
    
    private func backToDefaultView() {
        self.customBackGroundView.removeFromSuperview()
        toggleButtons(to: true)
    }
    
    private func toggleButtons(to: Bool) {
        self.showCustomViewButton.isEnabled = to
        self.showPickerViewButton.isEnabled = to
        self.jumpToSubFunctionButton.isEnabled = to
    }
}

extension OtherViewController: CustomBackGroundViewDelegate {
    func customBackGroundViewTouched(_ view: CustomBackGroundView) {
        self.view.endEditing(true)
        if view == self.customBackGroundView {
            let displayingView = self.view.subviews.last is TwoPickersCustomView ? self.animationPickerView : self.animationCustomView
            UIView.animate(withDuration: 0.3, animations: {
                displayingView.center.y += (self.view.frame.maxY - self.defaultView.frame.minY)
            }, completion: { _ in
                displayingView.removeFromSuperview()
                self.backToDefaultView()
            })
        }
    }
}

extension OtherViewController: SubFunctionListViewControllerDelegate {
    func subFunctionListViewController(didFinished view: SubFunctionListViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
