//
//  BookHotelTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 22/11/23.
//

import UIKit


protocol BookHotelTVCellDelegate {
    func didTapOnHotelBackBtnAction(cell:BookHotelTVCell)
    func didTapOnSelectCityBtnAction(cell:BookHotelTVCell)
    func didTapOnCheckInBtnAction(cell:BookHotelTVCell)
    func didTapOnCheckOutBtnAction(cell:BookHotelTVCell)
    func didTapOnSelectTravellerAndEconomyBtnAction(cell:BookHotelTVCell)
    func didTaponSelectNationalityBtnAction(cell:BookHotelTVCell)
    func didTapOnHotelSearchBtnAction(cell:BookHotelTVCell)
    
}

class BookHotelTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var hotelorlocNamelbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var travellereconomylbl: UILabel!
    @IBOutlet weak var nationalitylbl: UILabel!
    
    
    var delegate:BookHotelTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        hotelorlocNamelbl.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/location"
        checkinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Check In"
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Check Out"
        travellereconomylbl.text = defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "1 Room, 2 Adults"
        nationalitylbl.text = defaults.string(forKey: UserDefaultsKeys.hnationality) ?? "Nationality"
    }
    
    
    @IBAction func didTapOnHotelBackBtnAction(_ sender: Any) {
        delegate?.didTapOnHotelBackBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectCityBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCheckInBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckInBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCheckOutBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckOutBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectTravellerAndEconomyBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectTravellerAndEconomyBtnAction(cell: self)
    }
    
    @IBAction func didTaponSelectNationalityBtnAction(_ sender: Any) {
        delegate?.didTaponSelectNationalityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnHotelSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnHotelSearchBtnAction(cell: self)
    }
    
    
}
