//
//  ShowCustomViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ShowCustomViewController: UIViewController {
    
    @IBOutlet weak var showCustomViewButton: UIButton!
    @IBOutlet weak var showPickerViewButton: UIButton!
    
    private var animationCustomView: ThreeContentsCustomView!
    private var animationPickerView: TwoPickersCustomView!
    private var customBackGroundView: CustomBackGroundView!
    
    private let animationTopMargin: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.setupCustomBackGroundView()
    }
    
    // MARK: - IBAction
    
    @IBAction func pushedShowCustomViewButton(_ sender: Any) {
        self.addCutomViewWithAnimation(isPicker: false)
    }
    
    @IBAction func pushedPickerViewButton(_ sender: Any) {
        self.addCutomViewWithAnimation(isPicker: true)
    }
    
    // MARK: - Private Method
    
    private func setupCustomBackGroundView() {
        let customBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        customBackGroundView.delegate = self
        customBackGroundView.isHidden = true
        self.view.addSubview(customBackGroundView)
        self.customBackGroundView = customBackGroundView
    }
    
    private func addCutomViewWithAnimation(isPicker: Bool) {
        
        self.hideBackGroundView(to: false)

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
            view.center.y -= (self.view.frame.maxY - self.animationTopMargin)
        }, completion: nil)
    }
    
    private func hideBackGroundView(to: Bool) {
        self.customBackGroundView.isHidden = to
        self.showCustomViewButton.isEnabled = to
        self.showPickerViewButton.isEnabled = to
    }
}

extension ShowCustomViewController: CustomBaseViewDelegate {
    func customBaseViewTappedSaveButton(_ message: String, _ view: CustomBaseView) {
        self.showAlert("保存完了", message: message)
        
        let targetCustomView = view == animationCustomView ? self.animationCustomView : self.animationPickerView
        UIView.animate(withDuration: 0.3, animations: {
            targetCustomView.center.y += (self.view.frame.maxY - targetCustomView.frame.origin.y)
        }, completion: { _ in
            self.hideBackGroundView(to: true)
        })
    }
}

extension ShowCustomViewController: CustomBackGroundViewDelegate {
    func customBackGroundViewTouched(_ view: CustomBackGroundView) {
        let displayingView = self.view.subviews.last is TwoPickersCustomView ? self.animationPickerView : self.animationCustomView
        if !displayingView.isKeyBoardOpen {
            UIView.animate(withDuration: 0.3, animations: {
                displayingView.center.y += (self.view.frame.maxY - displayingView.frame.origin.y)
            }, completion: { _ in
                displayingView.removeFromSuperview()
                self.hideBackGroundView(to: true)
            })
        }
        self.view.endEditing(true)
    }
}
