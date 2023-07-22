//
//  SearchFlightResultInfoTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
import SDWebImage

protocol SearchFlightResultInfoTVCellDelegate {
    func didTapOnRefunduableBtn(cell:SearchFlightResultInfoTVCell)
}


class SearchFlightResultInfoTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var round2: UIImageView!
    @IBOutlet weak var round1: UIImageView!
    @IBOutlet weak var round3: UIImageView!
    
    
    
    var access_key1 = String()
    var delegate:SearchFlightResultInfoTVCellDelegate?
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
        
        access_key1 = cellInfo?.title ?? ""
        inNolbl.text = cellInfo?.airlinesCode
        fromCityTimelbl.text = cellInfo?.fromTime
        fromCityNamelbl.text = cellInfo?.fromCity
        toCityTimelbl.text = cellInfo?.toTime
        toCityNamelbl.text = cellInfo?.toCity
        hourslbl.text = cellInfo?.travelTime
        noOfStopslbl.text = cellInfo?.noosStops
        kwdlbl.text = cellInfo?.kwdprice
        refundablelbl.text = cellInfo?.refundable
        
        logoImg.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        switch cellInfo?.noosStops {
        case "0 Stops":
            round1.isHidden = true
            round2.isHidden = true
            round3.isHidden = true
            break
        case "1 Stops":
            round1.isHidden = false
            round2.isHidden = true
            round3.isHidden = true
            break
        case "2 Stops":
            round1.isHidden = false
            round2.isHidden = false
            round3.isHidden = true
            break
        default:
            break
        }
        
        
    }
    
    func setupUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#A6C2FA"), cornerRadius: 6)
        logoImg.image = UIImage(named: "indigo")?.withRenderingMode(.alwaysOriginal)
        logoImg.contentMode = .scaleToFill
        
        setuplabels(lbl: inNolbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        setuplabels(lbl: fromCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 20), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 20), align: .right)
        setuplabels(lbl: fromCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .left)
        setuplabels(lbl: toCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .right)
        setuplabels(lbl: hourslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        setuplabels(lbl: noOfStopslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        setuplabels(lbl: kwdlbl, text: "", textcolor: HexColor("#EC441E"), font: .OpenSansBold(size: 14), align: .right)
        setuplabels(lbl: refundablelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .left)
        
        round1.isHidden = true
        round2.isHidden = true
        round3.isHidden = true
    }
    
    
}
