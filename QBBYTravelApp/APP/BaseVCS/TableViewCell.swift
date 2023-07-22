//
//  TableViewCell.swift
//  shifuApp
//
//  Created by Codebele on 12/09/19.
//  Copyright © 2019 Codebele. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var indexPath: IndexPath?
    var cellInfo: TableRow? { didSet { if cellInfo != nil { updateUI() } }}
    var currentField: UITextField?
    
    func updateUI(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension TableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentField = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " "
        {
            return false
        }
        if (textField.text?.count == 0) && string == " " {
            
            return false
            
        }
        if (string == " ") {
            return false
        }
        return true
    }
    
    
    
    

}
