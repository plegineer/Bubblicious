//
//  SettingViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/19.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, CustomViewDelegate, TempViewDelegate {
    
    private let modalDisplay = CustomView()
    private var movedModalDisplayYPoint: CGFloat = 0
    
    private var tempView: TempView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(title: "Logout", style: .plain,
                                          target: self, action: #selector(logout))
        
        self.navigationItem.rightBarButtonItem = rightButton
        
//        self.view.isUserInteractionEnabled = true
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEnd(sender:))))
        
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
        let view = TempView(frame: self.view.frame)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.delegate = self
        self.tempView = view
        self.view.addSubview(view)
        
        
        
        self.view.addSubview(self.modalDisplay)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.animate(withDuration: 1.0, animations: {self.modalDisplay.center.y += 700.0}, completion: nil)
////        self.modalDisplay.removeFromSuperview()
//    }
    
    // MARK: - CustomViewDelegate
    func CustomViewTappedSaveButton(_ message: String, _ view: CustomView) {
        self.showAlert("保存完了", message: message)
        UIView.animate(withDuration: 1.0, animations: {self.modalDisplay.center.y += self.movedModalDisplayYPoint}, completion: nil)
    }
    
    func tempViewTouched(_ view: TempView) {
        UIView.animate(withDuration: 1.0, animations: {self.modalDisplay.center.y += 700.0}, completion: nil)
        self.tempView.removeFromSuperview()
    }
    
}

protocol TempViewDelegate {
    func tempViewTouched(_ view: TempView)
}
class TempView: UIView {
    var delegate: TempViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.delegate?.tempViewTouched(self)
    }
}
