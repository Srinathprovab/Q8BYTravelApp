//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedVC: BaseTableVC, VocherDetailsViewModelDelegate {
    
    
    var urlString = String()
    var tablerow = [TableRow]()
    var vbookingsource = String()
    var vbookingStatus = String()
    var vfaretype = String()
    var vbookingReference = String()
    var titleString = String()
    var vm:VocherDetailsViewModel?
    var pnrdetails :Get_airline_pnr?
    var bookingId = String()
    var customerDetails = [Customer_details]()
    var flightsDetailsSummery = [Summary]()
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.BookingConfirm.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
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
        
        callApi()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    //MARK: - Call_Get_voucher_Details_API
    
    func callApi(){
        BASE_URL = ""
        vm?.Call_Get_voucher_Details_API(dictParam: [:], url: urlString)
    }
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        pnrdetails = response.get_airline_pnr
        bookingId = response.data?.booking_details?[0].booked_by_id ?? ""
        vbookingsource = response.data?.booking_details?[0].booking_source ?? ""
        vbookingReference = response.data?.booking_details?[0].app_reference ?? ""
        vbookingStatus = response.data?.booking_details?[0].booking_transaction_details?[0].status ?? ""
        vfaretype = response.flight_details?.fareType ?? ""
        customerDetails = response.data?.booking_details?[0].customer_details ?? []
        flightsDetailsSummery = response.flight_details?.summary ?? []
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = VocherDetailsViewModel(self)
    }
    
    func setupUI() {
        commonTableView.registerTVCells(["BookingConfTVCell",
                                         "VoucherFDTVCell",
                                         "EmptyTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "DownloadTicketTVCell"])
        
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Booking ID : \(bookingId)",
                                 subTitle: "PNR NO:\(pnrdetails?.airline_pnr ?? "")",
                                 cellType:.BookingConfTVCell))
        
        
        
        
        if flightsDetailsSummery.count != 0 {
            
            
            flightsDetailsSummery.forEach { k in
                tablerow.append(TableRow(title:k.origin?.airport_name,
                                         subTitle: k.origin?.terminal,
                                         fromTime: k.origin?.time,
                                         toTime:k.destination?.time,
                                         fromCity: k.origin?.loc,
                                         toCity: k.destination?.loc,
                                         fromdate: k.origin?.date ?? "",
                                         todate: k.destination?.date ?? "",
                                         airlineslogo: k.operator_image,
                                         airlinesCode:"\(k.operator_code ?? "")-\(k.flight_number ?? "")",
                                         refundable:vfaretype,
                                         travelTime: k.duration,
                                         text: k.cabin_class,
                                         buttonTitle: k.destination?.airport_name,
                                         tempText: k.destination?.terminal,
                                         cellType:.VoucherFDTVCell))
                
                
                
                tablerow.append(TableRow(height:15,
                                         bgColor: .AppBackgroundColor,
                                         cellType:.EmptyTVCell))
                
            }
            
            
        }
        
        
        
        
        
        tablerow.append(TableRow(moreData: customerDetails,
                                 cellType:.BookedTravelDetailsTVCell))
        
        
        tablerow.append(TableRow(height:15,
                                 bgColor: .AppBackgroundColor,
                                 cellType:.EmptyTVCell))
        
        
        tablerow.append(TableRow(cellType:.DownloadTicketTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    override func didTapOnBackBtn(cell: BookingConfTVCell) {
        BASE_URL = BASE_URL1
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    override func didTapOnDownloadBtnAction(cell: DownloadTicketTVCell) {
        let vocherpdf = "https://q8by.com/mobile_webservices/index.php/voucher/flight/\(vbookingReference)/\(vbookingsource)/\(vbookingStatus)/show_pdf"
        
        
        downloadAndSavePDF(showpdfurl: vocherpdf)
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoAboutUsVC(title: "Vocher Details", url: vocherpdf)
        }
        
    }
    
    
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.urlString = url
        vc.isVcFrom = "voucher"
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
        
    }
    
    func downloadFile(url:String){
        let url = url
        let fileName = "Voucher_\(Date())"
        savePdf(urlString: url, fileName: fileName)
        
    }
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "Q8BY-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                
                DispatchQueue.main.async {
                    self.showToast(message: "PDF successfully saved")
                }
                //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    
    
}



extension BookingConfirmedVC {
    
    
    
    // Function to download and save the PDF
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "Q8BY-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}
