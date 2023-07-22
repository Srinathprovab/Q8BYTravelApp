//
//  CommonTVCell.swift
//  BabSafar
//
//  Created by FCI on 20/10/22.
//

import UIKit

class CommonTVCell: TableViewCell {
    
    @IBOutlet weak var infoTV: UITableView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var index = Int()
    var selectClassArray = ["Economy","Premium Economy","First","Business"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        //selectClassArray = cellInfo?.data as! [String]
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                index = defaults.integer(forKey: UserDefaultsKeys.select_classIndex)
            }else if journeyType == "circle"{
                index = defaults.integer(forKey: UserDefaultsKeys.rselect_classIndex)
            }else {
                index = defaults.integer(forKey: UserDefaultsKeys.mselect_classIndex)
            }
        }
        
       
        tvHeight.constant = CGFloat((selectClassArray.count * 50))
        infoTV.reloadData()
    }
    
    func setupTV() {
        
        infoTV.register(UINib(nibName: "RadioButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        infoTV.delegate = self
        infoTV.dataSource = self
        infoTV.tableFooterView = UIView()
        infoTV.isScrollEnabled = false
        infoTV.showsVerticalScrollIndicator = false
        infoTV.showsHorizontalScrollIndicator = false
        infoTV.separatorStyle = .none
    }
    
    
}



extension CommonTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectClassArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RadioButtonTVCell {
            cell.selectionStyle = .none
            if indexPath.row == index {
                infoTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                infoTV.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                cell.show()
            }
            
            cell.titlelbl.text = selectClassArray[indexPath.row]
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.show()
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
                    defaults.set(indexPath.row, forKey: UserDefaultsKeys.select_classIndex)
                }else if journeyType == "circle"{
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rselectClass)
                    defaults.set(indexPath.row, forKey: UserDefaultsKeys.rselect_classIndex)
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mselectClass)
                    defaults.set(indexPath.row, forKey: UserDefaultsKeys.mselect_classIndex)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.hide()
        }
    }
    
}
