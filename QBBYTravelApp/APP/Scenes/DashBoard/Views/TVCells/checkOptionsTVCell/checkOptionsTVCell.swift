//
//  checkOptionsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
protocol checkOptionsTVCellDelegate {
    func didTapOnMenuOptionBtn(cell:checkOptionsTVCell)
}
class checkOptionsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var sunImg: UIImageView!
    @IBOutlet weak var menuOttionBtn: UIButton!
    
    var filtertitle = String()
    var delegate:checkOptionsTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
        sunImg.image = UIImage(named: cellInfo?.image ?? "")
        checkImg.image = UIImage(named: cellInfo?.subTitle ?? "")
        if cellInfo?.key == "book" {
            contentView.backgroundColor = .AppHolderViewColor
            holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
            sunImg.isHidden = false
            sunImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            setAttributedString()
        }
        
        if cellInfo?.key == "menu" {
            sunImg.isHidden = false
            checkImg.isHidden = true
            sunImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
            menuOttionBtn.isHidden = false
        }
        
        if cellInfo?.key == "room" {
            sunImg.isHidden = true
            checkImg.isHidden = true
        }
        
        if cellInfo?.key == "ourproducts" {
            sunImg.isHidden = true
            checkImg.isHidden = true
            holderView.backgroundColor = .AppBorderColor
            titlelbl.textColor = .AppLabelColor
        }
    }
    
    
    func setAttributedString() {
        
        let str1 = "i Accept "
        let str2 = "T&C"
        let str3 = " and "
        let str4 = "Privacy Policy"
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppBackgroundColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        combination.append(atterStr4)
        titlelbl.attributedText = combination
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        titlelbl.textColor = HexColor("#767676")
        titlelbl.font = UIFont.LatoRegular(size: 16)
        titlelbl.numberOfLines = 0
        menuOttionBtn.setTitle("", for: .normal)
        menuOttionBtn.isHidden = true
        sunImg.isHidden = true
    }
    
    
    @IBAction func didTapOnMenuOptionBtn(_ sender: Any) {
        delegate?.didTapOnMenuOptionBtn(cell: self)
    }
    
    
}
