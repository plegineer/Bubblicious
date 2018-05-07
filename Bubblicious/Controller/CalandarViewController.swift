//
//  CalandarViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/07.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class CalandarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    // TODO: 参考
    // https://qiita.com/Koutya/items/f5c7c12ab1458b6addcd
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - FSCalendarDelegateAppearance
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        // 祝日は赤色で表示
        if self.isHoliday(date){
            return UIColor.red
        }
        
        // 土曜日は青色、日曜日は赤色で表示
        let weekday = self.weekDayIndex(date)
        if weekday == 1 {
            return UIColor.red
        } else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        
    }
    
    // MARK: - FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        jumpToDateSchedule(date: date)
    }
    
    // MARK: - Private Method
    
    private func weekDayIndex(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.component(.weekday, from: date)
    }
    
    private func isHoliday(_ date : Date) -> Bool {
        
        let calendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    private func jumpToDateSchedule(date: Date) {
        if let dateScheduleVC = self.navigationController?.viewControllers.first as? DateScheduleViewController {
            dateScheduleVC.displayDate = date
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
