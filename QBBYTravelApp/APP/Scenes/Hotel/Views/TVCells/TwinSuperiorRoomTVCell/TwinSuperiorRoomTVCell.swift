//
//  TwinSuperiorRoomTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

protocol TwinSuperiorRoomTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
}

class TwinSuperiorRoomTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cancellationPoloicyBtn: UIButton!
    @IBOutlet weak var adultsImg: UIImageView!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var nonRefundablelbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var cancellationlbl: UILabel!
    @IBOutlet weak var cancelationBtn: UIButton!
    
    
    var CancellationPolicyAmount = String()
    var CancellationPolicyFromDate = String()
    var ratekey = String()
    var delegate:TwinSuperiorRoomTVCellDelegate?
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
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        radioImg.image = UIImage(named: "radioUnselected")
        adultsImg.image = UIImage(named: "adult")
        
        setupLabels(lbl: titlelbl, text: "1 x Double Or Twin Superior", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14))
        setupLabels(lbl: subtitlelbl, text: "2 Adults", textcolor: .AppSubtitleColor, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: nonRefundablelbl, text: "Non-Refundable", textcolor: .red, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: kwdPricelbl, text: "180.00", textcolor: .AppBtnColor, font: .poppinsSemiBold(size: 12))
    
        cancellationlbl.text = ""
        setupLabels(lbl: cancellationlbl, text: "View Cancellation Policy", textcolor: .AppSubtitleColor, font: .poppinsRegular(size: 10))
        cancellationlbl.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        cancelationBtn.setTitle("", for: .normal)
        
        
        cancelationBtn.addTarget(self, action: #selector(cancelationBtnAction(_:)), for: .touchUpInside)
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    @objc func cancelationBtnAction(_ sender:UIButton) {
        delegate?.didTapOnCancellationPolicyBtn(cell: self)
    }
}
