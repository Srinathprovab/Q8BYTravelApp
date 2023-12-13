//
//  ItineraryTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit

class ItineraryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var airlinecodelbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var fromCityDatelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var toCityDatelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var layoverView: UIView!
    @IBOutlet weak var layoverCitylbl: UILabel!
    @IBOutlet weak var toairportname: UILabel!
    @IBOutlet weak var fromairportname: UILabel!
   
    
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
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        logoImg.image = UIImage(named: "indigo")?.withRenderingMode(.alwaysOriginal)
        logoImg.contentMode = .scaleToFill
        setuplabels(lbl: inNolbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        setuplabels(lbl: airlinecodelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        
    }
    
    
    
    
    
    func setAttributedText(str1:String,str2:String) -> NSAttributedString {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.OpenSansRegular(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.OpenSansBold(size: 12)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        layoverCitylbl.attributedText = combination
        
        return combination
    }
    
}
