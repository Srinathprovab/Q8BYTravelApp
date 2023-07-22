//
//  BookedAdultDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedAdultDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var ticketnolbl: UILabel!
    
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
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: travellerNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: typelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: ticketnolbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
   
    
}
