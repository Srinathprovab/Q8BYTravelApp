//
//  LabelWithButtonTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

protocol LabelWithButtonTVCellDelegate {
    func didTapOnBackToLoginBtn(cell: LabelWithButtonTVCell)
    func didTapOnBackToCreateAccountBtn(cell: LabelWithButtonTVCell)
}


class LabelWithButtonTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    var key = String()
    var delegate:LabelWithButtonTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titlelbl.textColor = UIColor.AppSubtitleColor
        titlelbl.font = .OpenSansMedium(size: 18)
        
       
        btn.setTitleColor(.AppBtnColor, for: .normal)
        btn.titleLabel?.font = .OpenSansMedium(size: 18)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        self.key = cellInfo?.key ?? ""
        
        if cellInfo?.key == "acccreate" {
            btn.setTitle("Create Account", for: .normal)
            btn.setTitleColor(.AppBtnColor, for: .normal)
        }
    }
    
    
    @IBAction func didTapOnButton(_ sender: Any) {
        if self.key == "backlogin" {
            delegate?.didTapOnBackToLoginBtn(cell: self)
        }else {
            delegate?.didTapOnBackToCreateAccountBtn(cell: self)
        }
    }
    
    
}
