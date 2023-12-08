//
//  AddFareRulesTVCell.swift
//  Beeoons
//
//  Created by FCI on 04/10/23.
//

import UIKit

protocol AddFareRulesTVCellDelegate {
    func didTapOnFareRulesBtnAction(cell:AddFareRulesTVCell)
    func showContentBtnAction(cell:FareRulesTVCell)
}

class AddFareRulesTVCell: TableViewCell, FareRulesTVCellDelegate {
    
    
    
    @IBOutlet weak var farerulesTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var dropimg: UIImageView!
    
    
    var delegate:AddFareRulesTVCellDelegate?
    var isToggled = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTapOnFareRulesBtnAction(_ sender: Any) {
        // Toggle the boolean variable
        isToggled.toggle()
        
        // Depending on the toggle state, update the button's title or perform some action
        if isToggled {
            
            dropimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
            tvHeight.constant = CGFloat(fareRulesData.count * 46)
            farerulesTV.reloadData()
        } else {
            dropimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
            tvHeight.constant = 0
            farerulesTV.reloadData()
        }
        
        delegate?.didTapOnFareRulesBtnAction(cell: self)
    }
    
    
    func showContentBtnAction(cell: FareRulesTVCell) {
        delegate?.showContentBtnAction(cell: cell)
    }
}


extension AddFareRulesTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func setupTV() {
        
        dropimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        tvHeight.constant = 0
        farerulesTV.register(UINib(nibName: "FareRulesTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        farerulesTV.delegate = self
        farerulesTV.dataSource = self
        farerulesTV.tableFooterView = UIView()
        farerulesTV.separatorStyle = .none
        farerulesTV.isScrollEnabled = false
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fareRulesData.count
    }
    
  

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FareRulesTVCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let data = fareRulesData[indexPath.row]
        cell.titlelbl.text = data.rule_heading ?? ""
        
        // Set the visibility of the content based on the isExpanded property
        cell.subTitlelbl.text = data.rule_content?.htmlToString
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        farerulesTV.deselectRow(at: indexPath, animated: true)
        
        // Access the cell
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            // Toggle the visibility of subtitlelbl
            cell.subTitlelbl.isHidden.toggle()
            
            // Update the layout of the cell
            farerulesTV.beginUpdates()
            farerulesTV.endUpdates()
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = fareRulesData[indexPath.row]
        let titleHeight: CGFloat = 20 // Set the estimated height of the titlelbl
        let subtitleHeight = heightForText(data.rule_content ?? "", font: UIFont.systemFont(ofSize: 17), width: tableView.bounds.width - 16) // Adjust the font size if needed
        
        // Add any additional padding or spacing as needed
        let padding: CGFloat = 16
        
        // Estimate the total cell height based on the title and subtitle
        return titleHeight + subtitleHeight + padding
    }

    func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }

    
}
