//
//  DualViewTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
protocol DualViewTVCellDelegate {
    func didTapOnSelectDepDateBtn(cell:DualViewTVCell)
    func didTapOnSelectRepDateBtn(cell:DualViewTVCell)
}

class DualViewTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var cal1Img: UIImageView!
    @IBOutlet weak var depBtn: UIButton!
    
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var cal2img: UIImageView!
    @IBOutlet weak var returnlbl: UILabel!
    @IBOutlet weak var returnBtn: UIButton!
    
    var delegate:DualViewTVCellDelegate?
    var key = String()
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
        holderView.backgroundColor = .clear
        setupViews(v: depView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: returnView, radius: 4, color: .AppHolderViewColor)
        
        returnlbl.isHidden = true
        cal2img.isHidden = true
        returnBtn.isHidden = true
        setupLabels(lbl: deplbl, text: "Select Data", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: returnlbl, text: "Select Data", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        self.cal1Img.image = UIImage(named: "cal")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        self.cal2img.image = UIImage(named: "cal")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        
        depBtn.setTitle("", for: .normal)
        depBtn.addTarget(self, action: #selector(didTapOnSelectDepDateBtn(_:)), for: .touchUpInside)
        returnBtn.setTitle("", for: .normal)
        returnBtn.addTarget(self, action: #selector(didTapOnSelectRepDateBtn(_:)), for: .touchUpInside)
        
        
    }
    
    
    func showReturnView() {
        returnlbl.isHidden = false
        cal2img.isHidden = false
        returnBtn.isHidden = false
        //        returnView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
    }
    
    
    func hideRetView() {
        //        returnView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
        returnlbl.isHidden = true
        cal2img.isHidden = true
        returnBtn.isHidden = true
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
    
    
    @objc func didTapOnSelectDepDateBtn(_ sender:UIButton){
        delegate?.didTapOnSelectDepDateBtn(cell: self)
    }
    @objc func didTapOnSelectRepDateBtn(_ sender:UIButton){
        delegate?.didTapOnSelectRepDateBtn(cell: self)
    }
}
