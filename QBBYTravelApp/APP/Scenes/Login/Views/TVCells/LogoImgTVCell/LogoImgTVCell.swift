//
//  LogoImgTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class LogoImgTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        logoImg.image = UIImage(named: "applogo")
        setuplabels(lbl: titlelbl, text: "Login Account", textcolor: .AppLabelColor, font: .OpenSansBold(size: 20), align: .center)
        setuplabels(lbl: subtitlelbl, text: "Hello , welcome back to our account !", textcolor: HexColor("#636363"), font: .OpenSansRegular(size: 14), align: .center)
    }
    
    
    
    override func updateUI() {
        switch cellInfo?.key {
            
        case "resetpassword":
            titlelbl.text = "Reset your Password"
            subtitlelbl.text = "Enter your email and we'll send you the instructions to recover your password:"
            img.isHidden = true
            break
            
        case "createaccount":
            titlelbl.text = "Create Account"
            subtitlelbl.text = "Please Fill The Below Details"
            break
            
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
