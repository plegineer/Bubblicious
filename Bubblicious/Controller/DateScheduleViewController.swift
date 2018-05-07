//
//  DateScheduleViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/07.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class DateScheduleViewController: UIViewController {
    
    @IBOutlet weak var displayCalendarButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var displayDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedCalendarButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalandarViewController
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupComponents() {
        let fmt = DateFormatter()
        fmt.dateFormat = "MM月dd日"
        
        if let date = self.displayDate {
            // カレンダーの日付をタップした場合
            self.dateLabel.text = fmt.string(from: date)
        } else {
            // 初期表示時
            let date = Date()
            self.displayDate = date
            self.dateLabel.text = fmt.string(from: date)
        }
    }
    
}
