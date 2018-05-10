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
    
    private var firstParentCell = ExpandCell()
    private var secondParentCell = ExpandCell()
    
    private enum RowIndex: Int {
        case firstParent
        case secondParent
        case secondParentOpenAll = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.expandableDelegate = self
        tableView.animation = .fade
        
        tableView.register(UINib(nibName: "ExpandCell", bundle: nil), forCellReuseIdentifier: ExpandCell.ID)
        tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
        
        tableView.closeAll()
        tableView.tableFooterView = UIView(frame: .zero)
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

extension ExpandViewController: ExpandableDelegate {
    
    // MARK: - ExpandableDelegate
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
            switch indexPath.row {
            case RowIndex.firstParent.rawValue:
                return setLabelTextToExpandedCell(textFirst: "First Child Cell - 1", textSecond: "Second Child Cell - 1", textThird: "Third Child Cell - 1")
            case RowIndex.secondParent.rawValue:
                return setLabelTextToExpandedCell(textFirst: "First Child Cell - 2", textSecond: "Second Child Cell - 2", textThird: "Third Child Cell - 2")
            default:
                break
            }
        return nil
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
            switch indexPath.row {
            case RowIndex.firstParent.rawValue, RowIndex.secondParent.rawValue:
                return [expandedCellHeight, expandedCellHeight, expandedCellHeight]
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
            case RowIndex.firstParent.rawValue:
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) as! ExpandCell
                cell.expandTitleLabel.text = "Parent - 1"
                self.firstParentCell = cell
                return cell
            case RowIndex.secondParent.rawValue:
                let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandCell.ID) as! ExpandCell
                cell.expandTitleLabel.text = "Parent - 2"
                self.secondParentCell = cell
                return cell
            default:
                break
            }
        return UITableViewCell()
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case RowIndex.firstParent.rawValue,RowIndex.secondParent.rawValue:
                return expandCellHeight
            default:
                break
            }
        return expandedCellHeight
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        
        let arrowImage = UIImage(named: "expand_right_arrow")
        let downArrowImage = UIImage(named: "expand_down_arrow")
        
        switch indexPath.row {
        case RowIndex.firstParent.rawValue:
            if self.firstParentCell.isExpanded() {
                firstParentCell.expandArrowImageView.image = arrowImage
            } else {
                firstParentCell.expandArrowImageView.image = downArrowImage
            }
        case RowIndex.secondParent.rawValue, RowIndex.secondParentOpenAll.rawValue:
            if self.secondParentCell.isExpanded() {
                secondParentCell.expandArrowImageView.image = arrowImage
            } else {
                secondParentCell.expandArrowImageView.image = downArrowImage
            }
        default:
            break
        }
    }
}
