//
//  TotalNoofTravellerTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 25/09/23.
//

import UIKit

class TotalNoofTravellerTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
    }
    
}
