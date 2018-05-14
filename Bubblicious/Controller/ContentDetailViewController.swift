//
//  ContentDetailViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/10.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController {

    var selectedCellIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = "詳細画面" + "(" + "コンテンツ" + String(selectedCellIndex+1) + ")"
        self.title = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
