//
//  CalandarViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/07.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import FSCalendar

class CalandarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    // TODO: 参考
    // https://qiita.com/Koutya/items/f5c7c12ab1458b6addcd
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.title = "カレンダー"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - FSCalendarDelegateAppearance
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return Util.calendarColor(date)
    }
}
