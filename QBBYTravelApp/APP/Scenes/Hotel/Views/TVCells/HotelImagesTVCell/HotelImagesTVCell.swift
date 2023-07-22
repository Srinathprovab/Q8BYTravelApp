//
//  HotelImagesTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit
import SDWebImage


class HotelImagesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelImagesCV: UICollectionView!
    
    var hotelImages = [Images]()
    
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
        self.hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        hotelImages = cellInfo?.moreData as! [Images]
        hotelImagesCV.reloadData()
    }
    
    
    func setupCV() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        
        let nib = UINib(nibName: "HotelImageCVCell", bundle: nil)
        hotelImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        hotelImagesCV.delegate = self
        hotelImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  
        hotelImagesCV.collectionViewLayout = layout
        hotelImagesCV.backgroundColor = .clear
        hotelImagesCV.layer.cornerRadius = 4
        hotelImagesCV.clipsToBounds = true
        hotelImagesCV.showsHorizontalScrollIndicator = false
        
        
    }
    
}


extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImageCVCell {
            
            cell.hotelImg.sd_setImage(with: URL(string: hotelImages[indexPath.row].img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelImageCVCell {
            self.hotelImg.image = cell.hotelImg.image
        }
    }

    
}
