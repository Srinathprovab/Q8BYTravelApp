//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtn(cell:MenuBGTVCell)
    func didTapOnEditProfileBtn(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfilelbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    
    var delegate:MenuBGTVCellDelegate?
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
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.userLoggedIn)
        if logstatus == true {
            
            loginBtn.setTitle("\(profildata?.first_name ?? "") \(profildata?.last_name ?? "")", for: .normal)
            loginBtn.isUserInteractionEnabled = false
            if profildata?.image?.isEmpty == true {
                profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            }else {
                self.profileImage.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            }
            editProfileView.isHidden = false
            editProfileViewHeight.constant = 30
        }else {
            loginBtn.setTitle("Login/Signup", for: .normal)
            loginBtn.isUserInteractionEnabled = true
            profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            editProfileView.isHidden = true
            editProfileViewHeight.constant = 15
        }
        
        
        
    }
    
    func setupUI() {
        
        profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        profileImage.layer.cornerRadius = 30
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.WhiteColor.cgColor
        
        loginBtn.setTitle("Login/Signup", for: .normal)
        loginBtn.setTitleColor(.WhiteColor, for: .normal)
        loginBtn.titleLabel?.font = UIFont.LatoRegular(size: 25)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        loginBtn.isHidden = false
        
        
        editProfileView.backgroundColor = .WhiteColor.withAlphaComponent(0.40)
        editProfileView.layer.cornerRadius = 15
        editProfileView.clipsToBounds = true
        editProfileView.layer.borderWidth = 2
        editProfileView.layer.borderColor = UIColor.WhiteColor.cgColor
        editProfileView.isHidden = false
        editProfileBtn.setTitle("", for: .normal)
        
        setuplabels(lbl: editProfilelbl, text: "Edit Profile", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
        editProfileViewHeight.constant = 0
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
    }
}
