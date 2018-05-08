//
//  EditProfileViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate: class {
    func editProfileViewController(didFinished view: EditProfileViewController)
}

class EditProfileViewController: UIViewController {
    
    weak var delegate: EditProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.pushedCloseButton))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func pushedCloseButton() {
        let alertController = UIAlertController(title: "編集画面を閉じますか？", message: "編集した内容は保存されていません", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "編集を続ける", style: .default, handler: nil)
        let destructiveAction = UIAlertAction(title: "編集を辞める", style: .destructive, handler: { _ in
            self.delegate?.editProfileViewController(didFinished: self)
        })
        alertController.addAction(defaultAction)
        alertController.addAction(destructiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
