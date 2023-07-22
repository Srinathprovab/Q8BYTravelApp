//
//  PriceLabelsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit

class PriceLabelsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    
    
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
        titlelbl.text = cellInfo?.title
        subtitlelbl.text = cellInfo?.subTitle
        
        switch cellInfo?.key {
        case "title":
            titlelbl.textColor = .AppLabelColor
            titlelbl.font = UIFont.OpenSansMedium(size: 18)
            subtitlelbl.isHidden = true
            break
            
        case "roomtype":
            subtitlelbl.font = UIFont.OpenSansMedium(size: 12)
            break
            
        case "policy":
            subtitlelbl.textColor = .red
            break
            
        case "price":
            ulView.isHidden = false
            break
            
        case "total":
            titlelbl.textColor = .AppLabelColor
            break
            
        default:
            break
        }
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: HexColor("#999898"), font: .OpenSansRegular(size: 16))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .oswaldRegular(size: 16))
        ulView.backgroundColor = .AppLabelColor
        ulView.isHidden = true
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
}
