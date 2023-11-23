//
//  HotelSearchResultTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit
import AARatingBar
import SDWebImage



class HotelSearchResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    
    var bs = String()
    var hotelcode = String()
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
        ratingView.value = CGFloat(cellInfo?.characterLimit ?? 0)
        hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        kwdlbl.text = cellInfo?.kwdprice
        
        if cellInfo?.tempText == "Refundable" {
            refundablelbl.text = "Refundable"
            refundablelbl.textColor = .AppBtnColor
        }else {
            refundablelbl.text = "Non Refundable"
            refundablelbl.textColor = .KWDColor
        }
        bs = cellInfo?.buttonTitle ?? ""
        hotelcode = cellInfo?.headerText ?? ""

    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 20, color: .WhiteColor)
        setupLabels(lbl: kwdlbl, text: "KWD:120.00", textcolor: .KWDColor, font: .OpenSansBold(size: 16))
       
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 16))
        titlelbl.numberOfLines = 0
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppSubtitleColor, font: .OpenSansMedium(size: 12))
        subtitlelbl.numberOfLines = 0
        hotelImg.contentMode = .scaleToFill
        ratingView.maxValue = 5
        ratingView.color = HexColor("#FABF35")
        ratingView.isUserInteractionEnabled = false
        
        setupLabels(lbl: refundablelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12))
        refundablelbl.textAlignment = .right
        
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
}
