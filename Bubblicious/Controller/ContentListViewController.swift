//
//  ContentListController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/18.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

// リスト(UITableView)系のサンプルコントローラークラス
class ContentListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var contents: [ContentData] = []
    private var extraContents: [ContentData] = []
    private var isAppendedExtra: Bool = false
    
    private var footerIndicatorView: UIActivityIndicatorView!
    
    struct Identifier {
        static let basicCell = "basicCell"
        static let customCell = "contentCustomCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRefreshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestToGetContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func requestToGetContents() {
        // 本来であれば、APIを叩き、表示するデータを取得する
        // 今回は、固定のデータを利用し、プログラム内で配列を2つに分け、表示を出し分けしている
        
        let tempData: [[String]] = [
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", ""],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "タイトル", "カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容カスタムセルの内容"],
            ["", "(追加読み込み分)タイトル", ""], // ↓ここから追加読み込み分
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", "カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", ""],
            ["", "(追加読み込み分)タイトル", "カスタムセルの内容"],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""],
            ["https://xxxx/yyyy/hoge.png", "(追加読み込み分)タイトル", ""]
        ]
        
        self.contents.removeAll()
        self.extraContents.removeAll()
        
        for (index, datum) in tempData.enumerated() {
            let title = datum[1] + String(index+1)
            let param = self.createTempContentParam(imageUrl: datum[0], title: title, description: datum[2])
            if index < 20 {
                // 初期表示分の配列
                self.contents.append(ContentData(data: param))
            } else {
                // 追加読み込み分の配列
                self.extraContents.append(ContentData(data: param))
            }
        }
        
        self.isAppendedExtra = false
        self.tableView.reloadData()
    }
    
    private func createTempContentParam(imageUrl: String, title: String, description: String) -> [String: String] {
        var param: [String: String] = [:]
        param[ContentData.ParamKey.imageUrl] = imageUrl
        param[ContentData.ParamKey.title] = title
        param[ContentData.ParamKey.description] = description
        return param
    }
    
    private func setRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.doRefresh), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func doRefresh() {
        self.requestToGetContents()
        
        // 視覚的にわかりやすいよう、故意に1秒待つ処理を入れている
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}

extension ContentListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return footerIndicatorView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ContentList", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "contentDetail") as! ContentDetailViewController
        controller.selectedCellIndex = indexPath.row
        let backItem = UIBarButtonItem()
        backItem.title = "一覧"
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ContentListController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 最下部までスクロールしたかどうか
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height {
            
            // 本来であれば、フラグで管理するのではなく、追加で取得出来る件数があるか、などの判定式を利用する
            // 今回は、追加分の配列(extraContents)を1度だけ、表示させる配列(contents)に追加する
            if !isAppendedExtra {
                self.footerIndicatorView.isHidden = false
                self.footerIndicatorView?.startAnimating()
                self.isAppendedExtra = true
                
                // 視覚的にわかりやすいよう、故意に1秒待つ処理を入れている
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.contents.append(contentsOf: self.extraContents)
                    self.tableView.reloadData()
                    self.footerIndicatorView.stopAnimating()
                }
            }
        }
    }
}
