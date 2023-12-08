//
//  RoundTripTVcell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit


protocol RoundTripTVcellDelegate {
    func didTapOnFlightDetailsBtnAction(cell:RoundTripTVcell)
    func didTaponRoundTripCell(cell:RoundTripTVcell)
}

class RoundTripTVcell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinelogo: UIImageView!
    @IBOutlet weak var airlinecode: UILabel!
    @IBOutlet weak var flightDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var refundlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var flightDetailsview: UIView!
    
    var delegate:RoundTripTVcellDelegate?
    var count = Int()
    var summery1 = [Summary]()
    var access_key1 = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        access_key1 = cellInfo?.title ?? ""
        summery1 = cellInfo?.moreData as! [Summary]
        count = cellInfo?.characterLimit ?? 0
        kwdPricelbl.text = cellInfo?.kwdprice
        refundlbl.text = cellInfo?.refundable
        
        if cellInfo?.key == "paynow"{
            kwdPricelbl.isHidden = true
            refundlbl.isHidden = true
            flightDetailsview.isHidden = false
        }
        
        tvHeight.constant = CGFloat((summery1.count * 85))
        flightDetailsTV.reloadData()
    }
    
    
    
    func setuUI() {
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        flightDetailsview.isHidden = true
        setupTV()
    }
    
    
    
    func setupTV() {
        flightDetailsTV.register(UINib(nibName: "RoundTripInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDetailsTV.delegate = self
        flightDetailsTV.dataSource = self
        flightDetailsTV.tableFooterView = UIView()
        flightDetailsTV.showsHorizontalScrollIndicator = false
        flightDetailsTV.separatorStyle = .none
        flightDetailsTV.isScrollEnabled = false
    }
    
    
    @IBAction func didTapOnFlightDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightDetailsBtnAction(cell: self)
    }
    
}


extension RoundTripTVcell:UITableViewDelegate,UITableViewDataSource {
    
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
            
            self.airlinecode.text = "\(data.operator_name ?? "") (\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            self.airlinelogo.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            
            switch data.no_of_stops {
            case 0:
                cell.round1.isHidden = true
                cell.round2.isHidden = true
                cell.round3.isHidden = true
                break
                
            case 1:
                cell.round1.isHidden = false
                cell.round2.isHidden = true
                cell.round3.isHidden = true
                break
                
            case 2:
                cell.round1.isHidden = false
                cell.round2.isHidden = false
                cell.round3.isHidden = true
                break
                
                
            default:
                break
            }
            
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTaponRoundTripCell(cell: self)
    }
    
}
