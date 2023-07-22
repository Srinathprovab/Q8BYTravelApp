//
//  UnderLineTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class UnderLineTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var leftLineView: UIView!
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
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        leftLineView.backgroundColor = HexColor("#A39797").withAlphaComponent(0.5)
        rightLineView.backgroundColor = HexColor("#A39797").withAlphaComponent(0.5)
        
        titlelbl.text = "Or Sign Up With"
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        
    }
    
}
