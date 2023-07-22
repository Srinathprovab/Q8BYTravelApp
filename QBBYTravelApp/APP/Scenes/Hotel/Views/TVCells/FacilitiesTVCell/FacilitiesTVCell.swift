//
//  FacilitiesTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class FacilitiesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var facilitiesCV: UICollectionView!
    
    
    var facilitiesArray = [Facility]()

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
        titlelbl.text = cellInfo?.title
        facilitiesArray = cellInfo?.moreData as! [Facility]
        facilitiesCV.reloadData()
    }
    
    func setupCV() {
        facilitiesCV.layer.cornerRadius = 6
        facilitiesCV.clipsToBounds = true
        facilitiesCV.layer.borderWidth = 0.4
        facilitiesCV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        let nib = UINib(nibName: "AmenitiesCVCell", bundle: nil)
        facilitiesCV.register(nib, forCellWithReuseIdentifier: "cell")
        facilitiesCV.delegate = self
        facilitiesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 34)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        facilitiesCV.collectionViewLayout = layout
        facilitiesCV.backgroundColor = .clear
        facilitiesCV.layer.cornerRadius = 4
        facilitiesCV.clipsToBounds = true
        facilitiesCV.showsHorizontalScrollIndicator = false
        
        
    }
    
}


extension FacilitiesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facilitiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AmenitiesCVCell {
            
            if facilitiesArray.count != 0 {
                facilitiesCV.setEmptyMessage("")
                cell.titlelbl.text = facilitiesArray[indexPath.row].name
            }else {
                facilitiesCV.setEmptyMessage("No Data Found")
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
}

