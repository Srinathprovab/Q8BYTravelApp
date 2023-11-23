//
//  AddAdultsOrGuestTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit

protocol AddAdultsOrGuestTVCellDelegate {
    
    func didTapOnEditAdultBtn(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnOptionBtn(cell:AddAdultsOrGuestTVCell)
}

class AddAdultsOrGuestTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtnView: UIView!
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var checkOptionBtn: UIButton!
    
    var passengerType = String()
    var travellerId = String()
    var index = Int()
    var delegate:AddAdultsOrGuestTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
//        if selected {
//            if (Int(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0") ?? 0) == checkOptionCountArray.count {
//                unselected()
//            }else {
//                selected1()
//            }
//
//        }else {
//            unselected()
//        }
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppHolderViewColor
        editBtnView.backgroundColor = .WhiteColor
        deleteBtnView.backgroundColor = .WhiteColor
        
        checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
        editImg.image = UIImage(named: "edit1")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        deleteImg.image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
        editBtn.setTitle("", for: .normal)
        deleteBtn.setTitle("", for: .normal)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        
        checkOptionBtn.setTitle("", for: .normal)
        checkOptionBtn.addTarget(self, action: #selector(didTapOnOptionBtn(_:)), for: .touchUpInside)
        checkOptionBtn.isHidden = true
    
    }
    
    
    @objc func didTapOnOptionBtn(_ sender:UIButton) {
        delegate?.didTapOnOptionBtn(cell: self)
    }
    
    
    @IBAction func didTapOnEditAdultBtn(_ sender: Any) {
        delegate?.didTapOnEditAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOndeleteTravellerBtnAction(_ sender: Any) {
        delegate?.didTapOndeleteTravellerBtnAction(cell: self)
    }
    
    
    func selected1() {
        checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
    }
    
    func unselected() {
        checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
    }
    
}
