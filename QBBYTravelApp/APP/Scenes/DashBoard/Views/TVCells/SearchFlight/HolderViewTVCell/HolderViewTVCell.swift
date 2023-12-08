//
//  HolderViewTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
import DropDown


class HolderViewTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownimg: UIImageView!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var locImg1: UIImageView!
    @IBOutlet weak var tolabel: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeImg: UIImageView!
    @IBOutlet weak var swipeBtn: UIButton!
    
    var nationalityCode = String()
    let dropDown = DropDown()
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
        
        contentView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
        setupViews(v: holderView, radius: 4, color: .AppHolderViewColor)
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        swipeImg.image = UIImage(named: "swap")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        dropdownimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        dropdownimg.isHidden = true
        
        setupViews(v: toView, radius: 4, color: .AppHolderViewColor)
        setupLabels(lbl: tolabel, text: "To", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        locImg1.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        toView.isHidden = true
        swipeView.backgroundColor = .AppBackgroundColor
        swipeView.isHidden = true
        swipeBtn.setTitle("", for: .normal)
        swipeBtn.addTarget(self, action: #selector(swapCity(_:)), for: .touchUpInside)
        
        fromBtn.setTitle("", for: .normal)
        toBtn.setTitle("", for: .normal)
        
        setupDropDown()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func swapCity(_ sender:UIButton) {
        
        let a = self.titlelbl.text
        let b = self.tolabel.text
        let c = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        let d = defaults.string(forKey: UserDefaultsKeys.tolocid)
        let e = defaults.string(forKey: UserDefaultsKeys.fromcityname)
        let f = defaults.string(forKey: UserDefaultsKeys.tocityname)
        
        self.titlelbl.text = b
        self.tolabel.text = a
        
        defaults.set(self.titlelbl.text, forKey: UserDefaultsKeys.fromCity)
        defaults.set(self.tolabel.text, forKey: UserDefaultsKeys.toCity)
        defaults.set(d, forKey: UserDefaultsKeys.fromlocid)
        defaults.set(c, forKey: UserDefaultsKeys.tolocid)
        defaults.set(f, forKey: UserDefaultsKeys.fromcityname)
        defaults.set(e, forKey: UserDefaultsKeys.tocityname)
        
    
    
}

func setupDropDown() {
    
    dropDown.direction = .any
    dropDown.backgroundColor = .WhiteColor
    dropDown.anchorView = self.fromBtn
    dropDown.bottomOffset = CGPoint(x: 0, y: fromBtn.frame.size.height + 10)
    dropDown.selectionAction = { [weak self] (index: Int, item: String) in
        self?.titlelbl.text = item
        self?.titlelbl.textColor = .AppLabelColor
        self?.nationalityCode = countrylist[index].iso_country_code ?? ""
        NotificationCenter.default.post(name: NSNotification.Name("nationalityCode"), object: self?.nationalityCode)
    }
    
}


@IBAction func didTapONFromBtn(_ sender: Any) {
    dropDown.show()
}


@IBAction func didTapONToBtn(_ sender: Any) {
    
}

}
