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
    
    private let contentModel = ContentModel()
    private let tempRequestParam: [String: Int] = ["temp": 1]
    
    private var footerIndicatorView: UIActivityIndicatorView!
    
    // APIの呼び出しタイミング
    //  ・viewWillAppear()
    //  ・pullToRefresh
    //  ・一番下までスクロール時
    
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
    
    private func requestToGetContents(isFromRefresh: Bool = false) {
        // APIリクエスト処理(初期表示アイテム取得)
        self.contentModel.getContents(tempRequestParam) { (error) in
            if let error = error {
                // 今回は絶対に通らない
                self.showAlert("UnExpected Error", message: error.localizedDescription)
            }
            
            if isFromRefresh {
                self.tableView.refreshControl?.endRefreshing()
            }
            
            self.contentModel.isAppendedExtra = false
            self.tableView.reloadData()
        }
    }
    
    private func setRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.doRefresh), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func doRefresh() {
        self.requestToGetContents(isFromRefresh: true)
    }
}

extension ContentListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentModel.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let content = self.contentModel.contents[indexPath.row]
        
        var cell: UITableViewCell
        if content.description.isEmpty {
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
            
            if content.imageUrl.isEmpty {
                // 画像なしベーシックセルの設定
                cell.textLabel?.text = content.title
            } else {
                // 画像ありベーシックセルの設定
                cell.textLabel?.text = content.title
                
                // 本来: imageUrlを(String->URL)に変換して、画像を取得し、取得した画像を表示させる(画像取得の際のエラーハンドリングは別途必要)
                // 今回: imageUrlが入っていた場合、一律デフォルトの画像を表示
                cell.imageView?.image = UIImage(named: "top_appicon")
            }
            
        } else {
            // 画像なしカスタムセルの設定
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
            // 追加アイテムの取得は1度のみ
            if !self.contentModel.isAppendedExtra {
                self.contentModel.isAppendedExtra = true
                self.footerIndicatorView?.startAnimating()
                
                // APIリクエスト処理(追加アイテム取得)
                self.contentModel.getMoreContents(tempRequestParam) { (error) in
                    if let error = error {
                        // 今回は絶対に通らない
                        self.showAlert("UnExpected Error", message: error.localizedDescription)
                    }
                    self.tableView.reloadData()
                    self.footerIndicatorView.stopAnimating()
                }
            }
        }
    }
}
