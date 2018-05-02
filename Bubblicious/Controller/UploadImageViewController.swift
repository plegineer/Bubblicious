//
//  UploadImageViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol UploadImageViewControllerDelegate: class {
    func UploadImageViewController(didFinished view: UploadImageViewController)
}

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: UploadImageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.pushedBackButton))
        self.title = "アップロード画面"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushedBackButton() {
        self.delegate?.UploadImageViewController(didFinished: self)
    }
    
    @IBAction func pushedOpenAlbumButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        _ = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePickerController, animated:true, completion:nil)
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismiss(animated: true, completion: nil);
    }
}
