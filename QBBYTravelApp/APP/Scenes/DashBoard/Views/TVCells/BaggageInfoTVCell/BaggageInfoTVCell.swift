//
//  BaggageInfoTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cabinBagImg: UIImageView!
    @IBOutlet weak var cabinBaglbl: UILabel!
    @IBOutlet weak var checkInImg: UIImageView!
    @IBOutlet weak var checkInlbl: UILabel!
    @IBOutlet weak var kglbl1: UILabel!
    @IBOutlet weak var kglbl2: UILabel!
    @IBOutlet weak var sectorlbl: UILabel!
    @IBOutlet weak var sectorValuelbl: UILabel!
    @IBOutlet weak var sectorImg: UIImageView!
    
    
    
    
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
        sectorValuelbl.text = cellInfo?.title
        kglbl1.text = cellInfo?.subTitle
        kglbl2.text = cellInfo?.buttonTitle
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 5, color: .WhiteColor)
        setupLabels(lbl: cabinBaglbl, text: "Cabin Bag", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14))
        setupLabels(lbl: checkInlbl, text: "Check In", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14))
        
        
        setupLabels(lbl: kglbl1, text: "7 KG", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: kglbl2, text: "25 KG", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))

        setupLabels(lbl: sectorlbl, text: "Sector", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14))
        setupLabels(lbl: sectorValuelbl, text: "Kwati-Dubai", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))

        
        cabinBagImg.image = UIImage(named: "suit")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        checkInImg.image = UIImage(named: "bag")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        sectorImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)

    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
}
