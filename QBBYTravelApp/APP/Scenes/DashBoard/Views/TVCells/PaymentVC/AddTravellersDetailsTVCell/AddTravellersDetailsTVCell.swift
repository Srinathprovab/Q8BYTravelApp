//
//  AddTravellersDetailsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
import CoreData

protocol AddTravellersDetailsTVCellDelegate {
    func didTapOnAddAdultBtn(cell:AddTravellersDetailsTVCell)
    func didTapOnAddChildBtn(cell:AddTravellersDetailsTVCell)
    func didTapOnAddInfantaBtn(cell:AddTravellersDetailsTVCell)
    func didTapOnEditBtn(cell:TitleLblTVCell)
}

class AddTravellersDetailsTVCell: TableViewCell,TitleLblTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultbtnHolderView: UIView!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var childbtnHolderView: UIView!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var childaddImg: UIImageView!
    @IBOutlet weak var addchildBtn: UIButton!
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var childtvheight: NSLayoutConstraint!
    @IBOutlet weak var infantatnHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var infantaaddImg: UIImageView!
    @IBOutlet weak var addinfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantatvheight: NSLayoutConstraint!
    
    
    var detailsArray = [String]()
    var delegate:AddTravellersDetailsTVCellDelegate?
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var cdetails  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        setupChildTV()
        setupInfantaTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    override func updateUI() {
        
        
        details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
        fetchAdultCoreDataValues(str: "Adult")
        fetchAdultCoreDataValues(str: "Children")
        fetchAdultCoreDataValues(str: "Infantas")
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        
        if childCount == 0 {
            childbtnHolderView.isHidden = true
            addChildTV.isHidden = true
            childtvheight.constant = 0
        }
        
        if infantsCount == 0 {
            infantatnHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantatvheight.constant = 0
        }
        
        
        
        if cdetails.count == childCount {
            addchildBtn.isUserInteractionEnabled = false
        }
        
        if idetails.count == infantsCount {
            addinfantaBtn.isUserInteractionEnabled = false
        }
        
        
        
        if adetails.count > 0 {
            let height = adetails.count * 40
            tvheight.constant = CGFloat(height)
        }
        
        
        if cdetails.count > 0 {
            let height = cdetails.count * 40
            childtvheight.constant = CGFloat(height)
        }
        
        
        if idetails.count > 0 {
            let height = idetails.count * 40
            infantatvheight.constant = CGFloat(height)
        }
        
        
        
        
        self.contentView.layoutIfNeeded()
        self.addAdultTV.reloadData()
        self.addChildTV.reloadData()
        self.addInfantaTV.reloadData()
        
       
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18))
        
        setupLabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        addImg.image = UIImage(named: "add")
        setupViews(v: adultbtnHolderView, radius: 4, color: HexColor("#113255", alpha: 0.20))
        addAdultBtn.setTitle("", for: .normal)
        
        setupLabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        childaddImg.image = UIImage(named: "add")
        setupViews(v: childbtnHolderView, radius: 4, color: HexColor("#113255", alpha: 0.20))
        addchildBtn.setTitle("", for: .normal)
        
        setupLabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        childaddImg.image = UIImage(named: "add")
        setupViews(v: infantatnHolderView, radius: 4, color: HexColor("#113255", alpha: 0.20))
        addinfantaBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupAdultTV() {
        tvheight.constant = 0
        addAdultTV.backgroundColor = .clear
        addAdultTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.showsHorizontalScrollIndicator = false
        addAdultTV.isScrollEnabled = false
        
    }
    
    func setupChildTV() {
        childtvheight.constant = 0
        addChildTV.backgroundColor = .clear
        addChildTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.showsHorizontalScrollIndicator = false
        addChildTV.isScrollEnabled = false
        
    }
    
    func setupInfantaTV() {
        infantatvheight.constant = 0
        addInfantaTV.backgroundColor = .clear
        addInfantaTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        addInfantaTV.delegate = self
        addInfantaTV.dataSource = self
        addInfantaTV.tableFooterView = UIView()
        addInfantaTV.showsHorizontalScrollIndicator = false
        addInfantaTV.isScrollEnabled = false
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    
    func didTapOnEditBtn(cell: TitleLblTVCell) {
        delegate?.didTapOnEditBtn(cell: cell)
    }
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            if str == "Adult" {
                adetails = try context.fetch(request)
            }else if str == "Children" {
                cdetails = try context.fetch(request)
            }else {
                idetails = try context.fetch(request)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
}



extension AddTravellersDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == addAdultTV {
            return adetails.count
        }else if tableView == addChildTV{
            return cdetails.count
        }else {
            return idetails.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if tableView == addAdultTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = adetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                if adetails.count == adultsCount {
                    addAdultBtn.isUserInteractionEnabled = false
                }
                
                ccell = cell
            }
            
        }else if tableView == addChildTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = cdetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                let data = idetails as! [NSManagedObject]
                cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
