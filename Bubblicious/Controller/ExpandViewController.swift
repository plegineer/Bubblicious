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
    
    private let expandCellHeight: CGFloat = 66
    private let expandedCellHeight: CGFloat = 44
    private let numberOfSections: Int = 1
    private let numberOfRows: Int = 2
    
    private var cell: UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID)!
    }
    
    private enum RowIndex: Int {
        case parentFirst
        case parentSecond
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.expandableDelegate = self
        tableView.animation = .automatic
        
        tableView.register(UINib(nibName: "ExpandCell", bundle: nil), forCellReuseIdentifier: ExpandCell.ID)
        tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
        
        tableView.closeAll()
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension ExpandViewController: ExpandableDelegate {
    
    // MARK: - ExpandableDelegate
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
            switch indexPath.row {
            case RowIndex.parentFirst.rawValue:
                return setLabelTextToExpandedCell(textFirst: "First Child Cell", textSecond: "Second Child Cell", textThird: "Third Child Cell")
            case RowIndex.parentSecond.rawValue:
                return setLabelTextToExpandedCell(textFirst: "First Child Cell - 2", textSecond: "Second Child Cell - 2", textThird: "Third Child Cell - 2")
            default:
                break
            }
        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
            switch indexPath.row {
            case RowIndex.parentFirst.rawValue, RowIndex.parentSecond.rawValue:
                return [expandCellHeight, expandCellHeight, expandCellHeight]
            default:
                break
            }
        return nil
    }
    
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return numberOfSections
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case RowIndex.parentFirst.rawValue:
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) as! ExpandCell
                cell.expandTitleLabel.text = "Parent - 1"
                return cell
            case RowIndex.parentSecond.rawValue:
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
            case RowIndex.parentFirst.rawValue,RowIndex.parentSecond.rawValue:
                return expandCellHeight
            default:
                break
            }
        return expandedCellHeight
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Private Method
    
    private func setLabelTextToExpandedCell(textFirst: String ,textSecond: String, textThird: String) -> [UITableViewCell]? {
        let cellFirst = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
        cellFirst.expandedTitleLabel.text = textFirst
        let cellSecond = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
        cellSecond.expandedTitleLabel.text = textSecond
        let cellThird = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
        cellThird.expandedTitleLabel.text = textThird
        return [cellFirst, cellSecond, cellThird]
    }
}
