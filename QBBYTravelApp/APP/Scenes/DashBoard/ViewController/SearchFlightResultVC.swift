//
//  SearchFlightResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var flightsFoundlbl: UILabel!
    @IBOutlet weak var filterTapView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterTapBtn: UIButton!
    @IBOutlet weak var noofstopscv: UICollectionView!
    @IBOutlet weak var citycodeslbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    
    
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    let dateFormatter = DateFormatter()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewmodel:OnewayViewModel?
    var isvcfrom = String()
    var finalInputArray = [[String:Any]]()
    var noofStopsArray = ["Non Stop","1 Stop","1+ Stop"]
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    @objc func backvc() {
        callapibool = false
        holderView.isHidden = false
        self.isvcfrom = "flightinfo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewmodel = OnewayViewModel(self)
    }
    
    
    
    
    func setupUI() {
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.isHidden = false
        
        
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
    
    
    override func didTapOnRefunduableBtn(cell: SearchFlightResultInfoTVCell) {
        print("didTapOnRefunduableBtn")
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
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        TimerManager.shared.sessionStop()
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func didTaponModifySearchBtnAction(_ sender: Any) {
        gotoModifyFlightSearchVC()
    }
    
    func gotoModifyFlightSearchVC() {
        guard let vc = ModifyFlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
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



extension SearchFlightResultVC:OnewayViewModelDelegate {
    
    
    
    func callAPI() {
        viewmodel?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
    }
    
    
    
    func multicityFlightList(response: MulticityModel) {
        
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
        
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900)
        
        
        flightsFoundlbl.text = "\(response.data?.j_flight_list?.count ?? 0) Flights found"
        
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
        
        holderView.isHidden = false
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
    
        oneWayFlights = response.data?.j_flight_list ?? [[]]
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900)
        
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        switch journyType {
            
        case "oneway":
            
            
            defaults.set("\(convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))", forKey: UserDefaultsKeys.journyDates)
            
            defaults.set("\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? "")", forKey: UserDefaultsKeys.journyCitys)
            
            
            
           // setupRoundTripTVCells(jfl: response.data?.j_flight_list ?? [[]])
            appendValuesafterFilterApply(jfl: response.data?.j_flight_list ?? [[]])

            
            break
            
        case "circle":
            
            defaults.set("\(convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM")) - \(convertDateFormat(inputDate: response.data?.search_params?.freturn ?? "", f1: "dd-MM-yyyy", f2: "EEE, dd MMM"))", forKey: UserDefaultsKeys.journyDates)
            
            defaults.set("\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? "") & \(response.data?.search_params?.to_loc ?? "") - \(response.data?.search_params?.from_loc ?? "")", forKey: UserDefaultsKeys.journyCitys)
            
            
           // setupRoundTripTVCells(jfl: response.data?.j_flight_list ?? [[]])
            appendValuesafterFilterApply(jfl: response.data?.j_flight_list ?? [[]])
            break
            
        default:
            break
        }
        
        
        
        self.citycodeslbl.text = defaults.string(forKey: UserDefaultsKeys.journyCitys) ?? ""
        self.dateslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journyDates) ?? ""), \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")"
        
    }
    
    
    
    
    
    func setupRoundTripTVCells(jfl:[[J_flight_list]]) {
        
        commonTableView.separatorStyle = .none
        flightsFoundlbl.text = "\(jfl.count) Flights found"
        TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        
        
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
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
    }
    
    
    // Create a function to check if a given time string is within a time range
    func isTimeInRange(time: String, range: String) -> Bool {
        guard let departureDate = dateFormatter.date(from: time) else {
            return false
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: departureDate)
        
        switch range {
        case "12 am - 6 am":
            return hour >= 0 && hour < 6
        case "06 am - 12 pm":
            return hour >= 6 && hour < 12
        case "12 pm - 06 pm":
            return hour >= 12 && hour < 18
        case "06 pm - 12 am":
            return hour >= 18 && hour < 24
        default:
            return false
        }
    }
    
    
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
        
        //        print("====minpricerange ==== \(minpricerange)")
        //        print("====maxpricerange ==== \(maxpricerange)")
        //        print("==== noofstopsFA ==== \(noofstopsFA)")
        //        print("==== departureTimeFilter ==== \(departureTimeFilter)")
        //        print("==== arrivalTimeFilter ==== \(arrivalTimeFilter)")
        //        print("==== airlinesFA ==== \(airlinesFA)")
        //        print("==== cancellationTypeFA ==== \(cancellationTypeFA)")
        //        print("==== connectingFlightsFA ==== \(connectingFlightsFA)")
        //        print("==== connectingAirportsFA ==== \(connectingAirportsFA)")
        
        
            
            let sortedArray = oneWayFlights.filter { flightList in
                
                guard let details = flightList.first?.flight_details?.details else { return false }
                //                guard let sum = flightList.first?.flight_details?.summary else { return false }
                //                guard let totaldisplayfare = flightList.first?.price?.api_total_display_fare else { return false }
                
                
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
                
                
                
                let connectingFlightsMatch = flightList.contains { flight in
                    if connectingFlightsFA.isEmpty {
                        return true // Return true for all flights if 'connectingAirportsFA' is empty
                    }
                    
                    
                    for summaryArray in details {
                        if summaryArray.contains(where: { flightDetail in
                            let operatorname = flightDetail.operator_name ?? ""
                            let loc = flightDetail.operator_code ?? ""
                            return connectingFlightsFA.contains("\(operatorname) (\(loc))")
                        }) {
                            return true // Return true for this flight if it contains a matching airport
                        }
                    }
                    
                    
                    return false // Return false if no matching airport is found in this flight
                }
                
                
                
                let connectingAirportsMatch = flightList.contains { flight in
                    if connectingAirportsFA.isEmpty {
                        return true // Return true for all flights if 'connectingAirportsFA' is empty
                    }
                    
                    // Check if 'details' is available and contains the specified airports
                    
                    for summaryArray in details {
                        if summaryArray.contains(where: { flightDetail in
                            let airportName = flightDetail.destination?.city ?? ""
                            let airportloc = flightDetail.destination?.loc ?? ""
                            return connectingAirportsFA.contains("\(airportName) (\(airportloc))")
                        }) {
                            return true // Return true for this flight if it contains a matching airport
                        }
                    }
                    
                    
                    return false // Return false if no matching airport is found in this flight
                }
                
                
                
                let depMatch = departureTimeFilter.isEmpty || flightList.contains { flight in
                    if let departureDateTime = flight.flight_details?.summary?.first?.origin?.time {
                        return departureTimeFilter.contains { departureTime in
                            return isTimeInRange(time: departureDateTime, range: departureTime)
                        }
                    }
                    return false
                }
                
                let arrMatch = arrivalTimeFilter.isEmpty || flightList.contains { flight in
                    if let arrivalDateTime = flight.flight_details?.summary?.first?.destination?.time {
                        return arrivalTimeFilter.contains { arrivalTime in
                            return isTimeInRange(time: arrivalDateTime, range: arrivalTime)
                        }
                    }
                    return false
                }
                
                
                
                
                
                // Check if the total price is within the specified range
                return totalPrice >= minpricerange && totalPrice <= maxpricerange && noOfStopsMatch && airlinesMatch && refundableMatch && connectingFlightsMatch && connectingAirportsMatch && depMatch && arrMatch
            }
            
            
            setupRoundTripTVCells(jfl: sortedArray)
            
       
        
    }
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
        case .PriceLow:
            let sortedArray = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0) { $0 + (Double($1.totalPrice ?? "0") ?? 0) }
                let totalPrice2 = flights2.reduce(0) { $0 + (Double($1.totalPrice ?? "0") ?? 0) }
                return totalPrice1 < totalPrice2
            }
            
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .PriceHigh:
            let sortedArray = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0) { $0 + (Double($1.totalPrice ?? "0") ?? 0) }
                let totalPrice2 = flights2.reduce(0) { $0 + (Double($1.totalPrice ?? "0") ?? 0) }
                return totalPrice1 > totalPrice2
            }
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
            
        case .DepartureLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 < time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .DepartureHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
            
        case .ArrivalLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 < time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .ArrivalHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
            
            
        case .DurationLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 < durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .DurationHigh:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 > durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
        case .airlineaz:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 < operatorCode2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .airlineza:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 > operatorCode2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
        case .nothing:
            setupRoundTripTVCells(jfl: oneWayFlights)
            break
            
        default:
            break
        }
        
        
    }
    
    
    
}


extension SearchFlightResultVC {
    
    //MARK: - appendValuesafterFilterApply
    func appendValuesafterFilterApply(jfl:[[J_flight_list]]) {
        
        prices.removeAll()
        noofStopsA.removeAll()
        fareTypeA.removeAll()
        airlinesA.removeAll()
        connectingFlightsA.removeAll()
        connectingAirportA.removeAll()
        
        
        jfl.forEach { i in
            i.forEach { j in
                prices.append("\(j.price?.api_total_display_fare ?? 0.0)")
                fareTypeA.append(j.fareType ?? "")
                j.flight_details?.summary?.forEach({ k in
                    
                    airlinesA.append(k.operator_name ?? "")
                    
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
        
        
        jfl.forEach { i in
            i.forEach { j in
                
                j.flight_details?.details?.forEach({ i in
                    i.forEach { j in
                        
                        connectingFlightsA.append("\(j.operator_name ?? "") (\(j.operator_code ?? ""))")
                        connectingAirportA.append("\( j.destination?.city ?? "") (\(j.destination?.loc ?? ""))")
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
        
        
        setupRoundTripTVCells(jfl: jfl)
    }
}



extension SearchFlightResultVC {
    
    func addObserver() {
        
        TimerManager.shared.delegate = self
        dateFormatter.dateFormat = "HH:mm"
        if callapibool == true {
            DispatchQueue.main.async {[self] in
                TimerManager.shared.sessionStop()
                holderView.isHidden = true
                callAPI()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimer), name: NSNotification.Name("reloadTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointernetreload), name: NSNotification.Name("nointernetreload"), object: nil)
        
    }
    
    
    @objc func nointernetreload(){
        
        DispatchQueue.main.async {[self] in
            TimerManager.shared.sessionStop()
            callapibool = false
            callAPI()
        }
        
    }
    
    @objc func reloadTimer(){
        DispatchQueue.main.async {
            TimerManager.shared.delegate = self
        }
    }
    
    
    @objc func reload(){
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    
    func gotoNoInternetConnectionVC(key:String,titleStr:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        vc.key = titleStr
        self.present(vc, animated: false)
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        DispatchQueue.main.async {[self] in
            let totalTime = TimerManager.shared.totalTime
            let minutes =  totalTime / 60
            let seconds = totalTime % 60
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            sessonlbl.text = "Your Session Expires In: \(formattedTime)"
        }
    }
    
    
}


