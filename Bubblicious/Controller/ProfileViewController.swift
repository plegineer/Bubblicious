//
//  ProfileViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    private var userInfo: UserInfo!
    
    private enum RowIndex: Int {
        case name
        case kanaName
        case birthday
        case gender
        case bloodType
        case postalCode
        case address
        case telMain
        case telSub
        case fax
        
        case _count
        static let count = Int(_count.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestToGetUserInfo()
        self.profileTableView.tableFooterView = UIView(frame: .zero)
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
        //  本来: 会員IDを元に、ユーザーの情報を取得する(-> ユーザー情報が取得できない場合、編集画面にも遷移できないような制御が必要)
        //  今回: APIがないので、初期値固定のユーザーを生成
        self.userInfo = self.createTempUser()
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

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowIndex.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as! ProfileTableViewCell
        let userInfoParams = self.userInfo.displayParams()
        
        switch indexPath.row {
            case RowIndex.name.rawValue:
                profileCell.titleLabel.text = "名前"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.name]
            case RowIndex.kanaName.rawValue:
                profileCell.titleLabel.text = "カナ"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.kanaName]
            case RowIndex.birthday.rawValue:
                profileCell.titleLabel.text = "誕生日"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.birthday]
            case RowIndex.gender.rawValue:
                profileCell.titleLabel.text = "性別"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.gender]
            case RowIndex.bloodType.rawValue:
                profileCell.titleLabel.text = "血液型"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.bloodType]
            case RowIndex.postalCode.rawValue:
                profileCell.titleLabel.text = "郵便番号"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.postalCode]
            case RowIndex.address.rawValue:
                profileCell.titleLabel.text = "住所"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.address]
            case RowIndex.telMain.rawValue:
                profileCell.titleLabel.text = "電話番号"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.telMain]
            case RowIndex.telSub.rawValue:
                profileCell.titleLabel.text = "電話番号2"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.telSub]
            case RowIndex.fax.rawValue:
                profileCell.titleLabel.text = "FAX番号"
                profileCell.valueLabel.text = userInfoParams[UserInfo.ParamKey.fax]
            default:
                break
        }

        return profileCell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func editProfileViewControllerPushedCloseButton(_ view: EditProfileViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func editProfileViewControllerPushedSaveButton(_ view: EditProfileViewController) {
        self.dismiss(animated: true, completion: {
            //  本来: リクエスト処理(例: ユーザー情報取得API)を投げる
            //  今回: APIがないので、EditProfileViewControllerで保持している変更済のuserInfoで上書きする
            self.userInfo = view.userInfo
            self.profileTableView.reloadData()
        })
        
    }
}
