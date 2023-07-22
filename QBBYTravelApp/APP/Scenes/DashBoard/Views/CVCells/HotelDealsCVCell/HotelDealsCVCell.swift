//
//  HotelDealsCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

protocol HotelDealsCVCellDelegate {
    func didTapOnViewDetailsBtn(cell:HotelDealsCVCell)
}

class HotelDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dealsImg: UIImageView!
    @IBOutlet weak var citylbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        holderView.layer.cornerRadius = 6
        holderView.clipsToBounds = true
        
        dealsImg.image = UIImage(named: "flight1")
        setupLabels(lbl: citylbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14))
        
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
