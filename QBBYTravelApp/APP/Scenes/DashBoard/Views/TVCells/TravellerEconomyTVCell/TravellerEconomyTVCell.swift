//
//  TravellerEconomyTVCell.swift
//  AirportProject
//
//  Created by Codebele 09 on 22/06/22.
//

import UIKit

protocol TravellerEconomyTVCellDelegate {
    func didTapOnDecrementButton(cell:TravellerEconomyTVCell)
    func didTapOnIncrementButton(cell:TravellerEconomyTVCell)
}

class TravellerEconomyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var decrementView: UIView!
    @IBOutlet weak var decrementImg: UIImageView!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var incrementView: UIView!
    @IBOutlet weak var incrementImg: UIImageView!
    
    var delegate: TravellerEconomyTVCellDelegate?
    var count = 0
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
        subTitlelbl.text = cellInfo?.subTitle
        
        
        
        if titlelbl.text == "Adults" {
            count = Int(cellInfo?.text ?? "1") ?? 1
        }else {
            count = Int(cellInfo?.text ?? "0") ?? 0
        }
        countlbl.text = cellInfo?.text
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor:  .lightGray.withAlphaComponent(0.3), cornerRadius: 5)
        
        decrementView.backgroundColor = .clear
        incrementView.backgroundColor = .clear
        decrementView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 15)
        incrementView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 15)
        
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18), align: .left)
        setuplabels(lbl: subTitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        setuplabels(lbl: countlbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18), align: .center)
        incrementImg.image = UIImage(named: "incr")
        decrementImg.image = UIImage(named: "decr")
        
    }
    
    
    @IBAction func didTapOnDecrementButton(_ sender: Any) {
        delegate?.didTapOnDecrementButton(cell: self)
    }
    
    @IBAction func didTapOnIncrementButton(_ sender: Any) {
        delegate?.didTapOnIncrementButton(cell: self)
    }
    
    
}
