//
//  LogowithMenuTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 20/06/23.
//

import UIKit

protocol LogowithMenuTVCellDelegate {
    func didTapOnMenuBtn(cell:LogowithMenuTVCell)
    func didTapOnLaungageBtn(cell:LogowithMenuTVCell)
}


class LogowithMenuTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var haiImg: UIImageView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langImg: UIImageView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencylbl: UILabel!
    
    
    var delegate:LogowithMenuTVCellDelegate?
    
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
        holderView.backgroundColor = .AppHolderViewColor
        haiImg.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        langImg.image = UIImage(named: "lang")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        langBtn.setTitle("", for: .normal)
        menuBtn.setTitle("", for: .normal)
        
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCurrency), name: NSNotification.Name("selectedCurrency"), object: nil)
    }
    
    @objc func selectedCurrency(){
        
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .left)
    }
    
    
    
    
    
    @IBAction func didTapOnMenuBtn(_ sender: Any) {
        delegate?.didTapOnMenuBtn(cell: self)
    }
    
    
    @IBAction func didTapOnLaungageBtn(_ sender: Any) {
       // delegate?.didTapOnLaungageBtn(cell: self)
    }
    
}


