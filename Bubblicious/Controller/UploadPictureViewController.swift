//
//  UploadPictureViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol UploadPictureViewControllerDelegate: class {
    func UploadPictureViewController(didFinished view: UploadPictureViewController)
}

class UploadPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: UploadPictureViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(self.pushedBackButton))
        self.title = "アップロード画面"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushedBackButton() {
        self.delegate?.UploadPictureViewController(didFinished: self)
    }
    
    @IBAction func pushedOpenAlbumButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePickerController, animated:true, completion:nil)
    }
    
    // 画像が選択されたときによばれます
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        // アルバム画面を閉じます
        picker.dismiss(animated: true, completion: nil);
    }
}
