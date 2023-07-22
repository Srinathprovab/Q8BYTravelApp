//
//  SliderTVCell.swift
//  BabSafar
//
//  Created by MA673 on 05/08/22.
//

import UIKit
import SwiftRangeSlider
import TTRangeSlider

protocol SliderTVCellDelegate {
    func didTapOnShowSliderBtn(cell:SliderTVCell)
}

class SliderTVCell: TableViewCell, TTRangeSliderDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lblHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var sliderHolderView: UIView!
    @IBOutlet weak var sliderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var minlbl: UILabel!
    @IBOutlet weak var maxlbl: UILabel!
    
    
    var key = String()
    var minValue1 = Double()
    var maxValue1 = Double()
    var showbool = true
    var delegate:SliderTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        self.key = cellInfo?.key ?? ""
        expand()
        if self.key == "hotel" {
            downImg.isHidden = true
            expand()
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        lblHolderView.backgroundColor = .WhiteColor
        sliderHolderView.backgroundColor = .WhiteColor
        downImg.image = UIImage(named: "downarrow")
        downBtn.setTitle("", for: .normal)
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 16))
        setuplabels(lbl: minlbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .center)
        setuplabels(lbl: maxlbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .center)
        rangeSlider.isHidden = true
        rangeSlider.backgroundColor = .WhiteColor
        
        let pricesFloat = prices.compactMap { Float($0) }
        let minValue = pricesFloat.min() ?? 0.0
        let maxValue = pricesFloat.max() ?? 0.0
        rangeSlider.minValue = minValue
        rangeSlider.maxValue = maxValue
        minValue1 = Double(minValue)
        maxValue1 = Double(maxValue)
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(minValue)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(maxValue)"
        
        
        // Set the thumbs to the minimum and maximum values
        rangeSlider.selectedMinimum = minValue
        rangeSlider.selectedMaximum = maxValue
        
        // rangeSlider.step = 10
        rangeSlider.handleType = .rectangle
        rangeSlider.lineHeight = 5
        rangeSlider.tintColor = .AppBtnColor
        rangeSlider.tintColorBetweenHandles = .AppBtnColor
        rangeSlider.lineBorderColor = .AppBtnColor
        rangeSlider.handleDiameter = 40.0
        rangeSlider.hideLabels = true
        rangeSlider.handleColor = .lightGray
        rangeSlider.maxLabelColour = .black
        rangeSlider.minLabelColour = .black
        rangeSlider.delegate = self
        downBtn.isHidden = true
    }
    
    
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func rangeSliderValueChanged(slider: TTRangeSlider) {
        print("maxValue \(slider.maxValue)")
    }
    
    
    func expand() {
        sliderViewHeight.constant = 120
        rangeSlider.isHidden = false
    }
    
    func hide() {
        sliderViewHeight.constant = 0
        rangeSlider.isHidden = true
    }
    
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let minLabelText = String(format: "%.1f", selectedMinimum)
        let maxLabelText = String(format: "%.1f", selectedMaximum)
        
        minValue1 = Double(minLabelText) ?? 0.0
        maxValue1 = Double(maxLabelText) ?? 0.0
        
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(minLabelText)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(maxLabelText)"
        
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
    @IBAction func didTapOnShowSliderBtn(_ sender: Any) {
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
}
