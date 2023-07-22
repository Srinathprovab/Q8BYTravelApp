//
//  MenuTitleTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 18/04/23.
//

import UIKit

class MenuTitleTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
    }
    
}
