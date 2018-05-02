//
//  SubFunctionListViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

protocol SubFunctionListViewControllerDelegate: class {
    func subFunctionListViewController(didFinished view: SubFunctionListViewController)
}

class SubFunctionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SubFunctionListViewControllerDelegate?
    private let subFunctionListText = ["画像をアップロードする", "電話をかける", "GPSで現在位置を取得", "現在位置をMAPに表示", "メールを送る"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "その他機能"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.pushedCloseButton))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subFunctionListText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = subFunctionListText[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            callTell()
            return
        }
    }

    @objc func pushedCloseButton() {
        self.delegate?.subFunctionListViewController(didFinished: self)
    }
    
    func callTell() {
        UIApplication.shared.open(URL(string: "telprompt://0000000000")!, options: [:], completionHandler: { _ in
            if let indexPathForSelectedRow = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
            }
        })
    }
}
