//
//  ProfileViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var userInfo: UserInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestToGetUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedEditButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "editProfile") as! EditProfileViewController
        controller.delegate = self
        controller.userInfo = self.userInfo
        let nav = UINavigationController(rootViewController: controller)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    private func requestToGetUserInfo() {
        // フロー整理
        //  本来であれば、会員IDを元に、ユーザーの情報を取得する(=> ユーザー情報が取得できない場合、編集画面にも遷移できないような制御が必要)
        //  APIがないので、初期値固定ユーザーを生成
        self.userInfo = self.createTempUser()
        
        
        // TODO: --残--
        //  ・UILabel - UILabel のセットのviewなりを用意
        //  ・うまくUserInfoの各値を組み合わせて、用意した枠組みに表示する
    }
    
    private func createTempUser() -> UserInfo {
        var userInfo = UserInfo()
        userInfo.familyName = "山田"
        userInfo.firstName = "太郎"
        userInfo.familyNameKana = "ヤマダ"
        userInfo.firstNameKana = "タロウ"
        userInfo.birthday = Date()
        userInfo.postalCode = "1234567"
        userInfo.prefecture = "1"
        userInfo.address1 = "川越市"
        userInfo.address2 = "連雀町18"
        userInfo.address3 = "パークハイツ103"
        userInfo.telMain = "09012345678"
        userInfo.telSub = "0120123456"
        userInfo.fax = "012345678"
        userInfo.gender = "male"
        userInfo.bloodType = "A"
        return userInfo
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func editProfileViewControllerPushedCloseButton(_ view: EditProfileViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func editProfileViewControllerPushedSaveButton(_ view: EditProfileViewController) {
        
        self.dismiss(animated: true, completion: {
            
            // 本来であれば、再度リクエスト処理(例: ユーザー情報取得API)を投げる
            // APIがないので、EditProfileViewControllerで保持している変更済のuserInfoをそのまま参照して、画面に反映させる
            
            

            
        })
        
    }
}
