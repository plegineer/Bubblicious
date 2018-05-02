//
//  SubFunctionListViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

protocol SubFunctionListViewControllerDelegate: class {
    func subFunctionListViewController(didFinished view: SubFunctionListViewController)
}

class SubFunctionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    weak var delegate: SubFunctionListViewControllerDelegate?
    private var locationManager: CLLocationManager!
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
        } else if indexPath.row == 2 {
            requestLocation()
            tableView.isUserInteractionEnabled = false
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
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            tableView.isUserInteractionEnabled = true
            break
        case .denied:
            self.showAlert("位置情報サービスの設定が「無効」になっています", message: "設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい")
            tableView.isUserInteractionEnabled = true
            break
        case .restricted:
            self.showAlert("位置情報サービスの設定が制限されているため利用出来ません", message: "設定 > 一般 > 機能制限 で、制限を解除して下さい")
            tableView.isUserInteractionEnabled = true
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let managerLocation = manager.location {
            let locationInfomationString = "緯度:\(managerLocation.coordinate.latitude)\n経度:\(managerLocation.coordinate.longitude)" as String
            self.showAlert("現在位置", message: locationInfomationString)
            tableView.isUserInteractionEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showAlert("エラー", message: "位置情報の取得に失敗しました")
    }

    @objc func pushedCloseButton() {
        self.delegate?.subFunctionListViewController(didFinished: self)
    }
    
    // MARK: - Private Method
    
    private func callTell() {
        UIApplication.shared.open(URL(string: "telprompt://0000000000")!, options: [:], completionHandler: nil)
    }
    
    private func requestLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
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
