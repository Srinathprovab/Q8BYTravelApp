//
//  RoundTripInfoTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit

class RoundTripInfoTVCell: UITableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var round2: UIImageView!
    @IBOutlet weak var round1: UIImageView!
    @IBOutlet weak var round3: UIImageView!
   
    
    
    
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
        
        //contentView.backgroundColor = .AppHolderViewColor
     
        setuplabels(lbl: fromCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .right)
        setuplabels(lbl: fromCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .left)
        setuplabels(lbl: toCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 14), align: .right)
        setuplabels(lbl: hourslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        setuplabels(lbl: noOfStopslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        round1.isHidden = true
        round2.isHidden = true
        round3.isHidden = true
        
//        switch noOfStopslbl.text {
//        case "0":
//            break
//        case "1":
//            round1.isHidden = false
//            break
//        case "2":
//            round1.isHidden = false
//            round2.isHidden = false
//            break
//        default:
//            break
//        }
        
    }
    
}
