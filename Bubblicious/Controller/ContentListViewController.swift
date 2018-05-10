//
//  ContentListController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/04/18.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

// リスト(UITableView)系のサンプルコントローラークラス
class ContentListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var contents: [ContentData] = []
    private var extraContents: [ContentData] = []
    
    struct Identifier {
        static let basicCell = "basicCell"
        static let customCell = "contentCustomCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTempContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupTempContents() {
        let tempData: [[String]] = [
            ["https://xxxx/yyyy/hoge.png", "タイトル1", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル2", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル3", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル4", ""],
            ["", "タイトル5", ""],
            ["", "タイトル6", ""],
            ["", "タイトル7", ""],
            ["", "タイトル8", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル9", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル10", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "(追加読み込み分)タイトル11", ""], // ↓ここから追加読み込み分
            ["", "(追加読み込み分)タイトル12", ""],
            ["", "(追加読み込み分)タイトル13", "カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル14", ""],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル15", ""]
        ]
        
        for (index, datum) in tempData.enumerated() {
            let param = self.createTempContentParam(imageUrl: datum[0], title: datum[1], description: datum[2])
            if index < 10 {
                // 初期表示分の配列
                self.contents.append(ContentData(data: param))
            } else {
                // 追加読み込み分の配列
                self.extraContents.append(ContentData(data: param))
            }
        }
    }
    
    private func createTempContentParam(imageUrl: String, title: String, description: String) -> [String: String] {
        var param: [String: String] = [:]
        param[ContentData.ParamKey.imageUrl] = imageUrl
        param[ContentData.ParamKey.title] = title
        param[ContentData.ParamKey.description] = description
        return param
    }
    
}

extension ContentListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("")
        return self.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let content = self.contents[indexPath.row]
        
        var cell: UITableViewCell
        if content.description.isEmpty {
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
            
            if content.imageUrl.isEmpty {
                // 画像なしのベーシックセルの設定
                cell.textLabel?.text = content.title
            } else {
                // 画像ありのベーシックセルの設定
                cell.textLabel?.text = content.title
                
                // 本来ならば、imageUrlを(String->URL)に変換して、画像を取得し、取得した画像を表示させる(画像取得の際のエラーハンドリングは別途必要)
                // 今回は、imageUrlが入っていた場合、一律デフォルトの画像を表示
                cell.imageView?.image = UIImage(named: "top_appicon")
            }
            
        } else {
            // 画像なしのカスタムセル
            let customCell = tableView.dequeueReusableCell(withIdentifier: "contentCustomCell") as! ContentCustomTableViewCell
            customCell.titleLabel.text = content.title
            customCell.descriptionLabel.text = content.description
            cell = customCell
        }
        
        return cell
    }
}

extension ContentListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}

extension ContentListController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y <= 0 {
            print("通りましった！")
            return
        }
        
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height {
            print("こっち通りましった！")
        }
    }
}
