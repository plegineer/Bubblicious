//
//  ScrollDirection.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/11.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

// 縦方向のスクロール状態
enum ScrollDirectionY { case none, toTop, toBottom }

struct ScrollDirection {
    /// 直前のcontentOffset
    let old: CGPoint
    /// 現在のcontentOffset
    let new: CGPoint
    
    /// 縦スクロール方向
    var directionY: ScrollDirectionY {
        if old.y > new.y {
            return .toTop
        } else if old.y < new.y {
            return .toBottom
        } else {
            return .none
        }
    }
    
    init(old: CGPoint, new: CGPoint) {
        self.old = old
        self.new = new
    }
}
