//
//  LabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit


class LabelTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    var key = String()
    var titleKey = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .AppHolderViewColor
        img.isHidden = false
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 20)
        titlelbl.numberOfLines = 0
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 18), align: .center)
        
        
        subTitlelbl.textColor = .AppSubtitleColor
        subTitlelbl.font = UIFont.OpenSansRegular(size: 14)
        subTitlelbl.numberOfLines = 0
        subTitlelbl.textAlignment = .center
        subTitlelbl.isHidden = true
        
    }
    
    override func updateUI() {
        
        
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        self.titleKey = cellInfo?.key1 ?? ""
        key = cellInfo?.key ?? ""
        switch cellInfo?.key {
            
        case "resetpass":
            img.isHidden = true
            break
            
            
        case "backlogin":
            img.isHidden = true
            setuplabels(lbl: titlelbl, text: "", textcolor: .AppSubtitleColor, font: .LatoRegular(size: 18), align: .left)
            break
            
            
        case "deals":
            img.isHidden = true
            holderView.backgroundColor = .AppHolderViewColor
            setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18), align: .center)
            setuplabels(lbl: subTitlelbl, text: cellInfo?.subTitle ?? "", textcolor: .AppBGColor, font: .OpenSansBold(size: 18), align: .center)
            break
            
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //    func setAttributedText(str1:String,str2:String) -> NSAttributedString {
    //
    //        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.oswaldRegular(size: 28)] as [NSAttributedString.Key : Any]
    //        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppBtnColor,NSAttributedString.Key.font:UIFont.oswaldRegular(size: 28)] as [NSAttributedString.Key : Any]
    //
    //        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
    //        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
    //
    //
    //        let combination = NSMutableAttributedString()
    //        combination.append(atterStr1)
    //        combination.append(atterStr2)
    //
    //
    //        return combination
    //    }
    
}
