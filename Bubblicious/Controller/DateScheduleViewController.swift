//
//  DateScheduleViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/07.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class DateScheduleViewController: UIViewController {
    
    var displayDate: Date = Date()
    
    @IBOutlet weak var displayCalendarButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    let fmt = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwipeGestureRecognizer()
        self.fmt.dateFormat = "MM月dd日"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dateLabel.text = fmt.string(from: displayDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedCalendarButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Schedule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalandarViewController
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func swiped(sender:UISwipeGestureRecognizer) {
        switch(sender.direction){
        case .right:
            self.updateDate(isNext: false)
        case .left:
            self.updateDate(isNext: true)
        default:
            Log.d("Error: Unset recognizer direction!!")
        }
    }
    
    private func addSwipeGestureRecognizer() {
        let directionList:[UISwipeGestureRecognizerDirection] = [.right, .left]
        for direction in directionList {
            // 左右2方向のスワイプリコグナイザーを登録
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(sender:)))
            swipeRecognizer.direction = direction
            self.view.addGestureRecognizer(swipeRecognizer)
        }
    }
    
    private func updateDate(isNext: Bool) {
        let calendar = Calendar(identifier: .gregorian)
        let value = isNext ? 1 : -1
        if let newDate = calendar.date(byAdding: .day, value: value, to: calendar.startOfDay(for: displayDate)) {
            self.dateLabel.text = fmt.string(from: newDate)
            self.displayDate = newDate
        }
    }
    
}
