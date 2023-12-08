//
//  AddChildTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit
import CoreData

protocol AddChildTravellerTVCellDelegate {
    
    
    func didTapOnAddChildBtn(cell:AddChildTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddChildTravellerTVCell: TableViewCell, AddAdultsOrGuestTVCellDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var addChildTVHeight: NSLayoutConstraint!
    
    
    var childCount = 0
    var delegate:AddChildTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var cdetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupChildTV()
        
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
            fetchAdultCoreDataValues(str: "Child")
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Child")
            
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
            }else if journeyType == "circle"{
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
            }else {
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
            }
        }
        
        
        if childCount == 0 {
            addChildHolderView.isHidden = true
            addChildTV.isHidden = true
            addChildTVHeight.constant = 0
        }
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
//            if childTravllersArray.count > 0 && childCount > 0{
//                let height = childTravllersArray.count * 50
//                addChildTVHeight.constant = CGFloat(height)
//            }
            
            if cdetails.count == childCount {
                addChildBtnView.isHidden = true
            }
            
            if cdetails.count > 0 {
                let height = cdetails.count * 50
                addChildTVHeight.constant = CGFloat(height)
            }
            
        }else {
            if cdetails.count == childCount {
                addChildBtnView.isHidden = true
            }
            
            if cdetails.count > 0 {
                let height = cdetails.count * 50
                addChildTVHeight.constant = CGFloat(height)
            }
            
        }
        
        self.contentView.layoutIfNeeded()
        self.addChildTV.reloadData()
        
    }
    
    
    func setupUI() {
        
        addChildTVHeight.constant = 0
        contentView.backgroundColor = .AppHolderViewColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setupViews(v: addChildBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setuplabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        addChildBtn.setTitle("", for: .normal)
        
        addChildBtnView.backgroundColor = .clear
    }
    
    
    func setupChildTV() {
        addChildTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.separatorStyle = .none
        addChildTV.showsHorizontalScrollIndicator = false
        addChildTV.isScrollEnabled = false
        addChildTV.allowsMultipleSelection = true
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
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
    
    
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Child")
        
        if   cdetails.count > childCount || cdetails.count == childCount{
            addChildBtnView.isHidden = true
        }else {
            addChildBtnView.isHidden = false
        }
        
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            
            cdetails = try context.fetch(request)
            
            if cdetails.count > 0 {
                let height = cdetails.count * 50
                addChildTVHeight.constant = CGFloat(height)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        if cdetails.count > 0 {
            context.delete(cdetails[index] as! NSManagedObject )
            cdetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
           
            self.addChildTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            fetchAdultCoreDataValues(str: "Adult")
            updateUI()
            
            
        }
    }
    
    
    
}


extension AddChildTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cdetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            let data = cdetails as! [NSManagedObject]
            cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Child"
          //  cell.deleteBtnView.isHidden = true
            
            if   cdetails.count > childCount || cdetails.count == childCount{
                addChildBtnView.isHidden = true
            }else {
                addChildBtnView.isHidden = false
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
            arrayOf_SelectedCellsChild.append(indexPath)
            let data = cdetails as! [NSManagedObject]
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
        
        
        if arrayOf_SelectedCellsChild.contains(indexPath) {
            cell1?.selected1()
            addChildTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            
        } else {
            cell1?.unselected()
            addChildTV.deselectRow(at: indexPath, animated: true)
            
        }
        
    }

    
}

