//
//  BaseVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseVC: BaseTableVC {
    
    var customNavBar : NavBar?
    
    
    override var title : String? {
        set {
            super.title = newValue
           // configureTitleView()
        }
        get {
            return super.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        configureCommonNavBar()
//        configureBackButton()
    }
    
//    func configureCommonNavBar() {
//        let commonNavView: NavBar = NavBar()
//        let height:CGFloat = UIScreen.main.bounds.size.height > 810 ? 110 : 90
//        commonNavView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: height)
//        commonNavView.backgroundColor = .clear
//
//        self.view.addSubview(commonNavView)
//        self.customNavBar = commonNavView
//        self.customNavBar?.rightView.isHidden = true
//    }
    
    
//    func configureSignupNavBar() {
//        let commonNavView1: NavBar = NavBar()
//        let height:CGFloat = UIScreen.main.bounds.size.height > 810 ? 160 : 90
//        commonNavView1.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: height)
//        self.view.addSubview(commonNavView1)
//
//        commonNavView1.rightView.isHidden = true
//        commonNavView1.statusView.isHidden = true
//        commonNavView1.userimageHolderView.isHidden = true
//
//        commonNavView1.titleLabel.isHidden = true
//        commonNavView1.leftButton.addTarget(self, action: #selector(leftBarBtnAction), for: UIControl.Event.touchUpInside)
//
//        self.customNavBar?.isHidden = true
//
//    }
    
//    func configureTitleView() {
//        self.customNavBar?.titleLabel.text = title
//        self.customNavBar?.titleLabel.textColor = UIColor.buttonBGColor
//        self.customNavBar?.titleLabel.font = UIFont.buttonTitleFont
//    }
//    func configureRightTitleView() {
//        self.customNavBar?.rightView.isHidden = true
//        self.customNavBar?.rightLabel.textColor = UIColor.applyTitleColor
//        self.customNavBar?.rightLabel.font = UIFont.buttonTitleFont
//        self.customNavBar?.rightButton.addTarget(self, action: #selector(BaseVC.rightBarBtnAction), for: UIControl.Event.touchUpInside)
//
//    }
    
//    func configureBackButton() {
//        var frame = customNavBar?.backButtonImage.frame ?? CGRect.zero
//        frame.size = CGSize(width: 25, height: 25)
//        customNavBar?.leftView.isHidden = false
//        customNavBar?.backButtonImage.frame = frame
//        customNavBar?.backButtonImage.image = UIImage(named: "BackArrowButton")
//        customNavBar?.leftButton.addTarget(self, action: #selector(leftBarBtnAction), for: UIControl.Event.touchUpInside)
//    }
    
  
    
    
    func setAppBGView(){
        let backgroundImage = UIImage.init(named: "PuzzleBackground")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
    }
    
    
    
    
}
extension BaseVC {
    @objc func leftBarBtnAction() {
        print("button clicked")
    }
    
    @objc func rightBarBtnAction() { }
    
    @objc func didTapOnChatUserInfo() {
        
    }
}
