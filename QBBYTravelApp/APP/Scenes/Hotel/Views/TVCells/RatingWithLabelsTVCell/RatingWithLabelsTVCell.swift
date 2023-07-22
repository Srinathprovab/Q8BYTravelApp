//
//  RatingWithLabelsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit
import AARatingBar

class RatingWithLabelsTVCell: TableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ratingBar: AARatingBar!
    
    
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
        subtitlelbl.attributedText = cellInfo?.subTitle?.htmlToAttributedString
        ratingBar.value = CGFloat(cellInfo?.characterLimit ?? 0)
        
        if cellInfo?.key == "rating" {
            ratingBar.isHidden = false
        }
    }
    
    func setupUI() {
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 16))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppSubtitleColor, font: .OpenSansRegular(size: 14))
        ratingBar.maxValue = 5
        ratingBar.color = HexColor("#FABF35")
        ratingBar.isHidden = true
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
}
