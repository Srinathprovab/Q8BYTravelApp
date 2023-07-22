//
//  SelectTabCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class SelectTabCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imgHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgHolderView.backgroundColor = .clear
        holderView.addCornerRadiusWithShadow(color: HexColor("#0F0F0F",alpha: 0.70), borderColor: .clear, cornerRadius: 8)
        

    }

}
