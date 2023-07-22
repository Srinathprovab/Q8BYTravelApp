//
//  AddAdultTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit
import CoreData

struct Passenger {
    var passengerType: String
    var nameTitle: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var passportExpiryDate: String
    var passportNumber: String
    var countryCode: String
    var issuingCountryCode: String
    var nationalitycode:String
    var middleName: String
    var isLeadPassenger: String
    var gender: String
}

protocol AddAdultTravellerTVCellDelegate {
    
    func didTapOnAddAdultBtn(cell:AddAdultTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddAdultTravellerTVCell: TableViewCell, AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    @IBOutlet weak var contentholderview: UIView!
    
    
    @IBOutlet weak var adultcountlbl: UILabel!
    @IBOutlet weak var childcountlbl: UILabel!
    @IBOutlet weak var infantacountlbl: UILabel!
    
    var adultsCount = 1
    var delegate:AddAdultTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    var checkOptionCountArray1 = [String]()
    var passengertypeArray1 = [String]()
    var title2Array1 = [String]()
    var fnameArray1 = [String]()
    var lnameArray1 = [String]()
    var dobArray1 = [String]()
    var passportNoArray1 = [String]()
    var countryCodeArray1 = [String]()
    var passportexpiryArray1 = [String]()
    var passportissuingcountryArray1 = [String]()
    var middleNameArray1 = [String]()
    var leadPassengerArray1 = [String]()
    var genderArray1 = [String]()
    var arrayOf_SelectedCellsAdult1 = [IndexPath]()
    
    
    // Create an instance of NSCache
    let cache = NSCache<NSString, AnyObject>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
    }
    
    
    override func updateUI() {
        
        checkOptionCountArray.removeAll()
        titlelbl.text = cellInfo?.title
        
        adultcountlbl.text = "ADULTS:\(cellInfo?.subTitle ?? "")"
        childcountlbl.text = "CHILD:\(cellInfo?.buttonTitle ?? "")"
        infantacountlbl.text = "INFANTA:\(cellInfo?.tempText ?? "")"
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Adult")
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Adult")
            
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
            }
        }
        
        
        if titlelbl.text == "Guests Details" {
            infantacountlbl.isHidden = true
        }
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
            
            //            if adultTravllersArray.count > 0 {
            //                let height = adultTravllersArray.count * 50
            //                adultTVHeight.constant = CGFloat(height)
            //            }
            
            
            if adetails.count > 0 {
                let height = adetails.count * 50
                adultTVHeight.constant = CGFloat(height)
            }
            
            
        }else {
            if adetails.count > 0 {
                let height = adetails.count * 50
                adultTVHeight.constant = CGFloat(height)
            }
            
        }
        
        
        self.addAdultTV.reloadData()
        
        
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .AppHolderViewColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        //    holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        // addAdultHolderView.addBottomBorderWithColor(color: HexColor("#113255",alpha: 0.20), width: 1)
        
        // setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: HexColor("#FCEDFF"))
        
        //       travelImg.image = UIImage(named: "travel")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: addlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        addlbl.isHidden = true
        
        
        
        
        addAdultBtn.setTitle("", for: .normal)
        
        // addAdultHolderView.backgroundColor = HexColor("#113255",alpha: 0.20)
        addAdultBtnView.backgroundColor = .clear
        
        //        contentholderview.layer.borderWidth = 1
        //        contentholderview.layer.borderColor = UIColor.AppBorderColor.cgColor
        //contentholderview.
    }
    
    
    func setupAdultTV() {
        addAdultTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.separatorStyle = .none
        addAdultTV.showsHorizontalScrollIndicator = false
        addAdultTV.isScrollEnabled = false
        addAdultTV.allowsMultipleSelection = true
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
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Adult")
        
        if   adetails.count > adultsCount || adetails.count == adultsCount{
            addAdultBtnView.isHidden = true
        }else {
            addAdultBtnView.isHidden = false
        }
        
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
        
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            adetails = try context.fetch(request)
            if let myEntity = adetails.first {
                
                // Set the CoreData object in the cache with a key
                cache.setObject(myEntity as AnyObject, forKey: "myEntityCacheKey")
            }
            
        }catch let error as NSError {
            print("Error fetching object from CoreData: \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        
        if adetails.count > 0 {
            context.delete(adetails[index] as! NSManagedObject )
            adetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            
            
            self.addAdultTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
}


extension AddAdultTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adetails.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.deleteBtn.tag = indexPath.row
            
            // Retrieve the NSManagedObject for the current row
            guard let data = adetails[indexPath.row] as? NSManagedObject else {
                return cell
            }
            
            cell.titlelbl.text = data.value(forKey: "fname") as? String ?? ""
            cell.travellerId = data.value(forKey: "id") as? String ?? ""

            cell.passengerType = "Adult"
            
            cell.index = cell.indexPath?.row ?? 0
            // cell.deleteBtnView.isHidden = true
            
            if   adetails.count > adultsCount || adetails.count == adultsCount{
                addAdultBtnView.isHidden = true
            }else {
                addAdultBtnView.isHidden = false
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
            arrayOf_SelectedCellsAdult.append(indexPath)
            let data = adetails as! [NSManagedObject]
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
        
        if tableView == addAdultTV {
            if arrayOf_SelectedCellsAdult.contains(indexPath) {
                // cell1?.selected1()
                addAdultTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                
            } else {
                //  cell1?.unselected()
                addAdultTV.deselectRow(at: indexPath, animated: true)
            }
        }
        
    }
    
    
}

