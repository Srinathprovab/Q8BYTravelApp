//
//  SearchFlightResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var flightsFoundlbl: UILabel!
    @IBOutlet weak var filterTapView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterTapBtn: UIButton!
    @IBOutlet weak var noofstopscv: UICollectionView!
    
    
    
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewmodel:OnewayViewModel?
    var isvcfrom = String()
    var finalInputArray = [[String:Any]]()
    let refreshControl = UIRefreshControl()
    var noofStopsArray = ["Non Stop","1 Stop","1+ Stop"]
    
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if callapibool == true {
            DispatchQueue.main.async {[self] in
                holderView.isHidden = true
                callAPI()
            }
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatetimer), name: NSNotification.Name("updatetimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sessionStop"), object: nil)
    }
    
    
    @objc func stopTimer() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @objc func updatetimer(notificatio:UNNotification) {
        
        var totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In: \(formattedTime)",
                    textcolor: .AppLabelColor,
                    font: .OpenSansRegular(size: 12),
                    align: .left)
    }
    
    
    @objc func backvc() {
        callapibool = false
        holderView.isHidden = false
        self.isvcfrom = "flightinfo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = OnewayViewModel(self)
    }
    
    
    
    
    
    func callAPI() {
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        switch journyType {
        case "oneway":
            
            viewmodel?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
            
            break
            
        case "circle":
            
            viewmodel?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
            break
            
        case "multicity":
            
            do {
                let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
                print(theJSONText ?? "")
                
                payload1["search_params"] = theJSONText
                payload1["user_id"] = "0"
                
                viewmodel?.CALL_GET_MULTICITY_FLIGHT_LIST_API(dictParam: payload1)
                
            }catch let error as NSError{
                print(error.description)
            }
            
            
            
            break
        default:
            break
        }
        
    }
    
    
    func setupUI() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        commonTableView.addSubview(refreshControl)
        navHeight.constant = 174
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.isHidden = false
        
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        
        
        nav.filterView.isHidden = true
        nav.editView.isHidden = false
        nav.editView.backgroundColor = HexColor("#FFB000")
        nav.editBtn.addTarget(self, action: #selector(didTapOnEditSearchFlight(_:)), for: .touchUpInside)
        nav.holderview.backgroundColor = .WhiteColor
        
        setuplabels(lbl: nav.titlelbl, text: defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        setuplabels(lbl: nav.citylbl, text: "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        
        filterTapBtn.setTitle("", for: .normal)
        filterTapBtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        
        setupCV()
        sessonlbl.isHidden = false
        flightsFoundlbl.isHidden = false
        commonTableView.registerTVCells(["SearchFlightResultInfoTVCell",
                                         "EmptyTVCell",
                                         "RoundTripDetailsTVcell",
                                         "RoundTripTVcell"])
        commonTableView.separatorStyle = .none
        
    }
    
    @objc func refresh() {
        
        noofstopscv.reloadData()
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                setupTVCells(jfl: oneWayFlights)
            }else {
                setupRoundTripTVCells(jfl: oneWayFlights)
            }
        }
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            refreshControl.endRefreshing()
        }
    }
    
    
    
    @objc func didTapOnSortBtnAction(_ sender:UIButton){
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.filterTapKey = "sort"
        vc.delegate = self
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton){
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.filterTapKey = "sort"
        vc.delegate = self
        self.present(vc, animated: false)
    }
    
    
    
    
    @objc func gotoBackScreen() {
        callapibool = false
        TimerManager.shared.sessionStop()
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnRefunduableBtn(cell: SearchFlightResultInfoTVCell) {
        print("didTapOnRefunduableBtn")
    }
    
    
    @objc func didTapOnEditSearchFlight(_ sender:UIButton) {
        guard let vc = ModifyFlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    func goToFlightInfoVC() {
        guard let vc = SelectedFlightInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    override func didTaponRoundTripCell(cell: RoundTripTVcell) {
        accesskey = cell.access_key1
        goToFlightInfoVC()
    }
    
    
    override func didTaponRoundTripCell(cell: RoundTripDetailsTVcell) {
        accesskey = cell.access_key1
        goToFlightInfoVC()
    }
    
}


extension SearchFlightResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultInfoTVCell {
            accesskey = cell.access_key1
            goToFlightInfoVC()
        }
    }
}



extension SearchFlightResultVC:OnewayViewModelDelegate {
    
    
    func multicityFlightList(response: MulticityModel) {
        
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
        TimerManager.shared.totalTime = response.session_expiry_details?.session_start_time ?? 0
        TimerManager.shared.startTimer()
        
        setuplabels(lbl: flightsFoundlbl, text: "\(response.data?.j_flight_list?.count ?? 0) Flights found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .right)
        
        //        defaults.set("\(response.data?.search_params?.depature?.joined(separator: ","))", forKey: UserDefaultsKeys.journyDates)
        //
        //        defaults.set("\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? "")", forKey: UserDefaultsKeys.journyCitys)
        
        
        
        response.data?.j_flight_list?.forEach { j in
            prices.append(j.totalPrice ?? "")
            fareTypeA.append(j.fareType ?? "")
            j.flight_details?.summary?.forEach({ k in
                
                airlinesA.append(k.operator_name ?? "")
                connectingFlightsA.append(k.destination?.loc ?? "")
                connectingAirportA.append(k.origin?.airport_name ?? "")
                
                switch k.no_of_stops {
                case 0:
                    noofStopsA.append("0 Stop")
                    break
                case 1:
                    noofStopsA.append("1 Stop")
                    break
                case 2:
                    noofStopsA.append("1+ Stop")
                    break
                default:
                    break
                }
            })
        }
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
        
        defaults.set(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "", forKey: UserDefaultsKeys.travellerDetails)
        setupMulticityTVCells(jfl: response.data?.j_flight_list ?? [])
        setupUI()
    }
    
    
    
    func onewayFlightList(response: OnewayModel) {
        
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
        holderView.isHidden = false
        
        setuplabels(lbl: flightsFoundlbl, text: "\(response.data?.j_flight_list?.count ?? 0) Flights found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .right)
        
        
        oneWayFlights = response.data?.j_flight_list ?? [[]]
        oneWayFlights.forEach { i in
            i.forEach { j in
                prices.append(j.totalPrice ?? "")
                fareTypeA.append(j.fareType ?? "")
                j.flight_details?.summary?.forEach({ k in
                    
                    airlinesA.append(k.operator_name ?? "")
                    connectingFlightsA.append(k.destination?.loc ?? "")
                    connectingAirportA.append(k.origin?.airport_name ?? "")
                    
                    switch k.no_of_stops {
                    case 0:
                        noofStopsA.append("0 Stop")
                        break
                    case 1:
                        noofStopsA.append("1 Stop")
                        break
                    case 2:
                        noofStopsA.append("1+ Stop")
                        break
                    default:
                        break
                    }
                })
            }
        }
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
        
        TimerManager.shared.totalTime = response.session_expiry_details?.session_start_time ?? 0
        TimerManager.shared.startTimer()
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In: 14:15", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        switch journyType {
            
        case "oneway":
            
            
            defaults.set("\(convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))", forKey: UserDefaultsKeys.journyDates)
            
            defaults.set("\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? "")", forKey: UserDefaultsKeys.journyCitys)
            
            
            defaults.set(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "", forKey: UserDefaultsKeys.travellerDetails)
            
            
            //setupTVCells(jfl: response.data?.j_flight_list ?? [[]])
            setupRoundTripTVCells(jfl: response.data?.j_flight_list ?? [[]])
            
            
            setupUI()
            break
            
        case "circle":
            
            defaults.set("\(convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(convertDateFormat(inputDate: response.data?.search_params?.freturn ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))", forKey: UserDefaultsKeys.journyDates)
            
            defaults.set("\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? "") & \(response.data?.search_params?.to_loc ?? "") - \(response.data?.search_params?.from_loc ?? "")", forKey: UserDefaultsKeys.journyCitys)
            
            
            defaults.set(response.data?.search_params?.from_loc ?? "", forKey: UserDefaultsKeys.travellerDetails)
            setupRoundTripTVCells(jfl: response.data?.j_flight_list ?? [[]])
            
            setupUI()
            break
            
        default:
            break
        }
    }
    
    
    func setupTVCells(jfl:[[J_flight_list]]) {
        tablerow.removeAll()
        
        jfl.forEach { i in
            i.forEach { j in
                j.flight_details?.summary?.forEach({ k in
                    
                    
                    tablerow.append(TableRow(title:j.access_key,
                                             fromTime: k.origin?.time,
                                             toTime:k.destination?.time,
                                             fromCity: k.origin?.city,
                                             toCity: k.destination?.city,
                                             noosStops: "\(k.no_of_stops ?? 0) Stops",
                                             airlineslogo: k.operator_image,
                                             airlinesCode:"(\(k.operator_code ?? "")-\(k.operator_name ?? ""))",
                                             kwdprice:j.totalPrice_API,
                                             refundable:j.fareType,
                                             travelTime: k.duration,
                                             cellType:.SearchFlightResultInfoTVCell))
                    
                })
            }
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    
    func setupRoundTripTVCells(jfl:[[J_flight_list]]) {
        commonTableView.separatorStyle = .none
        
        tablerow.removeAll()
        
        jfl.forEach { i in
            i.forEach { j in
                tablerow.append(TableRow(title:j.access_key,kwdprice:j.totalPrice_API,refundable:j.fareType,moreData: j.flight_details?.summary, cellType:.RoundTripTVcell))
            }
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
    
    func setupMulticityTVCells(jfl:[MJ_flight_list]) {
        commonTableView.separatorStyle = .none
        
        tablerow.removeAll()
        
        
        jfl.forEach { j in
            tablerow.append(TableRow(title:j.access_key,
                                     kwdprice:j.totalPrice_API,
                                     refundable:j.fareType,
                                     moreData: j.flight_details?.summary,
                                     cellType:.RoundTripTVcell))
        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
}


extension SearchFlightResultVC:AppliedFilters {
    
    
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print("==== noofstopsFA ==== \(noofstopsFA)")
        print("==== departureTimeFilter ==== \(departureTimeFilter)")
        print("==== arrivalTimeFilter ==== \(arrivalTimeFilter)")
        print("==== airlinesFA ==== \(airlinesFA)")
        print("==== cancellationTypeFA ==== \(cancellationTypeFA)")
        print("==== connectingFlightsFA ==== \(connectingFlightsFA)")
        print("==== connectingAirportsFA ==== \(connectingAirportsFA)")
        
        let sortedArray = oneWayFlights.filter { flightList in
            
            
            
            // Calculate the total price for each flight in the flight list
            let totalPrice = flightList.reduce(0.0) { result, flight in
                result + (Double(flight.totalPrice ?? "") ?? 0.0)
            }
            
            // Check if the flight list has at least one flight with the specified number of stops
            let noOfStopsMatch = noofstopsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { noofstopsFA.contains("\($0.no_of_stops ?? 0)") }) ?? false })
            
            // Check if the flight list has at least one flight with the specified airline
            let airlinesMatch = airlinesFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { airlinesFA.contains($0.operator_name ?? "") }) ?? false })
            
            // Check if the flight list has at least one flight with the specified cancellation type
            let refundableMatch = cancellationTypeFA.isEmpty || flightList.contains(where: { $0.fareType == cancellationTypeFA.first })
            
            // Check if the flight list has at least one flight with the specified connecting flights
            let connectingFlightsMatch = connectingFlightsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { connectingFlightsFA.contains($0.destination?.loc ?? "") }) ?? false })
            
            // Check if the flight list has at least one flight with the specified connecting airports
            let connectingAirportsMatch = connectingAirportsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { $0.destination?.airport_name == connectingAirportsFA.first }) ?? false })
            
            
            
            
            
            // Check if the total price is within the specified range
            return totalPrice >= minpricerange && totalPrice <= maxpricerange && noOfStopsMatch && airlinesMatch && refundableMatch && connectingFlightsMatch && connectingAirportsMatch
        }
        
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                setupTVCells(jfl: sortedArray)
            }else {
                setupRoundTripTVCells(jfl: sortedArray)
            }
        }
    }
    
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
        case .PriceLow:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let totalPrice1 = j1.first?.totalPrice ?? "0"
                        let totalPrice2 = j2.first?.totalPrice ?? "0"
                        return totalPrice1 < totalPrice2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let totalPrice1 = j1.first?.totalPrice ?? "0"
                        let totalPrice2 = j2.first?.totalPrice ?? "0"
                        return totalPrice1 < totalPrice2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
        case .PriceHigh:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let totalPrice1 = j1.first?.totalPrice ?? "0"
                        let totalPrice2 = j2.first?.totalPrice ?? "0"
                        return totalPrice1 > totalPrice2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let totalPrice1 = j1.first?.totalPrice ?? "0"
                        let totalPrice2 = j2.first?.totalPrice ?? "0"
                        return totalPrice1 > totalPrice2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
            
            
        case .DepartureLow:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        return time1 < time2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        return time1 < time2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
        case .DepartureHigh:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        return time1 > time2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.destination?.datetime ?? "0"
                        return time1 > time2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
            
            
        case .ArrivalLow:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        return time1 < time2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        return time1 < time2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
        case .ArrivalHigh:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        return time1 > time2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let time1 = j1.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        let time2 = j2.first?.flight_details?.summary?.first?.origin?.datetime ?? "0"
                        return time1 > time2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
            
            
            
        case .DurationLow:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        return durationseconds1 < durationseconds2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        return durationseconds1 < durationseconds2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            
            break
            
        case .DurationHigh:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        return durationseconds1 > durationseconds2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                        return durationseconds1 > durationseconds2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
            
        case .airlineaz:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                        let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                        return operatorCode1 < operatorCode2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                        let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                        return operatorCode1 < operatorCode2
                    })
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
        case .airlineza:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                        let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                        return operatorCode1 > operatorCode2
                    })
                    
                    setupTVCells(jfl: sortedArray)
                    
                    
                }else {
                    let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                        let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                        let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                        return operatorCode1 > operatorCode2
                    })
                    
                    
                    setupRoundTripTVCells(jfl: sortedArray)
                    
                }
            }
            break
            
            
        case .nothing:
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journyType == "oneway" {
                setupTVCells(jfl: oneWayFlights)
            }else {
                setupRoundTripTVCells(jfl: oneWayFlights)
            }
            break
            
            
            
        default:
            break
        }
        
        
        DispatchQueue.main.async {[self] in
            commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    
    
}



extension SearchFlightResultVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        let nib = UINib(nibName: "ItineraryCVCell", bundle: nil)
        noofstopscv.register(nib, forCellWithReuseIdentifier: "cell")
        noofstopscv.delegate = self
        noofstopscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 40)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
        noofstopscv.collectionViewLayout = layout
        noofstopscv.backgroundColor = .clear
        noofstopscv.showsVerticalScrollIndicator = false
        noofstopscv.isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noofStopsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItineraryCVCell {
            cell.setupNoofStopsView()
            cell.titlelbl.text = noofStopsArray[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.viewselected()
            
            switch cell.titlelbl.text {
            case "Non Stop":
                noofStopsFilter(stops: 0)
                break
                
            case "1 Stop":
                noofStopsFilter(stops: 1)
                break
                
            case "1+ Stop":
                noofStopsFilter(stops: 2)
                break
                
                
            default:
                break
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.viewunselected()
        }
    }
    
    
    
    func noofStopsFilter(stops:Int) {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                let sortedArray = oneWayFlights.compactMap { i -> [J_flight_list]? in
                    i.compactMap { j -> J_flight_list? in
                        guard let summary = j.flight_details?.summary else { return nil }
                        let filteredSummary = summary.filter { $0.no_of_stops == stops }
                        return filteredSummary.isEmpty ? nil : j
                    }
                }
                
                setupTVCells(jfl: sortedArray)
            }else {
                
                
                
                let sortedArray = oneWayFlights.filter { flightList in
                    let noOfStopsMatch = String(stops).isEmpty || flightList.contains { flight in
                        return flight.flight_details?.summary?.contains { summary in
                            return String(stops) == "\(summary.no_of_stops ?? 0)"
                        } ?? false
                    }
                    return noOfStopsMatch
                }
                
                setupRoundTripTVCells(jfl: sortedArray)
                
                
                
            }
        }
        
    }
    
}
