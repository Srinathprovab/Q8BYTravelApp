//
//  SearchHolidaysTVcell.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import UIKit

protocol SearchHolidaysTVcellDelegate {
    func didTapOnWhereToTravelSearchBtnAction(cell:SearchHolidaysTVcell)
    func didTapOnSearchHolidayBtnAction(cell:SearchHolidaysTVcell)
    
}

class SearchHolidaysTVcell: TableViewCell {
    
    
    @IBOutlet weak var hview: UIView!
    @IBOutlet weak var whereToTravelBtn: UIButton!
    @IBOutlet weak var searchHolidayBtnView: UIView!
    @IBOutlet weak var searchHolidayBtn: UIButton!
    @IBOutlet weak var whereToTravelView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var delegate:SearchHolidaysTVcellDelegate?
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
        titlelbl.text = defaults.string(forKey: UserDefaultsKeys.holidaylocationcity) ?? "where are you traveling"
    }
    
    func setupUI() {
        whereToTravelBtn.setTitle("", for: .normal)
        searchHolidayBtn.setTitle("", for: .normal)
        searchHolidayBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 20)
        hview.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        whereToTravelView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        whereToTravelBtn.addTarget(self, action: #selector(didTapOnWhereToTravelSearchBtnAction(_:)), for: .touchUpInside)
        searchHolidayBtn.addTarget(self, action: #selector(didTapOnSearchHolidayBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapOnWhereToTravelSearchBtnAction(_ sender:UIButton) {
        delegate?.didTapOnWhereToTravelSearchBtnAction(cell: self)
    }
    
    
    @objc func didTapOnSearchHolidayBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSearchHolidayBtnAction(cell: self)
    }
    
}
