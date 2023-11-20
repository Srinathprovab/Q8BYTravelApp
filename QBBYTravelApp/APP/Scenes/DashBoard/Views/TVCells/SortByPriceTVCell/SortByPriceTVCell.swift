//
//  SortByPriceTVCell.swift
//  BestFares365App
//
//  Created by FCI on 20/03/23.
//

import UIKit


protocol SortByPriceTVCellDelegate {
    func didTapOnLowToHeighBtnAction(cell:SortByPriceTVCell)
    func didTapOnHeighToLowBtnAction(cell:SortByPriceTVCell)
}

class SortByPriceTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lowView: UIView!
    @IBOutlet weak var lowlbl: UILabel!
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var heighlbl: UILabel!
    @IBOutlet weak var heighBtn: UIButton!
    
    
    var delegate:SortByPriceTVCellDelegate?
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
        lowlbl.text = cellInfo?.subTitle
        heighlbl.text = cellInfo?.buttonTitle
        setupSotyBy()
        
    }
    
    
    func setupSotyBy() {
        
        switch sortBy {
            
            //Price
        case .PriceLow:
            if titlelbl.text == "PRICE" {
                lowtoheigh()
            }
            
            if titlelbl.text == "Price" {
                lowtoheigh()
            }
            break
            
        case .PriceHigh:
            
            if titlelbl.text == "PRICE" {
                heightolow()
            }
            
            if titlelbl.text == "Price" {
                heightolow()
            }
            break
            
            //Departure
        case .DepartureLow:
            if titlelbl.text == "Departure Time" {
                lowtoheigh()
            }
            break
            
        case .DepartureHigh:
            
            if titlelbl.text == "Departure Time" {
                heightolow()
            }
            break
            
            
            //Arrival Time
        case .ArrivalLow:
            if titlelbl.text == "Arrival Time" {
                lowtoheigh()
            }
            break
            
        case .ArrivalHigh:
            
            if titlelbl.text == "Arrival Time" {
                heightolow()
            }
            break
            
            
            
            //Duration
        case .DurationLow:
            if titlelbl.text == "Duration" {
                lowtoheigh()
            }
            break
            
        case .DurationHigh:
            
            if titlelbl.text == "Duration" {
                heightolow()
            }
            break
            
            
            
            //Airlines Names Sort
        case .airlineaz:
            if titlelbl.text == "AIRLINE" {
                lowtoheigh()
            }
            break
            
        case .airlineza:
            
            if titlelbl.text == "AIRLINE" {
                heightolow()
            }
            break
            
            
            //Airlines Names Sort
        case .hotelaz:
            if titlelbl.text == "Hotel" {
                lowtoheigh()
            }
            break
            
        case .hotelza:
            
            if titlelbl.text == "Hotel" {
                heightolow()
            }
            break
            
            
        case .nothing:
            starting()
            break
            
            
        default:
            starting()
            break
        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: lowlbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: heighlbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        lowBtn.setTitle("", for: .normal)
        heighBtn.setTitle("", for: .normal)
        lowView.backgroundColor = .WhiteColor
        lowView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 16)
        heightView.backgroundColor = .WhiteColor
        heightView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 16)
        
    }
    
    
    
    @IBAction func didTapOnLowToHeighBtnAction(_ sender: Any) {
        lowView.backgroundColor = .AppBackgroundColor
        lowlbl.textColor = .WhiteColor
        heightView.backgroundColor = .WhiteColor
        heighlbl.textColor = HexColor("#27272A")
        
        delegate?.didTapOnLowToHeighBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnHeighToLowBtnAction(_ sender: Any) {
        
        heightView.backgroundColor = .AppBackgroundColor
        heighlbl.textColor = .WhiteColor
        lowView.backgroundColor = .WhiteColor
        lowlbl.textColor = HexColor("#27272A")
        
        delegate?.didTapOnHeighToLowBtnAction(cell: self)
    }
    
    
    func starting(){
        self.lowlbl.textColor = .AppLabelColor
        self.lowView.backgroundColor = .WhiteColor
        self.heighlbl.textColor = .AppLabelColor
        self.heightView.backgroundColor = .WhiteColor
    }
    
    
    
    func lowtoheigh(){
        self.lowlbl.textColor = .WhiteColor
        self.lowView.backgroundColor = .AppBtnColor
        self.heighlbl.textColor = .AppLabelColor
        self.heightView.backgroundColor = .WhiteColor
    }
    
    
    func heightolow(){
        self.lowlbl.textColor = .AppLabelColor
        self.lowView.backgroundColor = .WhiteColor
        self.heighlbl.textColor = .WhiteColor
        self.heightView.backgroundColor = .AppBtnColor
    }
    
}
