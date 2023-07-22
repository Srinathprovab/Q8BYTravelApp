//
//  CheckBoxTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
protocol CheckBoxTVCellDelegate {
    func didTapOnCheckBoxDropDownBtn(cell:CheckBoxTVCell)
    func didTapOnShowMoreBtn(cell:CheckBoxTVCell)
    
    func didTapOnCheckBox(cell:checkOptionsTVCell)
    func didTapOnDeselectCheckBox(cell:checkOptionsTVCell)
    
}

class CheckBoxTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkOptionsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    
    var timeArray = ["time1","time2","time3","time4"]
    var key = String()
    var b = true
    var nameArray = [String]()
    var tvheight = CGFloat()
    var showbool = true
    var delegate:CheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    
    override func prepareForReuse() {
        tvHeight.constant = 0
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        nameArray = cellInfo?.data as? [String] ?? []
        self.key = cellInfo?.key ?? ""
        
        if self.key == "hotel" {
            downImg.isHidden = true
            expand()
        }
        
        checkOptionsTV.reloadData()
        
    }
    
    func setupUI() {
        // tvHeight.constant = 0
        expand()
        downImg.image = UIImage(named: "downarrow")
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OswaldSemiBold(size: 16)
        titlelbl.numberOfLines = 0
        
        downBtn.setTitle("", for: .normal)
        downBtn.addTarget(self, action: #selector(didTapOnCheckBoxDropDownBtn(_:)), for: .touchUpInside)
        downBtn.isHidden = true
        
    }
    
    func setupTV() {
        checkOptionsTV.register(UINib(nibName: "checkOptionsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        checkOptionsTV.delegate = self
        checkOptionsTV.dataSource = self
        checkOptionsTV.separatorStyle = .none
        checkOptionsTV.tableFooterView = UIView()
        checkOptionsTV.isScrollEnabled = false
        checkOptionsTV.allowsMultipleSelection = true
    }
    
    
    @objc func didTapOnCheckBoxDropDownBtn(_ sender: UIButton){
        delegate?.didTapOnCheckBoxDropDownBtn(cell: self)
    }
    
    
    func hide() {
        tvHeight.constant = 0
    }
    func expand() {
        tvHeight.constant = CGFloat(nameArray.count * 50)
    }
    
}


extension CheckBoxTVCell:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? checkOptionsTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = nameArray[indexPath.row]
            cell.filtertitle = self.titlelbl.text ?? ""
            if self.key == "time" {
                cell.sunImg.isHidden = false
                cell.sunImg.image = UIImage(named: timeArray[indexPath.row])
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnCheckBox(cell: cell)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnDeselectCheckBox(cell: cell)
        }
    }
    
    
    
    
}
