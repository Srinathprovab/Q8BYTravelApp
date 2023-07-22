//
//  VoucherFDTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 04/07/23.
//

import UIKit

class VoucherFDTVCell: TableViewCell {
    
    
    @IBOutlet weak var airlinelogo: UIImageView!
    @IBOutlet weak var airlinenolbl: UILabel!
    @IBOutlet weak var refundablelnl: UILabel!
    @IBOutlet weak var economyclasslbl: UILabel!
    @IBOutlet weak var fromtimelbl: UILabel!
    @IBOutlet weak var fromcitycodelbl: UILabel!
    @IBOutlet weak var fromcitydatelbl: UILabel!
    @IBOutlet weak var fromairportlbl: UILabel!
    @IBOutlet weak var fromterminallbl: UILabel!
    @IBOutlet weak var totimelbl: UILabel!
    @IBOutlet weak var tocitycodelbl: UILabel!
    @IBOutlet weak var tocitydatelbl: UILabel!
    @IBOutlet weak var toairportlbl: UILabel!
    @IBOutlet weak var toterminallbl: UILabel!
    @IBOutlet weak var hourlbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {

        airlinelogo.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        airlinenolbl.text = cellInfo?.airlinesCode
        fromtimelbl.text = cellInfo?.fromTime
        fromcitycodelbl.text = cellInfo?.fromCity
        fromcitydatelbl.text = cellInfo?.fromdate
        fromairportlbl.text = cellInfo?.title ?? "fromairportlbl"
        fromterminallbl.text = cellInfo?.subTitle ?? "fromterminallbl"

        totimelbl.text = cellInfo?.toTime
        tocitycodelbl.text = cellInfo?.toCity
        tocitydatelbl.text = cellInfo?.todate
        toairportlbl.text = cellInfo?.buttonTitle ?? "toairportlbl"
        toterminallbl.text = cellInfo?.tempText ?? "toterminallbl"

        hourlbl.text = cellInfo?.travelTime
        refundablelnl.text = cellInfo?.refundable
        economyclasslbl.text = cellInfo?.text

    }
    
}
