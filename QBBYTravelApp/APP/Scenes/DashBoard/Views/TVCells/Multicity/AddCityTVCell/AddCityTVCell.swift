//
//  AddCityTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit

protocol AddCityTVCellDelegate {
    
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
    func didTapOnAddCityBtn(cell:AddCityTVCell)
    func didTapOnAddTravellerEconomy(cell:AddCityTVCell)
    func didTapOnMultiCityTripSearchFlight(cell:AddCityTVCell)
    
    
}

class AddCityTVCell: TableViewCell, MulticityFromToTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addCityTV: UITableView!
    @IBOutlet weak var addCityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addCityBtn: UIButton!
    
    @IBOutlet weak var traView: UIView!
    @IBOutlet weak var tralbl: UILabel!
    @IBOutlet weak var searchFlightView: UIView!
    
    
    
    
    
    var count = 0
    var delegate:AddCityTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        addCityTVHeight.constant = 170
        addCityBtn.setTitle("+ Add City", for: .normal)
        addCityBtn.setTitleColor(.AppBackgroundColor, for: .normal)
        
        traView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
       
      
        
        setupTV()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    @objc func reload(notification: NSNotification){
        updateheight()
    }
    
    
    func setupTV() {
        addCityTV.register(UINib(nibName: "MulticityFromToTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addCityTV.delegate = self
        addCityTV.dataSource = self
        addCityTV.tableFooterView = UIView()
        addCityTV.separatorStyle = .none
        addCityTV.backgroundColor = .AppHolderViewColor
    }
    
    
    func didTapOnFromBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.fromBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromBtn(cell: cell)
    }
    
    func didTapOnToBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.toBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToBtn(cell: cell)
    }
    
    func didTapOndateBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.dateBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOndateBtn(cell: cell)
    }
    
    
    
    
    func updateheight() {
        addCityTVHeight.constant = CGFloat(85 * (fromCityCodeArray.count))
        addCityTV.reloadData()
    }
    
    @IBAction func didTapOnAddCityBtn(_ sender: Any) {
        count += 1
        print("count \(count)")
        print("fromCityNameArray count \(fromCityCodeArray.count)")
        if fromCityCodeArray.count >= 5 {
            addCityBtn.isHidden = true
            
        }else {
            
            fromCityCodeArray.append("Select City")
            toCitycodeArray.append("Select City")
            fromlocidArray.append("")
            tolocidArray.append("")
            depatureDatesArray.append("Select Date")
            
            fromCityNameArray.append("")
            toCityNameArray.append("")
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
            
            
            if fromCityCodeArray.count == 5 {
                addCityBtn.isHidden = true
            }
            
        }
        
        delegate?.didTapOnAddCityBtn(cell: self)
    }
    
    
    
    
    func didTapOnCloseBtn(cell: MulticityFromToTVCell) {
        
        fromCityCodeArray.remove(at: cell.closeBtn.tag)
        toCitycodeArray.remove(at: cell.closeBtn.tag)
        depatureDatesArray.remove(at: cell.closeBtn.tag)
        fromlocidArray.remove(at: cell.closeBtn.tag)
        tolocidArray.remove(at: cell.closeBtn.tag)
        
        fromCityNameArray.remove(at: cell.closeBtn.tag)
        toCityNameArray.remove(at: cell.closeBtn.tag)
        
      
        //---------------
        
        addCityTV.deleteRows(at: [IndexPath(item: cell.closeBtn.tag, section: 0)], with: .automatic)
        DispatchQueue.main.async {[self] in
            if fromCityCodeArray.count < 5 {
                addCityBtn.isHidden = false
            }
        }
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    
    @IBAction func didTapOnAddTravellerBtnAction(_ sender: Any) {
        delegate?.didTapOnAddTravellerEconomy(cell: self)
    }
    
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnMultiCityTripSearchFlight(cell: self)
    }
    
    
}


extension AddCityTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityCodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MulticityFromToTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            if indexPath.row == 0 || indexPath.row == 1{
                cell.closeView.isHidden = true
            }else {
                cell.closeView.isHidden = false
            }
            
           
            
            
            cell.fromlbl.text = fromCityCodeArray[indexPath.row]
            cell.tolbl.text = toCitycodeArray[indexPath.row]
            cell.datelbl.text = depatureDatesArray[indexPath.row]
            
            
            cell.fromBtn.tag = indexPath.row
            cell.toBtn.tag = indexPath.row
            cell.dateBtn.tag = indexPath.row
            cell.closeBtn.tag = indexPath.row
            
            c = cell
        }
        return c
    }
    
    
}
