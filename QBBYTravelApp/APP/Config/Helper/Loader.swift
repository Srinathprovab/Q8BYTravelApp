//
//  Loader.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 05/05/22.
//

import Foundation
import MBProgressHUD

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            
            if loderBool == false {
                loaderShow(loder:"loder",v:view)
            }else {
                loaderShow(loder:"loderimg",v:view)
            }
            
        }
        
        
        func loaderShow(loder:String,v:UIView) {
           
            let HUD = MBProgressHUD.showAdded(to: v, animated: true)
            let imageViewAnimatedGif = UIImageView()
            //The key here is to save the GIF file or URL download directly into a NSData instead of making it a UIImage. Bypassing UIImage will let the GIF file keep the animation.
            
            var filePath = Bundle.main.path(forResource: loder, ofType: "gif") ?? ""
           
            let gifData = NSData(contentsOfFile: filePath) as Data?
            imageViewAnimatedGif.image = UIImage.sd_image(withGIFData: gifData)
            HUD.customView = UIImageView(image: imageViewAnimatedGif.image)
            var rotation: CABasicAnimation?
            rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation?.fromValue = nil
            // If you want to rotate Gif Image Uncomment
            //  rotation?.toValue = CGFloat.pi * 2
            rotation?.duration = 0.7
            rotation?.isRemovedOnCompletion = false
            HUD.customView?.layer.add(rotation!, forKey: "Spin")
            HUD.mode = MBProgressHUDMode.customView
            // Change hud bezelview Color and blurr effect
            HUD.bezelView.color = UIColor.clear
            HUD.bezelView.tintColor = UIColor.clear
            HUD.bezelView.style = .solidColor
            HUD.bezelView.blurEffectStyle = .dark
            // Speed
            rotation?.repeatCount = .infinity
            HUD.show(animated: true)
        }
        
        
    }
    
    
    
    
    static func hide(for view: UIView, animated: Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
            ProgressHUD.dismiss()
        }
    }
    
    
}
