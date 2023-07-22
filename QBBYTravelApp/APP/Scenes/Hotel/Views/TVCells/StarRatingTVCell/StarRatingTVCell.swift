//
//  StarRatingTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
protocol StarRatingTVCellDelegate {
    func didTapOnStarRatingCell(cell:StarRatingCVCell)
}


class StarRatingTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var starratingCV: UICollectionView!
    
    var delegate:StarRatingTVCellDelegate?
    var array = ["1","2","3","4","5"]
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
        starratingCV.reloadData()
    }
    
    func setupUI() {
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OpenSansBold(size: 16)
        setupCV()
    }
    
    
    
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "StarRatingCVCell", bundle: nil)
        starratingCV.register(nib, forCellWithReuseIdentifier: "cell")
        starratingCV.delegate = self
        starratingCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 55, height: 28)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        // layout.sectionInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        starratingCV.collectionViewLayout = layout
        starratingCV.backgroundColor = .clear
        starratingCV.layer.cornerRadius = 4
        starratingCV.clipsToBounds = true
        starratingCV.showsHorizontalScrollIndicator = false
        
        
    }
}

extension StarRatingTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StarRatingCVCell {
            cell.titlelbl.text = array[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            cell.holderview.layer.borderColor = UIColor.AppBtnColor.cgColor
            cell.titlelbl.textColor = .AppBtnColor
            delegate?.didTapOnStarRatingCell(cell: cell)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            cell.holderview.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            cell.titlelbl.textColor = .AppLabelColor
        }
    }
    
}
