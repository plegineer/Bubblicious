//
//  ExpandableTableViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/14.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ExpandableTableViewController: UITableViewController {
    
    // 参考URL: https://github.com/jeantimex/ios-swift-collapsible-table-section
    
    struct Section {
        var name: String
        var items: [String]
        var collapsed: Bool
        
        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    private var sections: [Section] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.setupSections()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ExpandableTableHeaderView ?? ExpandableTableHeaderView(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].name
        header.setCollapsed(sections[section].collapsed)
        header.section = section
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ExpandableTableHeaderView.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.showAlert("Tapped!", message: self.sections[indexPath.section].items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    private func setupSections() {
        sections = [
            Section(name: "Parent1", items: ["Child1-1"]),
            Section(name: "Parent2", items: ["Child2-1", "Child2-2"]),
            Section(name: "Parent3", items: ["Child3-1", "Child3-2", "Child3-3"]),
            Section(name: "Parent4", items: ["Child4-1", "Child4-2", "Child4-3", "Child4-4"]),
            Section(name: "Parent5", items: ["Child5-1", "Child5-2"]),
            Section(name: "Parent6", items: ["Child6-1", "Child6-2"]),
            Section(name: "Parent7", items: ["Child7-1", "Child7-2", "Child7-3", "Child7-4", "Child7-5", "Child7-6", "Child7-7"]),
            Section(name: "Parent8", items: ["Child8-1", "Child8-2"]),
            Section(name: "Parent9", items: ["Child9-1", "Child9-2"]),
            Section(name: "Parent10", items: ["Child10-1", "Child10-2"]),
        ]
    }
}

extension ExpandableTableViewController: ExpandableTableHeaderViewDelegate {
    func toggleSection(_ header: ExpandableTableHeaderView, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
