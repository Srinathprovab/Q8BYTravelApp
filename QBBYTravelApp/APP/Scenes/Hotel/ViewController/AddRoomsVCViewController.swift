//
//  AddRoomsVCViewController.swift
//  BabSafar
//
//  Created by FCI on 10/04/23.
//

import UIKit

class AddRoomsVCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RoomsCountTVCellDelegate, ButtonTVCellDelegate {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var tv: UITableView!
    
    var totalRooms = Int()
    var totalAdults = Int()
    var totalChildren = Int()
    static var newInstance: AddRoomsVCViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddRoomsVCViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        //  self.view.backgroundColor = .black.withAlphaComponent(0.4)
        nav.navtitle.isHidden = false
        setuplabels(lbl: nav.navtitle, text: "Select Adults, Rooms", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .left)
        nav.backBtn.addTarget(self, action: #selector(closeBtnAction(_:)), for: .touchUpInside)
        
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "RoomsCountTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        tv.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        tv.separatorStyle = .none
    }
    
    @objc func closeBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    func didTapOnAddRoomBtnAction(cell: RoomsCountTVCell) {
        tv.reloadData()
    }
    
    func didTapOnAddRoomBtnAction(cell: ButtonTVCell) {
        
    }
    
    
    
    func didTapOnCloseRoom(cell: RoomsCountTVCell) {
        tv.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoomsCountTVCell {
                cell.delegate = self
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? ButtonTVCell {
                cell.delegate = self
                cell.titlelbl.text = "Done"
                cell.btnView.backgroundColor = .AppBackgroundColor
                ccell = cell
            }
        }
        return ccell
    }
    
    
    //MARK: -Room1 ========
    func adultsIncrementButtonAction(cell: RoomsCountTVCell) {
        
        if cell.adultcount >= 1 &&  cell.adultcount < 4{
            cell.adultcount += 1
            cell.adultsCountlbl1.text = "\(cell.adultcount)"
            
        }else {
            showToast(message: "Adults Not More Than 4")
        }
        
    }
    
    func adultsDecrementBtnAction(cell: RoomsCountTVCell) {
        
        if cell.adultcount > 1 {
            cell.adultcount -= 1
            cell.adultsCountlbl1.text = "\(cell.adultcount)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction(cell: RoomsCountTVCell) {
        if cell.childCount >= 0 &&  cell.childCount < 2{
            cell.childCount += 1
            cell.childrenCountlbl1.text = "\(cell.childCount)"
            
            if cell.childCount == 1 {
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = true
                cell.room1childagevalue1lbl.text = "0"
            }else {
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.room1childagevalue2lbl.text = "0"
            }
            
        }else {
            showToast(message: "Childerns Not More Than 2")
        }
        
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction(cell: RoomsCountTVCell) {
        if cell.childCount > 0 {
            cell.childCount -= 1
            cell.childrenCountlbl1.text = "\(cell.childCount)"
            if cell.childCount == 0 {
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = true
                cell.childage2View.isHidden = true
            }else{
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = true
            }
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    
    
    //MARK: -Room2 ========
    
    func adultsIncrementButtonAction2(cell: RoomsCountTVCell) {
        
        if cell.adultcount2 >= 1 &&  cell.adultcount2 < 4{
            cell.adultcount2 += 1
            cell.adultsCountlbl2.text = "\(cell.adultcount2)"
            
        }else {
            showToast(message: "Adults Not More Than 4")
        }
        tv.reloadData()
        
        
    }
    
    func adultsDecrementBtnAction2(cell: RoomsCountTVCell) {
        
        if cell.adultcount2 > 1 {
            cell.adultcount2 -= 1
            cell.adultsCountlbl2.text = "\(cell.adultcount2)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction2(cell: RoomsCountTVCell) {
        if cell.childCount2 >= 0 &&  cell.childCount2 < 2{
            cell.childCount2 += 1
            cell.childrenCountlbl2.text = "\(cell.childCount2)"
            
            
            if cell.childCount2 == 1 {
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = true
                cell.room2childagevalue1lbl.text = "0"
            }else {
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childagevalue2lbl.text = "0"
            }
            
        }else {
            showToast(message: "Childerns Not More Than 2")
        }
        
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction2(cell: RoomsCountTVCell) {
        if cell.childCount2 > 0 {
            cell.childCount2 -= 1
            cell.childrenCountlbl2.text = "\(cell.childCount2)"
            
            if cell.childCount2 == 0 {
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = true
                cell.r2childage2View.isHidden = true
            }else{
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = true
            }
            
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    
    //MARK: -Room3 ========
    func adultsIncrementButtonAction3(cell: RoomsCountTVCell) {
        
        if cell.adultcount3 >= 1 &&  cell.adultcount3 < 4{
            cell.adultcount3 += 1
            cell.adultsCountlbl3.text = "\(cell.adultcount3)"
            
        }else {
            showToast(message: "Adults Not More Than 4")
        }
        tv.reloadData()
        
        
    }
    
    func adultsDecrementBtnAction3(cell: RoomsCountTVCell) {
        
        if cell.adultcount3 > 1 {
            cell.adultcount3 -= 1
            cell.adultsCountlbl3.text = "\(cell.adultcount3)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction3(cell: RoomsCountTVCell) {
        if cell.childCount3 >= 0 &&  cell.childCount3 < 2{
            cell.childCount3 += 1
            cell.childrenCountlbl3.text = "\(cell.childCount3)"
            
            if cell.childCount3 == 1 {
                cell.room3Height.constant = 250
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = true
                cell.room3childagevalue1lbl.text = "0"
            }else {
                cell.room3Height.constant = 250
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childagevalue2lbl.text = "0"
            }
            
        }else {
            showToast(message: "Childerns Not More Than 2")
        }
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction3(cell: RoomsCountTVCell) {
        if cell.childCount3 > 0 {
            cell.childCount3 -= 1
            cell.childrenCountlbl3.text = "\(cell.childCount3)"
            
            if cell.childCount3 == 0 {
                cell.room3Height.constant = 250
                cell.r3childage1View.isHidden = true
                cell.r3childage2View.isHidden = true
            }else{
                cell.room3Height.constant = 250
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = true
            }
            
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    
    
    //MARK: -
    func btnAction(cell: ButtonTVCell) {
        if let cell = tv.cellForRow(at: IndexPath(item: 0, section: 0)) as? RoomsCountTVCell {
            adtArray.removeAll()
            chArray.removeAll()
            totalRooms = cell.roomCount
            totalAdults = (cell.adultcount + cell.adultcount2)
            switch totalRooms {
            case 1:
                totalAdults = (cell.adultcount)
                totalChildren = (cell.childCount)
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                break
                
            case 2:
                totalAdults = (cell.adultcount + cell.adultcount2)
                totalChildren = (cell.childCount + cell.childCount2)
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                adtArray.append("\(cell.adultcount2)")
                chArray.append("\(cell.childCount2)")
                
                
                break
                
            case 3:
                totalAdults = (cell.adultcount + cell.adultcount2 + cell.adultcount3)
                totalChildren = (cell.childCount + cell.childCount2 + cell.childCount3)
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                adtArray.append("\(cell.adultcount2)")
                chArray.append("\(cell.childCount2)")
                
                adtArray.append("\(cell.adultcount3)")
                chArray.append("\(cell.childCount3)")
                
                break
                
                
            default:
                break
            }
        }
        
        print("totalRooms ==== \(totalRooms)")
        print("totalAdults ==== \(totalAdults)")
        print("totalChildren ==== \(totalChildren)")
        
        defaults.set(totalRooms, forKey: UserDefaultsKeys.roomcount)
        defaults.set(totalAdults, forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set(totalChildren, forKey: UserDefaultsKeys.hotelchildcount)
        defaults.set((totalAdults + totalChildren), forKey: UserDefaultsKeys.guestcount)
        
        defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Childreen", forKey: UserDefaultsKeys.selectPersons)
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    func didTapOnDualBtn1(cell: ButtonTVCell) {
        
    }
    
    func didTapOnDualBtn2(cell: ButtonTVCell) {
        
    }
    
    func adultsIncrementButtonAction4(cell: RoomsCountTVCell) {
        
    }
    
    func adultsDecrementBtnAction4(cell: RoomsCountTVCell) {
        
    }
    
    func childrenIncrementButtonAction4(cell: RoomsCountTVCell) {
        
    }
    
    func childrenDecrementBtnAction4(cell: RoomsCountTVCell) {
        
    }
    
}
