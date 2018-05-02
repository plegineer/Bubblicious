//
//  SubFunctionListViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import MessageUI

protocol SubFunctionListViewControllerDelegate: class {
    func subFunctionListViewController(didFinished view: SubFunctionListViewController)
}

class SubFunctionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    weak var delegate: SubFunctionListViewControllerDelegate?
    private let subFunctionListText = ["画像をアップロードする", "電話をかける", "GPSで現在位置を取得", "現在位置をMAPに表示", "メールを送る"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "その他機能"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.pushedCloseButton))
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subFunctionListText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = subFunctionListText[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            callTell()
            return
        } else if indexPath.row == 4 {
            openMail()
        }
        if let indexPathForSelectedRow = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @objc func pushedCloseButton() {
        self.delegate?.subFunctionListViewController(didFinished: self)
    }
    
    // MARK: - Private Method
    
    private func callTell() {
        UIApplication.shared.open(URL(string: "telprompt://0000000000")!, options: [:], completionHandler: nil)
    }
    
    private func openMail() {
        if MFMailComposeViewController.canSendMail() == false {
            return
        }
        let mailComposeViewController = MFMailComposeViewController()
        let toRecipents = ["hogehoge@email.com"]
        var messageBody = "------------------\n"
        messageBody.append("本文を入力して下さい")
        
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(toRecipents)
        mailComposeViewController.setSubject("--件名を入力して下さい--")
        mailComposeViewController.setMessageBody(messageBody, isHTML: false)
        self.present(mailComposeViewController, animated: true, completion: nil)
    }
}
