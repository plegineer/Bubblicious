//
//  OtherViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/02.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

class OtherController: UITableViewController, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var loadingView: CustomBackGroundView!
    private var activityIndicatorView: UIActivityIndicatorView!

    private var locationManager: CLLocationManager!
    private var latitudeString: String = ""
    private var longitudeString: String = ""
    
    private enum RowIndex: Int {
        case uploadImage
        case openApplicationTellNumberUrl
        case requestLocation
        case openMap
        case openMail
        case showCustomView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.setupLoadingView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            case RowIndex.uploadImage.rawValue:
                jumpToUploadImage()
            case RowIndex.openApplicationTellNumberUrl.rawValue:
                openTelephone()
            case RowIndex.requestLocation.rawValue:
                requestLocation()
                self.startLoading()
            case RowIndex.openMap.rawValue:
                openMap()
            case RowIndex.openMail.rawValue:
                openMail()
            case RowIndex.showCustomView.rawValue:
                jumpToShowCustomView()
            default:
                return
        }

        if let indexPathForSelectedRow = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    @objc func logout() {
        Util.clearAllSavedData()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateViewController(withIdentifier: "login") as! UINavigationController
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
            showAlert(Const.Alert.locationManagerDeniedTitle, message: Const.Alert.locationManagerDeniedMessage)
            break
        case .restricted:
            showAlert(Const.Alert.locationManagerRestrictedTitle, message: Const.Alert.locationManagerDidFailMessage)
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
            showAlert(Const.Alert.locationManagerDidUpdateTitle, message: locationInfomationString)
            
            self.stopLoading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(Const.Alert.errorTitle, message: Const.Alert.locationManagerDidFailMessage)
        
        self.stopLoading()
    }
    
    // MARK: - UploadImageViewControllerDelegate
    
    func UploadImageViewController(didFinished view: UploadImageViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private Method
    
    private func setupLoadingView() {
        var height = self.view.frame.height
        if let tabBar = self.tabBarController?.tabBar {
            height += tabBar.frame.size.height
        }
        self.loadingView.frame = CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width, height: height))
        self.loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let indicator = UIActivityIndicatorView()
        indicator.frame.size = CGSize(width: 20, height: 20)
        indicator.center = self.loadingView.center
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        self.loadingView.addSubview(indicator)
        self.activityIndicatorView = indicator
        
        let label = UILabel()
        label.text = "位置情報取得中..."
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.frame.size = CGSize(width: 150, height: 30)
        label.center.x = indicator.center.x
        label.center.y = indicator.frame.maxY + label.frame.size.height/2
        self.loadingView.addSubview(label)
        
        self.tabBarController?.view.addSubview(self.loadingView)
    }
    
    private func jumpToUploadImage() {
        let storyBoard = UIStoryboard(name: "Other", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "uploadImage") as! UploadImageViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openTelephone() {
        UIApplication.shared.open(URL(string: Const.telephoneNumber)!, options: [:], completionHandler: nil)
    }
    
    private func requestLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    private func openMail() {
        if MFMailComposeViewController.canSendMail() {
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
    
    private func openMap() {
        if !latitudeString.isEmpty && !longitudeString.isEmpty {
            let destinationAddress = latitudeString + "," + longitudeString
            let urlString = Const.Map.BaseUrlFirst + destinationAddress + Const.Map.BaseUrlSecond
            
            if let url = URL(string: urlString) {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            showAlert(Const.Alert.errorTitle, message: Const.Alert.openMapLocationErrorMessage)
        }
    }
    
    private func jumpToShowCustomView() {
        let storyBoard = UIStoryboard(name: "Other", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "showCustomView") as! ShowCustomViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func startLoading() {
        self.activityIndicatorView.startAnimating()
        self.loadingView.isHidden = false
    }
    
    private func stopLoading() {
        self.activityIndicatorView.stopAnimating()
        self.loadingView.isHidden = true
    }
}
