//
//  ContentsTableViewCell.swift
//  ExpandableView
//
//  Created by Agus Cahyono on 14/01/20.
//  Copyright © 2020 Agus Cahyono. All rights reserved.
//

import UIKit

protocol ContentsTableViewDelegate: class {
    func didShowPaymentInfo(_ height: CGFloat)
}

class ContentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var heightOfContainer: NSLayoutConstraint!
    
    var sections = [
        ExpandableSection(section: "ATM BCA", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol>"], expanded: false),
        ExpandableSection(section: "m-BCA (BCA Mobile)", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false),
        ExpandableSection(section: "klikBCA Individual", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false),
        ExpandableSection(section: "Kantor Bank BCA", rows: ["<p>Tata cara pembayaran Anda, Silakan baca panduan dibawah ini dengan baik</p><ol> <li>Masuk ke ATM</li> <li>Masukan kartu ke dalam lubang ATM dan masukan PIN kode Anda</li> <li>Pilih transfer</li> <li>Pilih transfer ke BCA</li> <li>Masukkan jumlah yang akan di transfer, misal Rp. 100.000</li> <li>Klik transfer, tunggu hingga proses transfer selesai, kemudian akan keluar informasi sukses</li> <li>Cetak bukti pembayaran anda</li></ol> "], expanded: false)
    ]
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var delegate: ContentsTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ExpandableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderView")
        tableView.register(UINib(nibName: "ExpandableFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ExpandableFooterView")
        
        tableView.reloadData()
        
        self.heightOfContainer.constant = tableView.contentSize.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension ContentsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            return 1
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView") as! ExpandableHeaderView
        
        header.common()
        header.delegate = self
        header.section = section
        header.titlePayment.text = sections[section].section
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableFooterView") as! ExpandableFooterView
        
        if section == tableView.numberOfSections - 1 {
            footer.underline.isHidden = true
        } else {
            footer.underline.isHidden = false
        }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        
        let rowIndex = indexPath.row
        
        let label = cell.viewWithTag(11) as! UILabel
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.setAttributedHtmlText(sections[indexPath.section].rows[rowIndex])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension ContentsTableViewCell: ExpandableHeaderViewDelegate {
    
    func toogleSection(header: ExpandableHeaderView, section: Int) {
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            // expand
            self.tableViewExpandSection(section)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                // collapse
                self.tableViewCollapseSection(section)
            } else {
                // expand then collapse
                self.tableViewCollapseSection(self.expandedSectionHeaderNumber)
                self.tableViewExpandSection(section)
            }
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.layoutIfNeeded()
            self.heightOfContainer.constant = self.tableView.contentSize.height
            self.layoutIfNeeded()
        }) { _ in
            
        }
        
        self.delegate?.didShowPaymentInfo(tableView.contentSize.height)
    }
    
    func setImageArrowState(_ section: Int, closed: Bool) {
        let header = tableView.headerView(forSection: section) as! ExpandableHeaderView
        if closed {
            header.closeArrow()
        } else {
            header.openArrow()
        }
    }
    
    func tableViewCollapseSection(_ section: Int) {
        UIView.animate(withDuration: 0.4, animations: {
            self.expandedSectionHeaderNumber = -1
            self.setImageArrowState(section, closed: true)
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
            self.tableView!.endUpdates()
        }) { _ in
            
        }
    }
    
    func tableViewExpandSection(_ section: Int) {
        UIView.animate(withDuration: 0.4, animations: {
            self.expandedSectionHeaderNumber = section
            self.setImageArrowState(section, closed: false)
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
            self.tableView!.endUpdates()
        }) { _ in
            
        }
    }
    
}

