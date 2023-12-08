//
//  SearchFlightTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
protocol SearchFlightTVCellDelegate {
    func didTapOnFromCity(cell:HolderViewTVCell)
    func didTapOnToCity(cell:HolderViewTVCell)
    func didTapOnSelectDepDateBtn(cell:DualViewTVCell)
    func didTapOnSelectRepDateBtn(cell:DualViewTVCell)
    func didTapOnAddTravelerEconomy(cell:HolderViewTVCell)
    func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell)
    func didTapOnLocationOrCityBtn(cell:HolderViewTVCell)
    func didtapOnCheckInBtn(cell:DualViewTVCell)
    func didtapOnCheckOutBtn(cell:DualViewTVCell)
    func didTapOnAddRooms(cell:HolderViewTVCell)
    func didTapOnSearchHotelsBtn(cell:ButtonTVCell)
    
    func didTapOnSelectAirlines()
   
    
}

class SearchFlightTVCell: TableViewCell,DualViewTVCellDelegate,ButtonTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var searchFlightTV: UITableView!
    
    
    var countryNameArray = [String]()
    var key = String()
    var delegate:SearchFlightTVCellDelegate?
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
        self.key = cellInfo?.key ?? ""
        countrylist.forEach { i in
            countryNameArray.append(i.name ?? "")
        }
        
        
        searchFlightTV.reloadData()
    }
    
    
    func setupTV() {
        holderView.backgroundColor = .WhiteColor
        
        searchFlightTV.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        searchFlightTV.register(UINib(nibName: "DualViewTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        searchFlightTV.register(UINib(nibName: "DualViewTVCell", bundle: nil), forCellReuseIdentifier: "cell33")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell5")
        searchFlightTV.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell4")
        searchFlightTV.separatorStyle = .none
        searchFlightTV.delegate = self
        searchFlightTV.dataSource = self
        searchFlightTV.tableFooterView = UIView()
        searchFlightTV.showsHorizontalScrollIndicator = false
        searchFlightTV.isScrollEnabled = false
        
        searchFlightTV.addCornerRadiusWithShadow(color: .lightGray.withAlphaComponent(0.5), borderColor: .clear, cornerRadius: 10)
    }
    
    func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectDepDateBtn(cell: cell)
    }
    
    func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectRepDateBtn(cell: cell)
    }
    
    
    @objc func didTapOnFromCity(cell:HolderViewTVCell){
        delegate?.didTapOnFromCity(cell: cell)
    }
    @objc func didTapOnToCity(cell:HolderViewTVCell){
        delegate?.didTapOnToCity(cell: cell)
    }
    
    
    
    func btnAction(cell: ButtonTVCell) {
        delegate?.didTapOnSearchFlightsBtn(cell: self)
    }
    
    
    @objc func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){
        delegate?.didTapOnLocationOrCityBtn(cell: cell)
    }
    
    @objc func didtapOnCheckInBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckInBtn(cell: cell)
    }
    
    @objc func didtapOnCheckOutBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckOutBtn(cell: cell)
    }
    
    @objc func didTapOnAddTravelerEconomy(cell:HolderViewTVCell){
        delegate?.didTapOnAddTravelerEconomy(cell: cell)
    }
    
    
    @objc func didTapOnSearchHotelsBtn(cell:ButtonTVCell){
        delegate?.didTapOnSearchHotelsBtn(cell: cell)
    }
    
    @objc func didTapOnAddRooms(cell:HolderViewTVCell){
        delegate?.didTapOnAddRooms(cell: cell)
    }
    
    @objc func didTapOnSelectNationality(cell:HolderViewTVCell){
        //   cell.dropDown.show()
    }
    
    
    
    @objc func didTapOnSelectAirlines(){
        delegate?.didTapOnSelectAirlines()
    }
    
  
    
}


extension SearchFlightTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.key == "hotel" {
            return 5
        }else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        
        if self.key == "hotel" {
            
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/Location")"
                    cell.locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
                    cell.dropdownimg.isHidden = true
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnLocationOrCityBtn(cell:)), for: .touchUpInside)
                    cell.tag = 1
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Check In"
                    cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Check Out"
                    cell.depBtn.addTarget(self, action: #selector(didtapOnCheckInBtn(cell:)), for: .touchUpInside)
                    cell.returnBtn.addTarget(self, action: #selector(didtapOnCheckOutBtn(cell:)), for: .touchUpInside)
                    
                    cell.showReturnView()
                    c = cell
                }
            }else  if indexPath.row == 2 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "+ Add Rooms")"
                    cell.locImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
                    cell.dropdownimg.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnAddRooms(cell:)), for: .touchUpInside)
                    cell.tag = 3
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 3 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Nationality"
                    cell.locImg.image = UIImage(named: "na")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
                    cell.dropdownimg.isHidden = false
                    cell.setupDropDown()
                    cell.dropDown.dataSource = countryNameArray
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnSelectNationality(cell:)), for: .touchUpInside)
                    cell.swipeView.isHidden = true
                    
                    c = cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Search Hotels"
                    cell.titlelbl.textColor = .WhiteColor
                    cell.holderView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    cell.btn.addTarget(self, action: #selector(didTapOnSearchHotelsBtn(cell:)), for: .touchUpInside)
                    c = cell
                }
            }
            
        }else {
            
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    
                    if self.key == "roundtrip" {
                        
                        if defaults.string(forKey: UserDefaultsKeys.fromCity)?.isEmpty == true {
                            cell.titlelbl.text = "From"
                            cell.tolabel.text = "To"
                        }else {
                            cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                            cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                        }
                    }else {
                        
                        
                        if defaults.string(forKey: UserDefaultsKeys.fromCity)?.isEmpty == true {
                            cell.titlelbl.text = "From"
                            cell.tolabel.text = "To"
                        }else {
                            cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? ""
                            cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? ""
                        }
                    }
                    cell.locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
                    cell.toView.isHidden = false
                    cell.swipeView.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnFromCity(cell:)), for: .touchUpInside)
                    cell.toBtn.addTarget(self, action: #selector(didTapOnToCity(cell:)), for: .touchUpInside)
                    
                    cell.tag = 1
                    c = cell
                }
            }else  if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.delegate = self
                    cell.hideRetView()
                    if self.key == "roundtrip" {
                        cell.showReturnView()
                        
                        if defaults.string(forKey: UserDefaultsKeys.calDepDate)?.isEmpty == true {
                            cell.deplbl.text = "Select Date"
                            cell.returnlbl.text = "Select Date"
                        }else {
                            cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                            cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
                        }
                    }else {
                        
                        if defaults.string(forKey: UserDefaultsKeys.calDepDate)?.isEmpty == true {
                            cell.deplbl.text = "Select Date"
                            cell.returnlbl.text = "Select Date"
                        }else {
                            cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                            cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
                        }
                    }
                    
                    c = cell
                }
            }else  if indexPath.row == 2 {

                
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell33") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.showReturnView()
                    cell.key = "airlines"
                    cell.cal1Img.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    cell.cal2img.image = UIImage(named: "airlines")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)

                    if self.key == "roundtrip" {
                        cell.deplbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                    }else {
                        cell.deplbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                    }

                    cell.returnlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL")"

                    cell.depBtn.addTarget(self, action: #selector(didTapOnAddTravelerEconomy), for: .touchUpInside)
                    cell.returnBtn.addTarget(self, action: #selector(didTapOnSelectAirlines), for: .touchUpInside)

                    c = cell
                }
                
                
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.titlelbl.text = "Search Flights"
                    cell.titlelbl.textColor = .AppLabelColor
                    cell.holderView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
                    cell.btnView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 25)
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    c = cell
                }
            }
        }
        return c
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HolderViewTVCell {
            switch cell.tag {
            case 1:
                delegate?.didTapOnFromCity(cell: cell)
                break
                
            case 2:
                delegate?.didTapOnToCity(cell: cell)
                break
                
            case 3:
                delegate?.didTapOnAddTravelerEconomy(cell: cell)
                break
                
            default:
                break
            }
        }
    }
    
    
    
}
