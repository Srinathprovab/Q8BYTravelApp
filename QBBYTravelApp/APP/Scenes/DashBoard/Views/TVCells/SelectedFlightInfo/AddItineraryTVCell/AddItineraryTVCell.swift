//
//  AddItineraryTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit

class AddItineraryTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addDetailsTv: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var fd = [FlightDetails]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        fd = cellInfo?.moreData as! [FlightDetails]
        tvHeight.constant = CGFloat(fd.count * 193)
        addDetailsTv.reloadData()
    }
    
    
    func setupTV() {
        
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        
        addDetailsTv.register(UINib(nibName: "ItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addDetailsTv.delegate = self
        addDetailsTv.dataSource = self
        addDetailsTv.tableFooterView = UIView()
        addDetailsTv.showsHorizontalScrollIndicator = false
        addDetailsTv.separatorStyle = .none
        addDetailsTv.isScrollEnabled = false
    }
    
}

extension AddItineraryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ItineraryTVCell {
            cell.selectionStyle = .none
            
            let data = fd[indexPath.row]
            cell.inNolbl.text = "\(data.operator_code ?? "")-\(data.flight_number ?? "")"
            cell.airlinecodelbl.isHidden = true
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.fromCityDatelbl.text = data.origin?.date
            cell.toCityTimelbl.text =  data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.toCityDatelbl.text = data.destination?.date
            cell.hourslbl.text = data.duration
            cell.fromairportname.text = data.origin?.city
            cell.toairportname.text = data.destination?.city
          
            
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

            cell.setAttributedText(str1: "Stopover: \(data.layOverDuration ?? "") \(data.destination?.loc ?? "")", str2: " \(data.destination?.city ?? "")")
            
            
            if tableView.isLast(for: indexPath) == true {
                cell.layoverView.isHidden = true
            }
            
            c = cell
        }
        return c
    }
    
    
    
}


extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
