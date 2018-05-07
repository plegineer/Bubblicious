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

class SubFunctionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate, UploadImageViewControllerDelegate {
    
    weak var delegate: SubFunctionListViewControllerDelegate?
    
    private var loadingLocationBackGroundView: CustomBackGroundView!
    private var locationManager: CLLocationManager!
    private var activityIndicatorView: UIActivityIndicatorView!
    private let subFunctionListText = ["画像をアップロードする", "電話をかける", "GPSで現在位置を取得", "現在位置をMAPに表示", "メールを送る"]
    
    private var latitudeString: String = ""
    private var longitudeString: String = ""
    
    private enum RowIndex: Int {
        case uploadImage
        case openApplicationTellNumberUrl
        case requestLocation
        case openMap
        case openMail
        
        case _count
        static let count = Int(_count.rawValue)
    }

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
        
        switch indexPath.row {
        case RowIndex.uploadImage.rawValue:
            tappedCellToUploadImage()
        case RowIndex.openApplicationTellNumberUrl.rawValue:
            openApplicationTellNumberUrl()
        case RowIndex.requestLocation.rawValue:
            requestLocation()
            addLoadingLocationBackGroundView()
        case RowIndex.openMap.rawValue:
            openMap()
        case RowIndex.openMail.rawValue:
            openMail()
        default:
            return
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
            break
        case .denied:
            showAlert("位置情報サービスの設定が「無効」になっています", message: "設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい")
            break
        case .restricted:
            showAlert("位置情報サービスの設定が制限されているため利用出来ません", message: "設定 > 一般 > 機能制限 で、制限を解除して下さい")
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let managerLocation = manager.location {
            
            latitudeString = "\(managerLocation.coordinate.latitude)"
            longitudeString = "\(managerLocation.coordinate.longitude)"
            
            let locationInfomationString = "緯度:\(managerLocation.coordinate.latitude)\n経度:\(managerLocation.coordinate.longitude)"
            showAlert("現在位置", message: locationInfomationString)
            activityIndicatorView.stopAnimating()
            loadingLocationBackGroundView.removeFromSuperview()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert("エラー", message: "位置情報の取得に失敗しました")
        activityIndicatorView.stopAnimating()
        loadingLocationBackGroundView.removeFromSuperview()
    }
    
    // MARK: - UploadImageViewControllerDelegate
    
    func UploadImageViewController(didFinished view: UploadImageViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func pushedCloseButton() {
        self.delegate?.subFunctionListViewController(didFinished: self)
    }
    
    // MARK: - Private Method
    
    private func tappedCellToUploadImage() {
        let storyBoard = UIStoryboard(name: "Other", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "uploadImage") as! UploadImageViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openApplicationTellNumberUrl() {
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
    
    private func addLoadingLocationBackGroundView() {
        let loadingLocationBackGroundView = CustomBackGroundView(frame: self.view.bounds)
        loadingLocationBackGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame.size = CGSize(width: 50, height: 50)
        activityIndicatorView.center = self.view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        let loadingLocationTextLabel = UILabel()
        loadingLocationTextLabel.text = "位置情報取得中"
        loadingLocationTextLabel.textAlignment = .center
        loadingLocationTextLabel.frame.size = CGSize(width: 150, height: 30)
        loadingLocationTextLabel.center.x = self.view.center.x
        loadingLocationTextLabel.center.y = self.view.center.y + 30
        loadingLocationTextLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        
        self.navigationController?.view.addSubview(loadingLocationBackGroundView)
        loadingLocationBackGroundView.addSubview(loadingLocationTextLabel)
        loadingLocationBackGroundView.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        
        self.activityIndicatorView = activityIndicatorView
        self.loadingLocationBackGroundView = loadingLocationBackGroundView
    }
    
    private func openMap() {
        if !(latitudeString.isEmpty || longitudeString.isEmpty) {
            let destinationAddress = latitudeString + "," + longitudeString
            let urlString = "http://maps.apple.com/?daddr=\(destinationAddress)&dirflg=d"
            
            if let url = URL(string: urlString) {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            showAlert("位置情報取得エラー", message: "先に位置情報を取得して下さい")
        }
    }
}
