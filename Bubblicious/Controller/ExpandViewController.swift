//
//  ExpandViewController.swift
//  Bubblicious
//
//  Created by 島田一輝 on 2018/05/08.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit
import ExpandableCell

class ExpandViewController: UIViewController {
    
    @IBOutlet weak var tableView: ExpandableTableView!    
    var cell: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.expandableDelegate = self
        tableView.animation = .automatic
        
        tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: NormalCell.ID)
        tableView.register(UINib(nibName: "ExpandCell", bundle: nil), forCellReuseIdentifier: ExpandCell.ID)
        tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
        
        tableView.closeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ExpandViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cellFirst = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellFirst.titleLabel.text = "First Child Cell"
                let cellSecond = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellSecond.titleLabel.text = "Second Child Cell"
                let cellThird = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellThird.titleLabel.text = "Third Child Cell"
                return [cellFirst, cellSecond, cellThird]
                
            case 2:
                return [cell, cell]
            case 3:
                return [cell]
            default:
                break
            }
        default:
            break
        }
        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return [44, 44, 44]
                
            case 2:
                return [33, 33, 33]
                
            case 3:
                return [22]
                
            default:
                break
            }
        default:
            break
        }
        return nil
    }
    
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 2
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        //        print("didSelectRow:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        //        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? ExpandedCell {
            print("\(cell.titleLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 2, 3:
                guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) else { return UITableViewCell() }
                return cell
                
            case 1, 4:
                guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID)  else { return UITableViewCell() }
                return cell
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0, 1, 2, 3, 4:
                guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: NormalCell.ID) else { return UITableViewCell() }
                return cell
                
            default:
                break
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 2, 3:
                return 66
                
            case 1, 4:
                return 55
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0, 1, 2, 3, 4:
                return 55
                
            default:
                break
            }
        default:
            break
        }
        
        return 44
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
