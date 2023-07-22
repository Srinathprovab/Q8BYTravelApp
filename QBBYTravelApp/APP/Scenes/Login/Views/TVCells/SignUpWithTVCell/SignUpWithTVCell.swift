//
//  SignUpWithTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
protocol SignUpWithTVCellDelegate {
    func didTapOnGoogleBtn(cell: SignUpWithTVCell)
}

class SignUpWithTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnHolderView: UIView!
    @IBOutlet weak var gImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    var delegate:SignUpWithTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        //titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        btnHolderView.backgroundColor = .WhiteColor
        btnHolderView.layer.borderWidth = 1.5
        btnHolderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        btnHolderView.layer.cornerRadius = 4
        btnHolderView.clipsToBounds = true
        gImage.image = UIImage(named: "google")
        
        titlelbl.text = "Google"
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.poppinsMedium(size: 16)
    }
    
    
    @IBAction func didTapOnGoogleBtn(_ sender: Any) {
        delegate?.didTapOnGoogleBtn(cell: self)
    }
    
    
}
