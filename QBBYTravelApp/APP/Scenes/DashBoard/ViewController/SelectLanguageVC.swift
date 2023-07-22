//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC, SelectCurrencyViewModelDelgate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langUL: UIView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyUL: UIView!
    @IBOutlet weak var currencBtn: UIButton!
    
    
    static var newInstance: SelectLanguageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectLanguageVC
        return vc
    }
    var tablerow = [TableRow]()
    var vm:SelectCurrencyViewModel?
    

    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        callApi()
    }
    
    func callApi() {
        vm?.CALL_GET_CURRENCY_LIST_API(dictParam: [:])
    }
    
    
    var clist = [SelectCurrencyData]()
    func currencyList(response: SelectCurrencyModel) {
        clist = response.data ?? []
        DispatchQueue.main.async {[self] in
            setupCurencyTVCell()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
        vm = SelectCurrencyViewModel(self)
        
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        //        v.layer.borderWidth = 0
        //        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupUI() {
        
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: langView, radius: 3, color: .WhiteColor)
        setupViews(v: currencyView, radius: 3, color: .WhiteColor)
        setupViews(v: langUL, radius: 0, color: .AppBtnColor)
        setupViews(v: currencyUL, radius: 0, color: .WhiteColor)
        
        setupLabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: langlbl, text: "Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 16))
        setupLabels(lbl: currencylbl, text: "Currency", textcolor: .AppSubtitleColor, font: .LatoRegular(size: 16))
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        
        currencyView.isHidden = true
        commonTableView.registerTVCells(["SelectLanguageTVCell"])
        
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        
        clist.forEach { i in
            tablerow.append(TableRow(title:"\(i.name ?? "")",subTitle: "\(i.symbol ?? "")",key:"lang1",cellType: .SelectLanguageTVCell))

        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
//        langlbl.textColor = .AppBtnColor
//        langUL.backgroundColor = .AppBtnColor
//
//        currencylbl.textColor = .AppLabelColor
//        currencyUL.backgroundColor = .WhiteColor
//
//        setuplanguageTVCell()
        
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppBtnColor
        currencyUL.backgroundColor = .AppBtnColor
        setupCurencyTVCell()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppBtnColor
        currencyUL.backgroundColor = .AppBtnColor
        setupCurencyTVCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.selected()
            defaults.set(cell.subTitlelbl.text, forKey: UserDefaultsKeys.selectedCurrency)
            NotificationCenter.default.post(name: NSNotification.Name("selectedCurrency"), object: nil)
            dismiss(animated: true)
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
    
}
