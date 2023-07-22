//
//  AboutustitleTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import UIKit

class AboutustitleTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
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
        self.titlelbl.attributedText = (cellInfo?.title ?? "").htmlToAttributedString
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
    }
    
}
