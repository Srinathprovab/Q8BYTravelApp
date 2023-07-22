//
//  FlightRelatedSearchTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 20/06/23.
//

import UIKit

class FlightRelatedSearchTVCell: TableViewCell {
    
    @IBOutlet weak var flightSearchcv: UICollectionView!
    
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
        setupCV()
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "FlightRelatedListCVCell", bundle: nil)
        flightSearchcv.register(nib, forCellWithReuseIdentifier: "cell")
        flightSearchcv.delegate = self
        flightSearchcv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 116)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flightSearchcv.collectionViewLayout = layout
        flightSearchcv.backgroundColor = .clear
        flightSearchcv.layer.cornerRadius = 4
        flightSearchcv.clipsToBounds = true
        flightSearchcv.showsVerticalScrollIndicator = false
        
    }
    
    
}


extension FlightRelatedSearchTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FlightRelatedListCVCell {
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
            
            
        }
    }
    
}

