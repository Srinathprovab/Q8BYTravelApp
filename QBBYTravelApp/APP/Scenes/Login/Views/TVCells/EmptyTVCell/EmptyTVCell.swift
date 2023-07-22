//
//  EmptyTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit


class EmptyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.backgroundColor = .WhiteColor
        
    }
    
    override func updateUI() {
        viewHeight.constant = cellInfo?.height ?? 10
        holderView.backgroundColor = cellInfo?.bgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
