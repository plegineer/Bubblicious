//
//  ProfileViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedEditButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "editProfile") as! EditProfileViewController
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func editProfileViewController(didFinished view: EditProfileViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
