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
        
        tableView.register(UINib(nibName: "ExpandCell", bundle: nil), forCellReuseIdentifier: ExpandCell.ID)
        tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
        
        tableView.closeAll()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
}

extension ExpandViewController: ExpandableDelegate {
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
            switch indexPath.row {
            case 0:
                let cellFirst = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellFirst.expandedTitleLabel.text = "First Child Cell"
                let cellSecond = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellSecond.expandedTitleLabel.text = "Second Child Cell"
                let cellThird = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellThird.expandedTitleLabel.text = "Third Child Cell"
                return [cellFirst, cellSecond, cellThird]
            case 1:
                let cellFirst = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellFirst.expandedTitleLabel.text = "First Child Cell - 2"
                let cellSecond = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellSecond.expandedTitleLabel.text = "Second Child Cell - 2"
                let cellThird = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                cellThird.expandedTitleLabel.text = "Third Child Cell - 2"
                return [cellFirst, cellSecond, cellThird]
            default:
                break
            }
        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
            switch indexPath.row {
            case 0,1:
                return [44, 44, 44]
            default:
                break
            }
        return nil
    }
    
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) as! ExpandCell
                cell.expandTitleLabel.text = "Parent - 1"
                return cell
            case 1:
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) as! ExpandCell
                cell.expandTitleLabel.text = "Parent - 2"
                return cell
            default:
                break
            }
        return UITableViewCell()
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0,1:
                return 66
            default:
                break
            }
        return 44
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

