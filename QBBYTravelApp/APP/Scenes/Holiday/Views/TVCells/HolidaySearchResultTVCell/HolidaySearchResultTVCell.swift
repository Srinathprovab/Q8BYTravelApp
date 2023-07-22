//
//  HolidaySearchResultTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 24/05/23.
//

import UIKit
import AARatingBar

protocol HolidaySearchResultTVCellDelegate {
    func didTapOnHolidayDetailsBtnAction(cell:HolidaySearchResultTVCell)
}

class HolidaySearchResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ratingView: AARatingBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var specialCV: UICollectionView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    
    var packageid = String()
    var delegate:HolidaySearchResultTVCellDelegate?
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
        subtitlelbl.text = cellInfo?.subTitle
        packageid = cellInfo?.buttonTitle ?? ""
        ratingView.value = CGFloat(cellInfo?.characterLimit ?? 0)
        img.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        kwdlbl.text = cellInfo?.text
    }
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        holderView.layer.cornerRadius = 6
        holderView.clipsToBounds = true
        
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
        
        ratingView.maxValue = 5
        ratingView.color = HexColor("#FABF35")
        ratingView.isUserInteractionEnabled = false
        detailsBtn.setTitle("", for: .normal)
        detailsBtn.addTarget(self, action: #selector(didTapOnHolidayDetailsBtnAction(_:)), for: .touchUpInside)
        
        setupCV()
    }
    
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "HolidaySpecialCVCell", bundle: nil)
        specialCV.register(nib, forCellWithReuseIdentifier: "cell")
        specialCV.delegate = self
        specialCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 38, height: 38)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        specialCV.collectionViewLayout = layout
        specialCV.backgroundColor = .clear
        specialCV.showsVerticalScrollIndicator = false
        specialCV.isScrollEnabled = false
    }
    
    
    @objc func didTapOnHolidayDetailsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnHolidayDetailsBtnAction(cell: self)
    }
    
}



extension HolidaySearchResultTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HolidaySpecialCVCell {
            cell.titlelbl.text = "flight"
            //   cell.img.image = UIImage(named: tabImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
            commonCell = cell
        }
        return commonCell
    }
    
}
