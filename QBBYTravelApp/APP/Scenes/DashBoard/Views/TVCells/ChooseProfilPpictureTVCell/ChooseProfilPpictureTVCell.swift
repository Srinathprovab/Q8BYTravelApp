//
//  ChooseProfilPpictureTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 24/08/22.
//

import UIKit
protocol ChooseProfilPpictureTVCellDelegate {
    func didtapOnChooseprofilePitctureBtn(cell:ChooseProfilPpictureTVCell)
}

class ChooseProfilPpictureTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imageHolderView: UIView!
    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var camImg: UIImageView!
    @IBOutlet weak var camBtn: UIButton!
    @IBOutlet weak var chooseProfileView: UIView!
    @IBOutlet weak var chooselbl: UILabel!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    
    var delegate:ChooseProfilPpictureTVCellDelegate?
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
        let img = cellInfo?.image
        profileImg.image = UIImage(named: img ?? "")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppBackgroundColor
        setupViews(v: imageHolderView, radius: 38, color: .clear)
        setupViews(v: camView, radius: 10, color: .WhiteColor)
        setupViews(v: chooseProfileView, radius: 0, color: .clear)
        chooseProfileView.addBottomBorderWithColor(color: .WhiteColor, width: 0.5)
        profileImg.contentMode = .scaleToFill
        camImg.image = UIImage(named: "cam")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: chooselbl, text: "Choose Profile Picture", textcolor: .WhiteColor, font: .OpenSansRegular(size: 12))
        setupLabels(lbl: titlelbl, text: "", textcolor: .WhiteColor, font: .OpenSansMedium(size: 24))
        
        chooseBtn.setTitle("", for: .normal)
        camBtn.setTitle("", for: .normal)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @IBAction func didTapOnCameraBtn(_ sender: Any) {
        delegate?.didtapOnChooseprofilePitctureBtn(cell: self)
    }
    
    
    @IBAction func didtapOnChooseprofilePitcture(_ sender: Any) {
        delegate?.didtapOnChooseprofilePitctureBtn(cell: self)
    }
    
}
