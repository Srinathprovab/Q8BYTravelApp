//
//  AddInfantaTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit




import UIKit
import CoreData


protocol AddInfantaTravellerTVCellDelegate {
    
    
    func didTapOnAddInfantaBtn(cell:AddInfantaTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddInfantaTravellerTVCell: TableViewCell,AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addInfantaHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var addInfantaBtnView: UIView!
    @IBOutlet weak var addInfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantaTVHeight: NSLayoutConstraint!
    
    
    var infantsCount = 0
    var delegate:AddInfantaTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupInfantaTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
    }
    
    
    override func updateUI() {
        checkOptionCountArray.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Infantas")
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Infantas")
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else if journeyType == "circle"{
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        
        
        
        if infantsCount == 0 {
            addInfantaHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantaTVHeight.constant = 0
        }
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
//            if infantaTravllersArray.count > 0 && infantsCount > 0{
//                let height = infantaTravllersArray.count * 50
//                infantaTVHeight.constant = CGFloat(height)
//            }
            
            
            if idetails.count == infantsCount {
                addInfantaBtnView.isHidden = true
            }
            
            
            if idetails.count > 0 {
                let height = idetails.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
        }else {
            
            
            if idetails.count == infantsCount {
                addInfantaBtnView.isHidden = true
            }
            
            
            if idetails.count > 0 {
                let height = idetails.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
        }
        
        self.contentView.layoutIfNeeded()
        self.addInfantaTV.reloadData()
        
        
        
    }
    
    func setupUI() {
        
        infantaTVHeight.constant = 0
        addInfantaHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        setupViews(v: addInfantaBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setuplabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        addInfantaBtn.setTitle("", for: .normal)
        addInfantaBtnView.backgroundColor = .clear
        
    }
    
    
    
    
    
    func setupInfantaTV() {
        addInfantaTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addInfantaTV.delegate = self
        addInfantaTV.dataSource = self
        addInfantaTV.tableFooterView = UIView()
        addInfantaTV.separatorStyle = .none
        addInfantaTV.showsHorizontalScrollIndicator = false
        addInfantaTV.isScrollEnabled = false
        addInfantaTV.allowsMultipleSelection = true
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppHolderViewColor.cgColor
    }
    
    
    
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOnEditTraveller(cell: cell)
    }
    
    
    
    
    
    func didTapOnOptionBtn(cell:AddAdultsOrGuestTVCell){
        
        
        if checkBool5 == true {
            
            if (Int(totalNoOfTravellers) ?? 0) >= checkOptionCountArray.count {
                checkOptionCountArray.append(cell.travellerId)
            }
            
            cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = false
        }else {
            if cell.indexPath?.row ?? 0 < checkOptionCountArray.count && !(cell.indexPath?.row ?? 0 < 0) {
                checkOptionCountArray.remove(at: cell.indexPath?.row ?? 0)
            }
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = true
        }
        
        print(checkOptionCountArray)
    }
    
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Infanta")
        
        if   idetails.count > infantsCount || idetails.count == infantsCount{
            addInfantaBtnView.isHidden = true
            infantaTVHeight.constant = 0
        }else {
            addInfantaBtnView.isHidden = false
        }
        
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            
            idetails = try context.fetch(request)
            
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        if idetails.count > 0 {
            context.delete(idetails[index] as! NSManagedObject )
            idetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            self.addInfantaTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
    
    
}


extension AddInfantaTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.checkOptionBtn.tag = cell.indexPath?.row ?? 0
            
            let data = idetails as! [NSManagedObject]
            cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Infant"
         //   cell.deleteBtnView.isHidden = true
            
            if   idetails.count > infantsCount || idetails.count == infantsCount{
                addInfantaBtnView.isHidden = true
            }else {
                addInfantaBtnView.isHidden = false
            }
            
            ccell = cell
        }
        
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AddAdultsOrGuestTVCell {
            cell.isSelected = true
            cell.selected1()
            arrayOf_SelectedCellsInfanta.append(indexPath)
            let data = idetails as! [NSManagedObject]
            let passenger = Passenger(
                passengerType: data[indexPath.row].value(forKey: "title") as? String ?? "",
                nameTitle: data[indexPath.row].value(forKey: "nameTitle") as? String ?? "",
                firstName: data[indexPath.row].value(forKey: "fname") as? String ?? "",
                lastName: data[indexPath.row].value(forKey: "lname") as? String ?? "",
                dateOfBirth: data[indexPath.row].value(forKey: "dob") as? String ?? "",
                passportExpiryDate: data[indexPath.row].value(forKey: "passportexpirydate") as? String ?? "",
                passportNumber: data[indexPath.row].value(forKey: "passportno") as? String ?? "",
                countryCode: data[indexPath.row].value(forKey: "countryCode") as? String ?? "",
                issuingCountryCode: data[indexPath.row].value(forKey: "issuingCountryCode") as? String ?? "",
                nationalitycode: data[indexPath.row].value(forKey: "nationalitycode") as? String ?? "",
                middleName: "",
                isLeadPassenger: "1",
                gender: (data[indexPath.row].value(forKey: "gender") as? String ?? "") == "Male" ? "1" : ((data[indexPath.row].value(forKey: "gender") as? String ?? "") == "Female" ? "2" : "3")
            )
            passengerA.append(passenger)
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AddAdultsOrGuestTVCell {
            cell.isSelected = false
            cell.unselected()
            tableView.deselectRow(at: indexPath, animated: true)
            
            if indexPath.row < passengerA.count {
                passengerA.remove(at: indexPath.row)
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell1 = cell as? AddAdultsOrGuestTVCell
        
        
        if arrayOf_SelectedCellsInfanta.contains(indexPath) {
            cell1?.selected1()
            addInfantaTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            
        } else {
            cell1?.unselected()
            addInfantaTV.deselectRow(at: indexPath, animated: true)
            
        }
        
    }
    

    
}
