//
//  ExpandableHeaderView.swift
//  ExpandableView
//
//  Created by Agus Cahyono on 13/01/20.
//  Copyright © 2020 Agus Cahyono. All rights reserved.
//

import UIKit


protocol ExpandableHeaderViewDelegate {
    func toogleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    @IBOutlet weak var titlePayment: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    func common() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toogleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate){
        self.titlePayment?.text = title + "\(section)"
        self.section = section
        self.delegate = delegate
    }
    
    func openArrow() {
        self.arrowIcon.image = #imageLiteral(resourceName: "upArrow")
    }
    
    func closeArrow() {
        self.arrowIcon.image = #imageLiteral(resourceName: "downArrow")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }

}
