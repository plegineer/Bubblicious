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
    @IBOutlet weak var imageView: UIImageView!
    
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
        
        let actionSheet = UIAlertController(title: "画像を開く", message: "選択してください", preferredStyle: .actionSheet)
        
        let saveTo1 = UIAlertAction(title: "ライブラリから選択", style: .default, handler: actionSheetChoose(sender:))
        let saveTo2 = UIAlertAction(title: "写真を撮る", style: .default, handler: actionSheetChoose(sender:))
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
            print("キャンセルしました")
        })
        
        actionSheet.addAction(saveTo1)
        actionSheet.addAction(saveTo2)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)

    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func actionSheetChoose(sender: UIAlertAction) {
        
        switch sender.title {
        case "ライブラリから選択":
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            _ = UIImagePickerControllerSourceType.photoLibrary
            self.present(imagePickerController, animated:true, completion:nil)
        case "写真を撮る":
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated:true, completion:nil)
        case "キャンセル":
            print("キャンセルしました")
        default:
            return
        }
        print("\(sender.title!)に保存しました")
    }
}
