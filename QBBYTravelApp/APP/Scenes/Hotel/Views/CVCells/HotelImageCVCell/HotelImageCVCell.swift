//
//  HotelImageCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class HotelImageCVCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hotelImg.layer.cornerRadius = 6
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
    }
    
}
