//
//  ContentListHeaderView.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/11.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol ContentListHeaderViewDelegate {
    func contentListHeaderView( _ view: ContentListHeaderView, didPushed saveButton: UIButton)
}

class ContentListHeaderView: UIView {
    
    var delegate: ContentListHeaderViewDelegate?
    
    private(set) var topView: UIView!
    private(set) var textField: UITextField!
    private(set) var searchButton: UIButton!
    
    private(set) var bottomView: UIView!
    private(set) var bottomLabel: UILabel!
    
    let space: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pushedSearchButton(sender: UIButton) {
        self.delegate?.contentListHeaderView(self, didPushed: sender)
    }
    
    private func addComponents() {
        let topViewSize = CGSize(width: self.frame.size.width, height: self.frame.size.height/4*3)
        let bottomViewSize = CGSize(width: self.frame.size.width, height: self.frame.size.height/4)
        
        // top
        topView = UIView(frame: CGRect(origin: .zero, size: topViewSize))
        textField = self.createTextField()
        searchButton = self.createButton()
        topView.addSubview(textField)
        topView.addSubview(searchButton)
        
        // bottom
        bottomView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: topView.frame.maxY), size: bottomViewSize))
        bottomView.backgroundColor = UIColor.orange
        bottomLabel = self.createLabel()
        bottomView.addSubview(bottomLabel)

        self.addSubview(topView)
        self.addSubview(bottomView)
    }
    
    private func createTextField() -> UITextField {
        let textFieldSize = CGSize(width: self.frame.size.width/3*2-space*2, height: topView.frame.size.height-space*2)
        let textFieldOrigin = CGPoint(x: space, y: space)
        let textField = UITextField(frame: CGRect(origin: textFieldOrigin, size: textFieldSize))
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.delegate = self
        textField.placeholder = "フリーワード"
        return textField
    }
    
    private func createButton() -> UIButton {
        let buttonSize = CGSize(width: 120, height: topView.frame.size.height-space*2)
        let buttonOrigin = CGPoint(x: textField.frame.maxX + space, y: space)
        let button = UIButton(frame: CGRect(origin: buttonOrigin, size: buttonSize))
        button.setTitle("絞り込み", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.pushedSearchButton(sender:)), for: .touchUpInside)
        return button
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel(frame: CGRect(origin: .zero, size: bottomView.frame.size))
        label.text = "スクロール時に隠れない領域"
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }
}

extension ContentListHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
