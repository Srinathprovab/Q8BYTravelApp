//
//  MultiCityTripTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit
protocol MultiCityTripTVCellDelegate {
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
    func didTapOnMultiCityTripSearchFlight(cell:AddCityTVCell)
    func didTapOnAddTravellerEconomy(cell:AddCityTVCell)
}

class MultiCityTripTVCell: TableViewCell, ButtonTVCellDelegate, AddCityTVCellDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var multiTripTV: UITableView!
    
    var delegate:MultiCityTripTVCellDelegate?
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
        multiTripTV.reloadData()
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupTV()
    }
    
    func setupTV() {
        multiTripTV.backgroundColor = .AppHolderViewColor
        multiTripTV.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        multiTripTV.register(UINib(nibName: "AddCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        multiTripTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        multiTripTV.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        multiTripTV.delegate = self
        multiTripTV.dataSource = self
        multiTripTV.tableFooterView = UIView()
        multiTripTV.separatorStyle = .none
        multiTripTV.layer.cornerRadius = 8
        multiTripTV.clipsToBounds = true
        
    }
    
    
    func btnAction(cell: ButtonTVCell) {
        
    }
    
    @objc func didTapOnAddTravellerEconomy(cell:HolderViewTVCell) {
        
    }
    
    
    func didTapOnFromBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnFromBtn(cell: cell)
    }
    
    func didTapOnToBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnToBtn(cell: cell)
    }
    
    func didTapOndateBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOndateBtn(cell: cell)
    }
    
    func didTapOnCloseBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnCloseBtn(cell: cell)
    }
    
    
    func didTapOnAddCityBtn(cell: AddCityTVCell) {
        multiTripTV.reloadData()
    }
    
    
    func didTapOnMultiCityTripSearchFlight(cell: AddCityTVCell) {
        delegate?.didTapOnAddTravellerEconomy(cell: cell)
    }
    
    func didTapOnAddTravellerEconomy(cell: AddCityTVCell) {
        delegate?.didTapOnMultiCityTripSearchFlight(cell: cell)
    }
    
}

extension MultiCityTripTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var c = UITableViewCell()
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddCityTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                c = cell
            }
        }
        
        return c
    }
    
    
}
