//
//  RoundTripDetailsTVcell.swift
//  QBBYTravelApp
//
//  Created by FCI on 02/06/23.
//

import UIKit
import SDWebImage

protocol RoundTripDetailsTVcellDelegate {
    func didTaponRoundTripCell(cell:RoundTripDetailsTVcell)
}
class RoundTripDetailsTVcell: TableViewCell {
    
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var airlinecodelbl: UILabel!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var detailsTV: UITableView!
    
    
    var access_key1 = String()
    var summery1 = [Summary]()
    var delegate:RoundTripDetailsTVcellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
        logoimg.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        access_key1 = cellInfo?.title ?? ""
        airlinecodelbl.text = cellInfo?.airlinesCode
        refundablelbl.text = cellInfo?.refundable
        kwdlbl.text = cellInfo?.kwdprice
        summery1 = cellInfo?.moreData as! [Summary]
        detailsTV.reloadData()
    }
    
    func setupui(){
        setupTV()
    }
    
    func setupTV() {
        detailsTV.register(UINib(nibName: "RoundTripInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        detailsTV.delegate = self
        detailsTV.dataSource = self
        detailsTV.tableFooterView = UIView()
        detailsTV.showsHorizontalScrollIndicator = false
        detailsTV.separatorStyle = .singleLine
        detailsTV.isScrollEnabled = false
    }
    
    
}



extension RoundTripDetailsTVcell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summery1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoundTripInfoTVCell {
            
            cell.selectionStyle = .none
            let data = summery1[indexPath.row]
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = data.origin?.city
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = data.destination?.city
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
//            cell.inNolbl.text = "(\(data.operator_code ?? "")-\(data.operator_name ?? ""))"
//            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            self.airlinecodelbl.text = "(\(data.operator_code ?? "")-\(data.operator_name ?? ""))"
            self.logoimg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTaponRoundTripCell(cell: self)
    }
    
}
