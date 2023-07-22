//
//  DownloadTicketTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 04/07/23.
//

import UIKit


protocol DownloadTicketTVCellDelegate{
    func didTapOnDownloadBtnAction(cell:DownloadTicketTVCell)
}
class DownloadTicketTVCell: TableViewCell {

    
    var delegate:DownloadTicketTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnDownloadBtnAction(_ sender: Any) {
        delegate?.didTapOnDownloadBtnAction(cell: self)
    }
    
}
