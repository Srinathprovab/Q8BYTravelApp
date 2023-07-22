//
//  TravellerAdultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

class TravellerAdultTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var adultCountlbl: UILabel!
    @IBOutlet weak var farelbl: UILabel!
    @IBOutlet weak var taxeslbl: UILabel!
    @IBOutlet weak var adultKWDlbl: UILabel!
    @IBOutlet weak var fareKWDlbl: UILabel!
    @IBOutlet weak var taxesKWDlbl: UILabel!
    
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
        setupViews(v: holderView, radius: 0, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupLabels(lbl: adultCountlbl, text: "traveller 1( adult)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: farelbl, text: "Fare", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: taxeslbl, text: "Taxes", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: adultKWDlbl, text: "kWD :250.00", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: taxesKWDlbl, text: "kWD :80.00", textcolor: .AppSubtitleColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fareKWDlbl, text: "kWD :250.00", textcolor: .AppSubtitleColor, font: .LatoRegular(size: 14))

    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
