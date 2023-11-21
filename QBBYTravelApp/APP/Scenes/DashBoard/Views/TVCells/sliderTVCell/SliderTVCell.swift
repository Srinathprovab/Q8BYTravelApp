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
    
    
    var minValue = Float()
    var maxValue = Float()
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
        
        setupInitivalues()
        
        
        // rangeSlider.step = 10
        rangeSlider.handleType = .rectangle
        rangeSlider.lineHeight = 5
        rangeSlider.tintColor = .AppBackgroundColor
        rangeSlider.tintColorBetweenHandles = .AppBackgroundColor
        rangeSlider.lineBorderColor = .AppBackgroundColor
        rangeSlider.handleDiameter = 40.0
        rangeSlider.hideLabels = true
        rangeSlider.handleColor = .lightGray
        rangeSlider.maxLabelColour = .black
        rangeSlider.minLabelColour = .black
        rangeSlider.delegate = self
        downBtn.isHidden = true
    }
    
    
    func setupInitivalues() {
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String {
            if selectedTap == "Airline" {
                if let minPrice = filterModel.minPriceRange, let maxPrice = filterModel.maxPriceRange {
                    // Both minPrice and maxPrice have values in filterModel
                    minValue = Float(minPrice)
                    maxValue = Float(maxPrice)
                    
                    
                    rangeSlider.minValue = prices.compactMap { Float($0) }.min()!
                    rangeSlider.maxValue = prices.compactMap { Float($0) }.max()!
                    
                    // Set the thumbs to the values
                    rangeSlider.selectedMinimum = minValue
                    rangeSlider.selectedMaximum = maxValue
                    
                    //  Update the slider's appearance
                    rangeSlider.setNeedsDisplay()
                }
                
                
            } else {
                if let minPrice = hotelfiltermodel.minPriceRange, let maxPrice = hotelfiltermodel.maxPriceRange {
                    // Both minPrice and maxPrice have values in filterModel
                    minValue = Float(minPrice)
                    maxValue = Float(maxPrice)


                    rangeSlider.minValue = prices.compactMap { Float($0) }.min()!
                    rangeSlider.maxValue = prices.compactMap { Float($0) }.max()!

                    // Set the thumbs to the values
                    rangeSlider.selectedMinimum = minValue
                    rangeSlider.selectedMaximum = maxValue

                    //  Update the slider's appearance
                    rangeSlider.setNeedsDisplay()
                }
                
            }
        }
        
        // Update labels and other UI elements as needed
        minValue1 = Double(String(format: "%.2f", Double(minValue))) ?? 0.0
        maxValue1 = Double(String(format: "%.2f", Double(maxValue))) ?? 100.0 // Update the default max value here
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(minValue1)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(maxValue1)"
        
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
        let minLabelText = String(format: "%.2f", selectedMinimum)
        let maxLabelText = String(format: "%.2f", selectedMaximum)
        
        minValue1 = Double(minLabelText) ?? 0.0
        maxValue1 = Double(maxLabelText) ?? 0.0
        
        minlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(minLabelText)"
        maxlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "") \(maxLabelText)"
        
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
    @IBAction func didTapOnShowSliderBtn(_ sender: Any) {
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
    
}
