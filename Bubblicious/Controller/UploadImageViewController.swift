//
//  UploadImageViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import Photos

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
    
    @objc func pushedBackButton() {
        self.delegate?.UploadImageViewController(didFinished: self)
    }
    
    @IBAction func pushedOpenImageButton(_ sender: Any) {
        
        let controller = UIAlertController(title: "画像を開く", message: "選択してください", preferredStyle: .actionSheet)
        let actionLibrary = UIAlertAction(title: "ライブラリから選択", style: .default, handler: {(action: UIAlertAction) in
            self.pickImageFromLibrary()
            
        })
        let actionCamera = UIAlertAction(title: "写真を撮る", style: .default, handler: {(action: UIAlertAction) in
            self.pickImageFromCamera()
            
        })
        let actionCancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
            // do nothing
        })
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            controller.addAction(actionLibrary)
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            controller.addAction(actionCamera)
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        if status == PHAuthorizationStatus.denied {
            let alert = UIAlertController(title: "ライブラリのアクセス権限が必要です", message: "設定画面で設定して下さい", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in }))
            showAlert("位置情報サービスの設定が「無効」になっています", message: "設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい")
        }
        controller.addAction(actionCancel)
        present(controller, animated: true, completion: nil)
    }
    
    private func pickImageFromLibrary() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(controller, animated: true, completion: nil)
    }
    
    private func pickImageFromCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.camera
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
