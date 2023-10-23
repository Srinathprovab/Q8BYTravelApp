//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit
import CoreData


class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
                
                
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupUI() {
        self.view.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["RadioButtonTVCell",
                                         "TravellerEconomyTVCell",
                                         "TitleLblTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "checkOptionsTVCell",
                                         "CommonTVCell"])
        
        nav.navtitle.isHidden = false
        setuplabels(lbl:  nav.navtitle, text: "Select Traveller, Economy", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        setupSearchFlightEconomyTVCells()
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: String(adultsCount),cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Child",subTitle: "2 - 11",text:String(childCount),cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",text: String(infantsCount),cellType:.TravellerEconomyTVCell))
        
        
        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Select Class",cellType:.TitleLblTVCell))
        tableRow.append(TableRow(cellType:.CommonTVCell))
        
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    @objc func gotoBackScreen() {
        self.dismiss(animated: true)
    }
    
    
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        
        if (infantsCount) > 8 {
            showToast(message: "Infants Count not mor than 9 ")
            showAlertOnWindow(title: "", message: "Infants Count not mor than 9", titles: ["OK"], completionHanlder: nil)
        }else if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else  {
            if cell.count >= 0 {
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            if cell.titlelbl.text == "Adults" {
                adultsCount = cell.count
            }else if cell.titlelbl.text == "Child"{
                childCount = cell.count
            }else {
                infantsCount = cell.count
            }
        }
        
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        
        if cell.count > 0 {
            cell.count -= 1
        }
        print(cell.count)
        
        if cell.titlelbl.text == "Adults" {
            if cell.count == 0 {
                cell.count = 1
            }
            adultsCount = cell.count
            deleteRecords(title: "Adult", index: cell.count)
        }else if cell.titlelbl.text == "Child"{
            childCount = cell.count
            deleteRecords(title: "Child", index: cell.count)
        }else {
            infantsCount = cell.count
            deleteRecords(title: "Infantas", index: cell.count)
        }
        
        
        if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else {
            cell.countlbl.text = "\(cell.count)"
            
        }
        
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    
    func gotoBookFlightVC() {
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
                
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            }else if journeyType == "circle" {
                
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy")"
                
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
            }else{
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Economy")"
                
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
            }
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                
            }else if journeyType == "circle" {
                defaults.set(adultsCount, forKey: UserDefaultsKeys.radultCount)
                defaults.set(childCount, forKey: UserDefaultsKeys.rchildCount)
                defaults.set(infantsCount, forKey: UserDefaultsKeys.rinfantsCount)
            }else {
                defaults.set(adultsCount, forKey: UserDefaultsKeys.madultCount)
                defaults.set(childCount, forKey: UserDefaultsKeys.mchildCount)
                defaults.set(infantsCount, forKey: UserDefaultsKeys.minfantsCount)
            }
        }
        
        gotoBookFlightVC()
        
    }
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(title:String,index:Int) {
        
        print("DELETING COREDATA OBJECT")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "title = %@", "\(title)")
        request.returnsObjectsAsFaults = false
        
        do {
            let objects = try context.fetch(request)
            
            if title == "Adult" {
                if objects.count > 0 && objects.count > adultsCount {
                    context.delete(objects[index] as! NSManagedObject)
                }
            }else if title == "Child" {
                if objects.count > 0 && objects.count > childCount {
                    context.delete(objects[index] as! NSManagedObject)
                }
            }else {
                if objects.count > 0 && objects.count > infantsCount {
                    context.delete(objects[index] as! NSManagedObject)
                }
            }
            
            
            
        } catch {
            print ("There was an error")
        }
        
        
        do {
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
    
    
}


