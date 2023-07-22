//
//  ItineraryCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class ItineraryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor.withAlphaComponent(0.50)
        holderView.layer.cornerRadius = 20
        holderView.clipsToBounds = true
        
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.OpenSansRegular(size: 16)
    }
    
    
    func setupNoofStopsView() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        setuplabels(lbl: titlelbl, text: "", textcolor: HexColor("#767676"), font: .OpenSansRegular(size: 14), align: .center)
    }
    
    
    func viewselected() {
        holderView.backgroundColor = .AppBtnColor
        titlelbl.textColor = .WhiteColor
    }
    
    
    func viewunselected() {
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = HexColor("#767676")
    }
    
}
