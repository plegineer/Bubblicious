//
//  ContentListViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/04/18.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContentListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var headerSearchView: ContentListHeaderView!
    private var footerIndicatorView: UIActivityIndicatorView!
    
    private var scrollStartOffset: CGPoint = .zero
    private var isAnimating: Bool = false
    private var isHeaderHidden: Bool = false
    
    private let contentModel = ContentModel()
    private let tempRequestParam: [String: Int] = ["temp": 1]
    
    // APIの呼び出しタイミング
    //  ・viewDidLoad()
    //  ・pullToRefresh
    //  ・一番下までスクロール時
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeaderSearchView()
        self.requestToGetContents()
        
        let switchControl = UISwitch(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        switchControl.addTarget(self, action: #selector(switchTapped(sender:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: switchControl)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func switchTapped(sender: UISwitch) {
        if sender.isOn {
            self.animateTabBar(isToHide: true)
        } else {
            self.animateTabBar(isToHide: false)
        }
    }
    
    private func requestToGetContents(isFromRefresh: Bool = false) {
        // APIリクエスト処理(初期表示アイテム取得)
        self.contentModel.getContents(tempRequestParam) { (error) in
            if let error = error {
                // 今回は絶対に通らない
                self.showAlert("UnExpected Error", message: error.localizedDescription)
            }
            
            if isFromRefresh {
                SVProgressHUD.dismiss()
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func addHeaderSearchView() {
        if let navigationBar = self.navigationController?.navigationBar {
            let origin = CGPoint(x: 0, y: navigationBar.frame.maxY)
            let size = CGSize(width: self.view.frame.size.width, height: 66)
            let contentListHeaderView = ContentListHeaderView(frame: CGRect(origin: origin, size: size))
            contentListHeaderView.delegate = self
            self.view.addSubview(contentListHeaderView)
            self.headerSearchView = contentListHeaderView
        }
    }
    
    private func animateTabBar(isToHide: Bool) {
        if let tabBar = self.tabBarController?.tabBar {
            UIView.animate(withDuration: 0.3) {
                if isToHide {
                    tabBar.frame.origin.y += tabBar.frame.size.height
                    self.tableView.frame.size.height += tabBar.frame.size.height
                } else {
                    tabBar.frame.origin.y -= tabBar.frame.size.height
                    self.tableView.frame.size.height -= tabBar.frame.size.height
                }
            }
        }
    }
    
    private func animateHeader(isToHide: Bool) {
        if !self.isAnimating {
            self.isAnimating = true
            UIView.animate(withDuration: 0.3, animations: {
                if isToHide {
                    self.headerSearchView.frame.origin.y -= self.headerSearchView.topView.frame.size.height
                } else {
                    self.headerSearchView.frame.origin.y += self.headerSearchView.topView.frame.size.height
                }
            }, completion: { _ in
                self.isAnimating = false
                self.isHeaderHidden = isToHide
            })
        }
    }
}

// MARK: - ContentListHeaderViewDelegate

extension ContentListViewController: ContentListHeaderViewDelegate {
    
    func contentListHeaderView(view: ContentListHeaderView, didPush saveButton: UIButton) {
        if let text = view.textField.text, !text.isEmpty {
            self.showAlert("絞り込みワード", message: text)
        } else {
            self.showAlert("絞り込みワード", message: "未設定")
        }
    }
}

// MARK: - UITableViewDataSource

extension ContentListViewController: UITableViewDataSource {
    
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
            // カスタムセルの設定
            let customCell = tableView.dequeueReusableCell(withIdentifier: "contentCustomCell") as! ContentCustomTableViewCell
            customCell.titleLabel.text = content.title
            customCell.descriptionLabel.text = content.description
            cell = customCell
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ContentListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerSearchView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let size = CGSize(width: self.view.frame.size.width, height: self.headerSearchView.frame.size.height)
        let view = UIView(frame: CGRect(origin: .zero, size: size))
        view.backgroundColor = UIColor.clear
        return view
    }
    
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

// MARK: - UIScrollViewDelegate

extension ContentListViewController: UIScrollViewDelegate {
    
    // 画面をタッチして、指をドラッグしたタイミング
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        self.scrollStartOffset = scrollView.contentOffset
    }
    
    // 指をドラッグして、画面から離したタイミング
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y < 0 && scrollView.contentOffset.y < self.scrollStartOffset.y {
            SVProgressHUD.show()
            self.requestToGetContents(isFromRefresh: true)
        }
        
        if self.isHeaderHidden && !scrollView.isDecelerating {
            self.animateHeader(isToHide: false)
        }
    }
    
    // scrollViewの動きが止まったタイミング
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.isHeaderHidden {
            self.animateHeader(isToHide: false)
        }
    }
    
    // スクロールの際、断続的に呼ばれる
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // pullToRefresh以外のスクロール、かつヘッダーが表示状態の場合のみ実行
        if scrollView.contentOffset.y > 0 && !isHeaderHidden {
            switch ScrollDirection(old: self.scrollStartOffset, new: scrollView.contentOffset).directionY {
                case .toTop:
                    break
                case .toBottom:
                    self.animateHeader(isToHide: true)
                case .none:
                    break
            }
        }
        
        // 最下部までスクロールしたかどうか
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height {
            // 追加アイテムの取得は1度のみ
            if !self.contentModel.isAppendedExtra {
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
