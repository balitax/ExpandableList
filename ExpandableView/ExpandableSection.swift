//
//  ExpandableSection.swift
//  ExpandableView
//
//  Created by Agus Cahyono on 13/01/20.
//  Copyright © 2020 Agus Cahyono. All rights reserved.
//

import Foundation

struct ExpandableSection {
    var section: String!
    var rows: [String]!
    var expanded: Bool!

    init(section: String!, rows: [String], expanded: Bool!) {
        self.section = section
        self.rows = rows
        self.expanded = expanded
    }
}
