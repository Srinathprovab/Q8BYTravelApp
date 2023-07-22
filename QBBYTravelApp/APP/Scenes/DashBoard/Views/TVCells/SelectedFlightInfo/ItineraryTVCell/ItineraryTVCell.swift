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
        setuplabels(lbl: fromCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .right)
        setuplabels(lbl: fromCityDatelbl, text: "", textcolor: HexColor("#999898"), font: .oswaldRegular(size: 12), align: .left)
        setuplabels(lbl: toCityDatelbl, text: "", textcolor: HexColor("#999898"), font: .oswaldRegular(size: 12), align: .right)
        setuplabels(lbl: fromCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .left)
        setuplabels(lbl: toCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .right)
        setuplabels(lbl: hourslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        setuplabels(lbl: fromairportname, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .left)
        setuplabels(lbl: toairportname, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .right)
        setuplabels(lbl: layoverCitylbl, text: "", textcolor: .AppLabelColor, font: .oswaldRegular(size: 12), align: .center)
        
        
        fromairportname.numberOfLines = 2
        toairportname.numberOfLines = 2
        
        
        
        
    }
    
}
