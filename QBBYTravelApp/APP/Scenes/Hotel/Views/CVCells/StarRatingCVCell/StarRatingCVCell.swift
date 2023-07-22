//
//  StarRatingCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit

class StarRatingCVCell: UICollectionViewCell {
    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var titlelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderview.backgroundColor = .white
        holderview.layer.cornerRadius = 14
        holderview.clipsToBounds = true
        holderview.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        holderview.layer.borderWidth = 1
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OpenSansBold(size: 16)
    }

}
