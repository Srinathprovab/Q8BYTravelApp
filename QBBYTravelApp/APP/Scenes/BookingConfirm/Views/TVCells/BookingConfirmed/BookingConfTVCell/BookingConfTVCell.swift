//
//  BookingConfTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 03/07/23.
//

import UIKit

protocol BookingConfTVCellDelegate {
    func didTapOnBackBtn(cell:BookingConfTVCell)
}

class BookingConfTVCell: TableViewCell {

    @IBOutlet weak var bookingIdlbl: UILabel!
    @IBOutlet weak var pnrlbl: UILabel!
    
    
    var delegate:BookingConfTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        bookingIdlbl.text = cellInfo?.title
        pnrlbl.text = cellInfo?.subTitle
    }
    
    
    @IBAction func didTapOnBackBtn(_ sender: Any) {
        delegate?.didTapOnBackBtn(cell: self)
    }
    
}
