//
//  FlightSearchTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 02/06/23.
//

import UIKit


protocol FlightSearchTVCellDelegate {
    func didTapOnFromCity(cell:FlightSearchTVCell)
    func didTapOnToCity(cell:FlightSearchTVCell)
    func didTapOnSelectDepDateBtn(cell:FlightSearchTVCell)
    func didTapOnSelectRepDateBtn(cell:FlightSearchTVCell)
    func didTapOnAddTravelerEconomy(cell:FlightSearchTVCell)
    func didTapOnAirlineBtnAction(cell:FlightSearchTVCell)
    func didTapOnSearchFlightsBtn(cell:FlightSearchTVCell)
    
    func donedatePicker(cell:FlightSearchTVCell)
    func cancelDatePicker(cell:FlightSearchTVCell)
}

class FlightSearchTVCell: TableViewCell {
    
    @IBOutlet weak var fromview: UIView!
    @IBOutlet weak var fromcitylbl: UILabel!
    @IBOutlet weak var fromcityBtn: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var tocityBtn: UIButton!
    @IBOutlet weak var dipView: UIView!
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retView: UIView!
    @IBOutlet weak var retlbl: UILabel!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var traView: UIView!
    @IBOutlet weak var tralbl: UILabel!
    @IBOutlet weak var traBtn: UIButton!
    @IBOutlet weak var searchflightView: UIView!
    @IBOutlet weak var searchFlightBtn: UIButton!
    @IBOutlet weak var swapBtn: UIButton!
    @IBOutlet weak var swapView: UIView!
    @IBOutlet weak var airlinesView: UIView!
    @IBOutlet weak var airlinesimg: UIImageView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineBtn: UIButton!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var retTF: UITextField!
    
    
    let depDatePicker = UIDatePicker()
    let retdepDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    var delegate:FlightSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        fromcitylbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Origin"
        tocitylbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Destination"
        deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
        retlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Add Return"
        airlinelbl.text = defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL"
        
        
        if journeyType == "oneway" {
            retView.alpha = 0.3
            retView.isUserInteractionEnabled = false
            tralbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Traveller"
            
            self.depTF.isHidden = false
            showdepDatePicker()
            
        }else {
            retView.alpha = 1
            retView.isUserInteractionEnabled = true
            tralbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Traveller"
            
            self.depTF.isHidden = false
            self.retTF.isHidden = false
            showreturndepDatePicker()
            showretDatePicker()
            
        }
    }
    
    
    func setupUI() {
        
        swapView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 8)
        fromview.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        toView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        dipView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        retView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        traView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        airlinesView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: HexColor("#A6C2FA"), cornerRadius: 12)
        airlinesimg.image = UIImage(named: "airlines")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        tralbl.numberOfLines = 2
        
        fromcityBtn.addTarget(self, action: #selector(didTapOnFromCityBtnAction(_:)), for: .touchUpInside)
        tocityBtn.addTarget(self, action: #selector(didTapOnToCityBtnAction(_:)), for: .touchUpInside)
        depBtn.addTarget(self, action: #selector(didTapOnDepratureDateBtnAction(_:)), for: .touchUpInside)
        retBtn.addTarget(self, action: #selector(didTapOnReturnDateBtnAction(_:)), for: .touchUpInside)
        traBtn.addTarget(self, action: #selector(didTapOnTravellerBtnAction(_:)), for: .touchUpInside)
        searchFlightBtn.addTarget(self, action: #selector(didTapOnSearchFlightBtnAction(_:)), for: .touchUpInside)
        swapBtn.addTarget(self, action: #selector(didTapOnSwapCityBtnAction(_:)), for: .touchUpInside)
        airlineBtn.addTarget(self, action: #selector(didTapOnAirlineBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnFromCityBtnAction(_ sender:UIButton) {
        delegate?.didTapOnFromCity(cell: self)
    }
    
    @objc func didTapOnToCityBtnAction(_ sender:UIButton) {
        delegate?.didTapOnToCity(cell: self)
    }
    
    @objc func didTapOnDepratureDateBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSelectDepDateBtn(cell: self)
    }
    
    @objc func didTapOnReturnDateBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSelectRepDateBtn(cell: self)
    }
    
    @objc func didTapOnTravellerBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAddTravelerEconomy(cell: self)
    }
    
    
    @objc func didTapOnAirlineBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAirlineBtnAction(cell: self)
    }
    
    @objc func didTapOnSearchFlightBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSearchFlightsBtn(cell: self)
    }
    
    @objc func didTapOnSwapCityBtnAction(_ sender:UIButton) {
        
        let x = fromcitylbl.text
        let y = tocitylbl.text
        fromcitylbl.text = y
        tocitylbl.text = x
        
        
        let a = defaults.string(forKey: UserDefaultsKeys.fromCity)
        let b = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        let c = defaults.string(forKey: UserDefaultsKeys.fromcityname)
        let d = defaults.string(forKey: UserDefaultsKeys.toCity)
        let e = defaults.string(forKey: UserDefaultsKeys.tolocid)
        let f = defaults.string(forKey: UserDefaultsKeys.tocityname)
        
        defaults.set(d , forKey: UserDefaultsKeys.fromCity)
        defaults.set(e , forKey: UserDefaultsKeys.fromlocid)
        defaults.set(f, forKey: UserDefaultsKeys.fromcityname)
        defaults.set(a , forKey: UserDefaultsKeys.toCity)
        defaults.set(b, forKey: UserDefaultsKeys.tolocid)
        defaults.set(c , forKey: UserDefaultsKeys.tocityname)
        
    }
    
}



extension FlightSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retlbl.text == "Select Date" {
                retdepDatePicker.date = calDepDate
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showreturndepDatePicker
    func showreturndepDatePicker(){
        //Formate Date
        retdepDatePicker.datePickerMode = .date
        retdepDatePicker.minimumDate = Date()
        retdepDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if key == "hotel" {
            
            if let checkinDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "")  {
                retdepDatePicker.date = checkinDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.checkin) == nil {
                    retdepDatePicker.date = checkinDate
                }
            }
            
        }else {
            if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
                retdepDatePicker.date = rcalDepDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || self.retlbl.text == "Select Date" {
                    retdepDatePicker.date = rcalDepDate
                }
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = retdepDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depTF.isFirstResponder ? depDatePicker.date : retdepDatePicker.date
        retDatePicker.minimumDate = selectedDate
        
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if key == "hotel" {
            if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                retDatePicker.date = checkoutDate
            }
        }else {
            
            
            if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
                
                if self.retlbl.text == "Select Date" {
                    retDatePicker.date = calDepDate
                    
                }else {
                    if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "") {
                        retDatePicker.date = rcalRetDate
                    }
                }
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.retTF.inputAccessoryView = toolbar
        self.retTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}
