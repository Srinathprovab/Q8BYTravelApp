//
//  TDetailsLoginTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol TDetailsLoginTVCellDelegate {
    func didTapOnLoginBtn(cell:TDetailsLoginTVCell)
}

class TDetailsLoginTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var loginImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var loginlbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var delegate:TDetailsLoginTVCellDelegate?
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
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .AppBackgroundColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        loginImg.image = UIImage(named: "login")?.withRenderingMode(.alwaysOriginal)
        loginBtnView.backgroundColor = .WhiteColor
        loginBtnView.layer.cornerRadius = 4
        loginBtnView.clipsToBounds = true
        
        titlelbl.text = "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. At vel sed at"
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.LatoRegular(size: 12)
        titlelbl.numberOfLines = 0
        
        loginlbl.text = "Login"
        loginlbl.textColor = .AppBackgroundColor
        loginlbl.font = UIFont.LatoSemibold(size: 14)
        
        
        loginBtn.setTitle("", for: .normal)
        imgView.backgroundColor = .WhiteColor
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
    }
    
    
    @IBAction func didTapOnLoginBtn(_ sender: Any) {
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    
}
