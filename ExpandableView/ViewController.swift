//
//  ViewController.swift
//  ExpandableView
//
//  Created by Agus Cahyono on 13/01/20.
//  Copyright © 2020 Agus Cahyono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        ExpandableSection(section: "ATM BCA", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol>"], expanded: false),
        ExpandableSection(section: "m-BCA (BCA Mobile)", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false),
        ExpandableSection(section: "klikBCA Individual", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false),
        ExpandableSection(section: "Kantor Bank BCA", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "ExpandableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderView")
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let containerView = tableView.headerView(forSection: indexPath.section) as? ExpandableHeaderView else { return 0}
        
        if sections[indexPath.section].expanded {
            DispatchQueue.main.async {
                containerView.openArrow()
            }
            return UITableView.automaticDimension
        } else {
            DispatchQueue.main.async {
                containerView.closeArrow()
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView") as! ExpandableHeaderView
        
        header.common()
        header.delegate = self
        header.section = section
        header.titlePayment.text = sections[section].section
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        
        let rowIndex = indexPath.row
        
        let label = cell.viewWithTag(11) as! UILabel
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.setAttributedHtmlText(sections[indexPath.section].rows[rowIndex])
        
        return cell
    }
    
}

extension ViewController: ExpandableHeaderViewDelegate {
    
    func toogleSection(header: ExpandableHeaderView, section: Int) {
        
        
        for theSection in 0..<sections.count {
            if theSection == section {
                sections[theSection].expanded = !sections[section].expanded
            } else {
                sections[theSection].expanded = false
            }
        }
        
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].rows.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}

