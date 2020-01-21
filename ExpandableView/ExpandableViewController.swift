//
//  ExpandableViewController.swift
//  ExpandableView
//
//  Created by Agus Cahyono on 14/01/20.
//  Copyright © 2020 Agus Cahyono. All rights reserved.
//

import UIKit

class ExpandableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: -60, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
}


extension ExpandableViewController: UITableViewDelegate, UITableViewDataSource, ContentsTableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelInfo")!
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsTableViewCell
            cell.setupUI()
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func didShowPaymentInfo(_ height: CGFloat) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
}
