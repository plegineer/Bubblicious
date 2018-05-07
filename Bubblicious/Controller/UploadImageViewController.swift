//
//  UploadImageViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import Photos

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "アップロード画面"
    }
    
    // MARK: - IBAction
    
    @IBAction func pushedOpenImageButton(_ sender: Any) {
        let actionLibrary = UIAlertAction(title: "ライブラリから選択", style: .default, handler: {(action: UIAlertAction) in
            self.pickImageFromLibrary()
        })
        let actionCamera = UIAlertAction(title: "写真を撮る", style: .default, handler: {(action: UIAlertAction) in
            self.pickImageFromCamera()
        })
        let actionCancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
            // do nothing
        })
        
        let controller = UIAlertController(title: "画像を開く", message: "選択してください", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            controller.addAction(actionLibrary)
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            controller.addAction(actionCamera)
        }
        controller.addAction(actionCancel)
        present(controller, animated: true, completion: nil)
    }
    
    // MARK - UIImagePickerControllerDelegate
    
    func imagePickerController(_ imagePicker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Method
    
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
}
