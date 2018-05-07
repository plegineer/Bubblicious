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
    
    let fmt: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM月dd日(EEE)"
        return formatter
    }()
    
    private var displayingDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwipeGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 画面切り替え後は一律、当日の日付を表示させる
        self.dateLabel.text = fmt.string(from: Date())
        self.displayingDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedBeforeDateButton(_ sender: Any) {
        self.updateDateLabel(isNext: false)
    }
    
    @IBAction func pushedNextDateButton(_ sender: Any) {
        self.updateDateLabel(isNext: true)
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
            self.updateDateLabel(isNext: false)
        case .left:
            self.updateDateLabel(isNext: true)
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
    
    private func updateDateLabel(isNext: Bool) {
        let calendar = Calendar(identifier: .gregorian)
        let value = isNext ? 1 : -1
        if let newDate = calendar.date(byAdding: .day, value: value, to: calendar.startOfDay(for: displayingDate)) {
            self.dateLabel.text = fmt.string(from: newDate)
            self.dateLabel.textColor = Util.calendarColor(newDate)
            self.displayingDate = newDate
        }
    }
    
}
