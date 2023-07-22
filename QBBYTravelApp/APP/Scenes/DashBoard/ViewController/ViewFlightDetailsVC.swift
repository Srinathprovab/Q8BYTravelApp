//
//  ViewFlightDetailsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import UIKit

class ViewFlightDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: ViewFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetailsVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:FDViewModel?
    
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        DispatchQueue.main.async {[self] in
            setupItineraryTVCells()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        holderView.backgroundColor = .clear
        holderView.isHidden = false
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell"])
        
        setupItineraryTVCells()
    }
    
  
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:40,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
}
