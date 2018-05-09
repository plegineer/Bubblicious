//
//  EditProfileViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import Eureka

protocol EditProfileViewControllerDelegate: class {
    func editProfileViewControllerPushedCloseButton(_ view: EditProfileViewController)
    func editProfileViewControllerPushedSaveButton(_ view: EditProfileViewController)
}

class EditProfileViewController: FormViewController {
    
    weak var delegate: EditProfileViewControllerDelegate?
    
    var userInfo: UserInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "プロフィール編集"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.pushedCloseButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.pushedSaveButton))
        
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func pushedCloseButton() {
        let alertController = UIAlertController(title: "編集画面を閉じますか？", message: "編集した内容は保存されません", preferredStyle: .alert)
        let destructiveAction = UIAlertAction(title: "閉じる", style: .destructive, handler: { _ in
            self.delegate?.editProfileViewControllerPushedCloseButton(self)
        })
        let defaultAction = UIAlertAction(title: "編集を続ける", style: .default, handler: nil)
        
        alertController.addAction(destructiveAction)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func pushedSaveButton() {
        let alertController = UIAlertController(title: "編集した内容で保存しますか？", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "保存する", style: .default, handler: { _ in
            
            // Comment: API(例: ユーザー情報更新API)での更新処理実行
            
            self.delegate?.editProfileViewControllerPushedSaveButton(self)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - TableView
    
    private func setupTableView() {
        // Comment: validationについて: https://github.com/xmartlabs/Eureka#validations
        //  今回は未実装
        form
            //************************
            // MARK: 氏名・生年月日
            +++ Section() {
                $0.tag = "nameBirthdaySection"
            }
            
            <<< TextRow () {
                $0.title = "姓"
                $0.value = userInfo.familyName ?? nil
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.familyName = $0.value
            }
            
            <<< TextRow () {
                $0.title = "名"
                $0.value = userInfo.firstName ?? nil
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.firstName = $0.value
            }
        
            <<< TextRow () {
                $0.title = "性(カナ)"
                $0.value = userInfo.familyNameKana ?? nil
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.familyNameKana = $0.value
            }
        
            <<< TextRow () {
                $0.title = "名(カナ)"
                $0.value = userInfo.firstNameKana ?? nil
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.firstNameKana = $0.value
            }
        
            <<< DateRow() {
                $0.title = "生年月日"
                if let birthday = userInfo.birthday {
                    $0.value = birthday
                } else {
                    $0.value = Date(dateString: "1970/1/1", dateFormat: "yyyy/M/d")
                }
                let formatter = DateFormatter()
                formatter.timeZone = NSTimeZone.system
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.calendar = Calendar(identifier: .gregorian)
                formatter.dateFormat = "yyyy/M/d"
                $0.dateFormatter = formatter
                $0.tag = "birthday"
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "", Helper.toBirthdayParam(from: $0.value) ?? "")
                self?.userInfo?.birthday = $0.value
            }
        
            //************************
            // MARK: 住所
            +++ Section() {
                $0.tag = "homeAddressSection"
            }
        
            <<< TextRow() {
                $0.title = "郵便番号"
                $0.placeholder = "5671234"
                $0.value = userInfo.postalCode ?? nil
                $0.tag = "postalCode"
            }.cellSetup { cell, _  in
                cell.textField.keyboardType = .numberPad
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo?.postalCode = $0.value
            }
            
            <<< PushRow<String>() {
                $0.title = "都道府県"
                $0.options = RegistrationConst.prefectures
                if let prefecture = userInfo.prefecture {
                    $0.value = Helper.toPrefName(from: prefecture)
                } else {
                    $0.value = "都道府県を選択"
                }
                $0.selectorTitle = "都道府県を選択してください"
                $0.tag = "prefecture"
            }.onPresent { from, to in
                to.dismissOnSelection = false
                to.dismissOnChange = false
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "",Helper.toPrefCode(from: $0.value) ?? 0)
                self?.userInfo?.prefecture = Helper.toPrefCode(from: $0.value)
            }
            
            <<< TextRow() {
                $0.title = "市区"
                $0.placeholder = "住所1"
                $0.value = userInfo.address1 ?? nil
                $0.tag = "address1"
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo?.address1 = $0.value
            }
            
            <<< TextRow() {
                $0.title = "町村・番地"
                $0.placeholder = "住所2"
                $0.value = userInfo.address2 ?? nil
                $0.tag = "address2"
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo?.address2 = $0.value
            }
        
            <<< TextRow() {
                $0.title = "マンション・アパート名"
                $0.baseCell.textLabel?.font = UIFont.systemFont(ofSize: 12)
                $0.placeholder = "住所3"
                $0.value = userInfo?.address3 ?? nil
                $0.tag = "address3"
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo?.address3 = $0.value
            }
        
            //************************
            // MARK: 電話番号・FAX番号
            +++ Section(){
                $0.tag = "telSection"
            }
            
            <<< TextRow () {
                $0.title = "電話番号"
                $0.placeholder = "09012345678"
                $0.value = userInfo?.telMain ?? nil
                $0.tag = "tellMain"
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
                }.onChange { [weak self] in
                    print("Changed:", $0.value ?? "")
                    self?.userInfo?.telMain = $0.value
            }
            
            <<< TextRow () {
                $0.title = "電話番号2"
                $0.placeholder = "0312345678"
                $0.value = userInfo.telSub ?? nil
                $0.tag = "telSub"
            }.cellSetup { cell, _  in
                cell.textField.keyboardType = .numberPad
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.telSub = $0.value
            }
        
            <<< TextRow () {
                $0.title = "FAX番号"
                $0.placeholder = "0312345678"
                $0.value = userInfo.fax ?? nil
                $0.tag = "fax"
            }.cellSetup { cell, _  in
                cell.textField.keyboardType = .numberPad
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.fax = $0.value
            }
        
            //************************
            // MARK: 性別・血液型
            +++ Section(){
                $0.tag = "genderBloodTypeSection"
            }
        
            <<< ActionSheetRow<String>() {
                $0.title = "性別"
                $0.selectorTitle = "性別を選択してください"
                $0.options = ["男","女"]
                if let gender = userInfo?.gender {
                    $0.value = Helper.toGenderPreview(from: gender)
                } else {
                    $0.value = "性別を選択"
                }
                $0.tag = "gender"
            }.onPresent { from, to in
                to.popoverPresentationController?.permittedArrowDirections = .up
            }.onChange{ [weak self] in
                print("Changed:", $0.value ?? "", Helper.toGenderParam(from: $0.value) ?? "")
                self?.userInfo.gender = Helper.toGenderParam(from: $0.value)
            }
        
            <<< PushRow<String>() {
                $0.title = "血液型"
                $0.options = ["A", "B", "O", "AB", "不明"]
                if let bloodType = userInfo?.bloodType {
                    $0.value = bloodType
                } else {
                    $0.value = "血液型を選択"
                }
                $0.selectorTitle = "血液型を選択してください"
                $0.tag = "bloodType"
                }.onPresent { from, to in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
            }.onChange { [weak self] in
                print("Changed:", $0.value ?? "")
                self?.userInfo.bloodType = $0.value
            }
        
    }
}

// MARK: - Helper Class

class Helper {
    
    static func toGenderParam(from genderPreview: String?) -> String? {
        guard let genderPreview = genderPreview else {
            return nil
        }
        switch genderPreview {
        case "男":
            return "male"
        case "女":
            return "female"
        default:
            return nil
        }
    }
    
    static func toGenderPreview(from genderParam: String) -> String {
        switch genderParam {
        case "male":
            return "男"
        case "female":
            return "女"
        default:
            return "性別を選択"
        }
    }
    
    static func toBirthdayParam(from birthday: Date?) -> String? {
        guard let birthday = birthday else {
            return nil
        }
        return birthday.string()
    }
    
    static func toPrefCode(from prefName: String?) -> String? {
        guard let prefName = prefName else {
            return nil
        }
        for (i, pref) in RegistrationConst.prefectures.enumerated() {
            if pref == prefName {
                return String(i+1)
            }
        }
        return nil
    }
    
    static func toPrefName(from prefCode: String) -> String? {
        guard let prefCodeInt = Int(prefCode) else {
            return nil
        }
        return RegistrationConst.prefectures[prefCodeInt-1]
    }
    
    
}

// MARK: - Const Class

struct RegistrationConst {
    static let prefectures = ["北海道",
                              "青森県",
                              "岩手県",
                              "宮城県",
                              "秋田県",
                              "山形県",
                              "福島県",
                              "茨城県",
                              "栃木県",
                              "群馬県",
                              "埼玉県",
                              "千葉県",
                              "東京都",
                              "神奈川県",
                              "新潟県",
                              "富山県",
                              "石川県",
                              "福井県",
                              "山梨県",
                              "長野県",
                              "岐阜県",
                              "静岡県",
                              "愛知県",
                              "三重県",
                              "滋賀県",
                              "京都府",
                              "大阪府",
                              "兵庫県",
                              "奈良県",
                              "和歌山県",
                              "鳥取県",
                              "島根県",
                              "岡山県",
                              "広島県",
                              "山口県",
                              "徳島県",
                              "香川県",
                              "愛媛県",
                              "高知県",
                              "福岡県",
                              "佐賀県",
                              "長崎県",
                              "熊本県",
                              "大分県",
                              "宮崎県",
                              "鹿児島県",
                              "沖縄県"]
}
