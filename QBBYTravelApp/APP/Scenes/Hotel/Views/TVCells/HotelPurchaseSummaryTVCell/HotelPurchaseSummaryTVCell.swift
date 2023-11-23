//
//  HotelPurchaseSummaryTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import UIKit

class HotelPurchaseSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var roomtypelbl: UILabel!
    @IBOutlet weak var roomtypeValuelbl: UILabel!
    @IBOutlet weak var noofguestlbl: UILabel!
    @IBOutlet weak var noofguestValuelbl: UILabel!
    @IBOutlet weak var noofadultslbl: UILabel!
    @IBOutlet weak var noofadultsValuelbl: UILabel!
    @IBOutlet weak var chackinlbl: UILabel!
    @IBOutlet weak var chackinValuelbl: UILabel!
    @IBOutlet weak var chockoutlbl: UILabel!
    @IBOutlet weak var chockoutValuelbl: UILabel!
    @IBOutlet weak var cancellationPolicylbl: UILabel!
    @IBOutlet weak var cancellationPolicyValuelbl: UILabel!
    //    @IBOutlet weak var taxlbl: UILabel!
    //    @IBOutlet weak var taxValuelbl: UILabel!
    @IBOutlet weak var totalpricelbl: UILabel!
    @IBOutlet weak var totalpriceValuelbl: UILabel!
    @IBOutlet weak var totalamountlbl: UILabel!
    @IBOutlet weak var totalamountValuelbl: UILabel!
    @IBOutlet weak var ulview: UIView!
    
    
    
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
        roomtypeValuelbl.text = cellInfo?.subTitle
        noofguestValuelbl.text = cellInfo?.text
        noofadultsValuelbl.text = cellInfo?.headerText
        chackinValuelbl.text = cellInfo?.buttonTitle
        chockoutValuelbl.text = cellInfo?.key
        cancellationPolicyValuelbl.text = cellInfo?.key1
        //     taxValuelbl.text = cellInfo?.questionType
        totalpriceValuelbl.text = cellInfo?.questionBase
        totalamountValuelbl.text = cellInfo?.TotalQuestions
        
        if cancellationPolicyValuelbl.text == "Refundable" {
            setuplabels(lbl: cancellationPolicyValuelbl, text: cellInfo?.key1 ?? "", textcolor: HexColor("#35CB00"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        }else {
            setuplabels(lbl: cancellationPolicyValuelbl, text: cellInfo?.key1 ?? "", textcolor: HexColor("#FF0808"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        }
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .AppHolderViewColor
        holderview.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansMedium(size: 16), align: .left)
        setuplabels(lbl: roomtypelbl, text: "Room Type", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: noofguestlbl, text: "No Of Guest ", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: noofadultslbl, text: "No Of Adults", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: chackinlbl, text: "Chack - In", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: chockoutlbl, text: "Chock - Out", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: cancellationPolicylbl, text: "Cancellation Policy:", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        //    setuplabels(lbl: taxlbl, text: "Tax", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: totalpricelbl, text: "Total price", textcolor: HexColor("#999898"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: totalamountlbl, text: "Total Amount", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        
        
        setuplabels(lbl: roomtypeValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: noofguestValuelbl, text: " ", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: noofadultsValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: chackinValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: chockoutValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: cancellationPolicyValuelbl, text: "", textcolor: HexColor("#FF0808"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        //      setuplabels(lbl: taxValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: totalpriceValuelbl, text: "", textcolor: HexColor("#000000"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: totalamountValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansBold(size: 14), align: .right)
        
        holderview.backgroundColor = .WhiteColor
        holderview.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        
    }
    
    
    
}
