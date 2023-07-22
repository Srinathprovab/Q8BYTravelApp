//
//  HotelDealsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import SDWebImage

protocol HotelDealsTVCellDelegate {
    func didTapOnViewDetailsBtn(cell:HotelDealsTVCell)
}

class HotelDealsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dealsCV: UICollectionView!
    
    var currentIndex = 0
    var currentCellIndex = 0
    var delegate:HotelDealsTVCellDelegate?
    var key = String()
    // Define actions for next and previous buttons
    var nextButtonAction: (() -> Void)?
    var previousButtonAction: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        dealsCV.reloadData()
    }
    
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "HotelDealsCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 210, height: 140)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        dealsCV.collectionViewLayout = layout
        dealsCV.layer.cornerRadius = 4
        dealsCV.clipsToBounds = true
        dealsCV.showsHorizontalScrollIndicator = false
        
    }
    
    
    @objc func didTapOnViewDetailsBtn(_ sender:UIButton) {
        delegate?.didTapOnViewDetailsBtn(cell: self)
    }
    
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        nextButtonAction?()
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        
        previousButtonAction?()
        
    }
    
    
}



extension HotelDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellInfo?.key == "holiday" {
            return perfectholidaysArray.count
        }else if cellInfo?.key == "flight" {
            return besttopflightArray.count
        }else {
            return besttopHotelArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelDealsCVCell {
            
            
            // Set up next and previous button actions
            self.nextButtonAction = { [weak self] in
                self?.showNextCard()
            }
            
            self.previousButtonAction = { [weak self] in
                self?.showPreviousCard()
            }
            
            
            if cellInfo?.key == "holiday" {
                let data = perfectholidaysArray[indexPath.row]
                
                cell.dealsImg.sd_setImage(with: URL(string: "\(cellInfo?.title ?? "")\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                
                cell.citylbl.text = "\(data.country_name ?? "") "
                
                
            }else if cellInfo?.key == "flight" {
                let data = besttopflightArray[indexPath.row]
                
                cell.dealsImg.sd_setImage(with: URL(string: "\(cellInfo?.title ?? "")\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.citylbl.text = data.to_city_name
                
            }else {
                
                let data = besttopHotelArray[indexPath.row]
                
                cell.dealsImg.sd_setImage(with: URL(string: "\(cellInfo?.title ?? "")\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                
                cell.citylbl.text = data.to_city_name
                
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    // MARK: Button Actions
    
    func showNextCard() {
        currentIndex += 1
        
        
        if cellInfo?.key == "holiday" {
            
            if currentIndex >= perfectholidaysArray.count {
                currentIndex = 0
            }
        }else if cellInfo?.key == "flight" {
            
            if currentIndex >= besttopflightArray.count {
                currentIndex = 0
            }
        }else {
            
            if currentIndex >= besttopHotelArray.count {
                currentIndex = 0
            }
        }
        
        
        // Scroll to the next cell
        let indexPath = IndexPath(item: currentIndex, section: 0)
        dealsCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func showPreviousCard() {
        currentIndex -= 1
        
        
        if cellInfo?.key == "holiday" {
            
            if currentIndex < 0 {
                currentIndex = perfectholidaysArray.count - 1
            }
        }else if cellInfo?.key == "flight" {
            
            if currentIndex < 0 {
                currentIndex = besttopflightArray.count - 1
            }
        }else {
            
            if currentIndex < 0 {
                currentIndex = besttopHotelArray.count - 1
            }
        }
        
        
        // Scroll to the previous cell
        let indexPath = IndexPath(item: currentIndex, section: 0)
        dealsCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}

