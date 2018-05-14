//
//  ExpandableTableViewController.swift
//  Bubblicious
//
//  Created by Yoshiki Agatsuma on 2018/05/14.
//  Copyright © 2018年 Plegineer Inc. All rights reserved.
//

import UIKit

class ExpandableTableViewController: UITableViewController {
    
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
    
    var sections: [Section] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            Section(name: "Mac", items: ["MacBook", "MacBook Air"]),
            Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"]),
            Section(name: "iPhone", items: ["iPhone 7", "iPhone 6"])
        ]
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        print(self.tableView.numberOfSections)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ExpandableTableViewHeaderView ?? ExpandableTableViewHeaderView(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ExpandableTableViewHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ExpandableTableViewController: ExpandableTableViewHeaderViewDelegate {
    func toggleSection(_ header: ExpandableTableViewHeaderView, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
