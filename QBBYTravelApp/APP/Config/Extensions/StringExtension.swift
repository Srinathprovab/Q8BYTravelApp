//
//  StringExtension.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit

extension String {
    
    
    
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                                        NSRange(
                                            location: 0,
                                            length: nsString.length > length ? length : nsString.length)
            )
        }
        return  str
    }
    
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    
    
    func validateAsEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}




class ShadowEffect: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // corner radius
        self.layer.cornerRadius = 10
        
        // border
        //self.layer.borderWidth = 1.0
        //  self.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 7
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension String{
    
    
    
    func getMobileNumberMaxLength() -> Int? {
        let countryMobileNumberMaxLength: [String: Int] = [
            "Albania": 10,
            "Algeria": 10,
            "American Samoa": 10,
            "Andorra": 9,
            "Angola": 9,
            "Anguilla": 10,
            "Antigua And Barbuda": 10,
            "Argentina": 10,
            "Armenia": 8,
            "Aruba": 10,
            "Australia": 10,
            "Austria": 12,
            "Azerbaijan": 9,
            "Bahamas": 10,
            "Bahrain": 10,
            "Bangladesh": 11,
            "Barbados": 10,
            "Belarus": 9,
            "Belgium": 10,
            "Belize": 7,
            "Benin": 8,
            "Bermuda": 10,
            "Bhutan": 8,
            "Bolivia": 8,
            "Bosnia And Herzegovina": 8,
            "Botswana": 8,
            "Brazil": 11,
            "Brunei Darussalam": 10,
            "Bulgaria": 9,
            "Burkina Faso": 8,
            "Burundi": 8,
            "Cambodia": 9,
            "Cameroon": 9,
            "Canada": 10,
            "Cape Verde": 7,
            "Cayman Islands": 10,
            "Central African Republic": 8,
            "Chad": 8,
            "Chile": 9,
            "China": 11,
            "Christmas Island": 10,
            "Cocos (Keeling) Islands": 10,
            "Colombia": 10,
            "Comoros": 8,
            "Congo": 9,
            "Congo, DR Of The": 9,
            "Cook Islands": 5,
            "Costa Rica": 8,
            "Croatia": 9,
            "Cyprus": 10,
            "Czech Republic": 9,
            "Denmark": 8,
            "Djibouti": 8,
            "Dominica": 10,
            "Dominican Republic": 10,
            "Ecuador": 10,
            "Egypt": 11,
            "El Salvador": 8,
            "Equatorial Guinea": 9,
            "Eritrea": 7,
            "Estonia": 10,
            "Ethiopia": 9,
            "Falkland Islands": 10,
            "Faroe Islands": 6,
            "Fiji": 8,
            "Finland": 10,
            "France": 9,
            "French Guiana": 9,
            "French Polynesia": 6,
            "Gabon": 8,
            "Gambia": 8,
            "Georgia": 9,
            "Germany": 10,
            "Ghana": 10,
            "Gibralter": 8,
            "Greece": 10,
            "Greenland": 10,
            "Grenada": 10,
            "Guadeloupe": 9,
            "Guam": 10,
            "Guatemala": 8,
            "Guinea": 8,
            "Guinea-Bissau": 8,
            "Guyana": 7,
            "Haiti": 8,
            "Honduras": 8,
            "Hong Kong": 8,
            "Hungary": 9,
            "Iceland": 7,
            "India": 10,
            "Indonesia": 12,
            "Ireland": 10,
            "Israel": 9,
            "Italy": 10,
            "Jamaica": 10,
            "Japan": 11,
            "Jordan": 10,
            "Kazakhstan": 10,
            "Kenya": 10,
            "Kiribati": 5,
            "Korea, DPR Of": 11,
            "Korea, Republic Of": 11,
            "Kuwait": 8,
            "Kyrgyzstan": 9,
            "Laos": 10,
            "Latvia": 8,
            "Lebanon": 8,
            "Lesotho": 8,
            "Libyan Arab Jamahiriya": 9,
            "Liechtenstein": 9,
            "Lithuania": 8,
            "Luxembourg": 9,
            "Macao": 8,
            "Macedonia, FYR Of": 9,
            "Madagascar": 9,
            "Malawi": 9,
            "Malaysia": 11,
            "Maldives": 8,
            "Mali": 8,
            "Malta": 8,
            "Marshall Islands": 7,
            "Martinique": 9,
            "Mauritania": 8,
            "Mauritius": 9,
            "Mayotte": 9,
            "Mexico": 10,
            "Micronesia, FS Of": 7,
            "Moldova, Republic Of": 8,
            "Monaco": 8,
            "Mongolia": 8,
            "Montenegro": 9,
            "Montserrat": 10,
            "Morocco": 9,
            "Mozambique": 9,
            "Myanmar": 9,
            "Namibia": 9,
            "Nauru": 7,
            "Nepal": 10,
            "Netherlands": 9,
            "New Caledonia": 6,
            "New Zealand": 9,
            "Nicaragua": 8,
            "Niger": 8,
            "Nigeria": 11,
            "Niue": 4,
            "Norfolk Island": 6,
            "Northern Mariana Islands": 7,
            "Norway": 8,
            "Oman": 8,
            "Pakistan": 11,
            "Palau": 7,
            "Panama": 8,
            "Papua New Guinea": 7,
            "Paragua": 10,
            "Paraguay": 9,
            "Peru": 9,
            "Philippines": 10,
            "Pitcairn": 7,
            "Poland": 9,
            "Portugal": 9,
            "Puerto Rico": 10,
            "Qatar": 8,
            "Reunion": 9,
            "Romania": 10,
            "Russian Federation": 10,
            "Rwanda": 9,
            "Saint Barthelemy": 10,
            "Saint Kitts And Nevis": 7,
            "Saint Lucia": 7,
            "Saint Martin": 9,
            "Samoa": 7,
            "San Marino": 10,
            "Sao Tome And Principe": 9,
            "Saudi Arabia": 9,
            "Senegal": 9,
            "Serbia": 10,
            "Seychelles": 7,
            "Sierra Leone": 8,
            "Singapore": 8,
            "Slovakia (Slovak Republic)": 9,
            "Slovenia": 9,
            "Solomon Islands": 8,
            "South Africa": 9,
            "Spain": 9,
            "Sri Lanka": 10,
            "St Vincent And The Grenadines": 7,
            "St. Helena": 4,
            "St. Pierre And Miquelon": 6,
            "Sudan": 9,
            "Suriname": 8,
            //       "Svalbard And Jan Mayen Islands":
            "Swaziland": 8,
            "Sweden": 9,
            "Switzerland": 9,
            "Taiwan": 9,
            "Tajikistan": 9,
            "Tanzania": 9,
            "Thailand": 10,
            "Togo": 8,
            "Tonga": 7,
            "Trinidad And Tobago": 7,
            "Tunisia": 8,
            "Turkey": 10,
            "Turkmenistan": 8,
            "Turks And Caicos Islands": 7,
            "Tuvalu": 5,
            "Uganda": 9,
            "Ukraine": 10,
            "United Arab Emirates": 9,
            "United Kingdom": 10,
            "United States": 10,
            "Uruguay": 8,
            "US Minor Outlying Islands": 10,
            "Uzbekistan": 9,
            "Vanuatu": 7,
            "Vatican City State": 10,
            "Venezuela": 10,
            "Viet Nam": 10,
            "Virgin Islands - British": 10,
            "Virgin Islands - U.S.": 10,
            "Wallis And Futuna Islands": 6,
            "Yemen": 9,
            "Zambia": 9,
            "Zimbabwe": 9,
            "Afghanistan": 9,
            "Nabbaa": 6,
            "Iran": 10
        ]
        
        return countryMobileNumberMaxLength[self]
    }
    
    
    func appendAttributedStringWithDifferentFonts(string:String,style1:UIFont,Style2:UIFont,color1:UIColor,color2:UIColor,alignment:NSTextAlignment? = NSTextAlignment.left) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = alignment!
        
        let myMutableString = NSMutableAttributedString(
            string: self,
            attributes: [NSAttributedString.Key.foregroundColor:color1,NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.font:style1])
        
        myMutableString.append(NSAttributedString(string : string, attributes : [NSAttributedString.Key.foregroundColor:color2,NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:Style2]))
        
        return myMutableString as NSAttributedString
    }
    
    func validateAsPhone() -> Bool {
        let phoneRegEx = "^[0-9'@s]{10}$"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES[c] %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    //    func isValidEmail(email: String) -> Bool {
    //        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    //        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    //        return emailTest.evaluate(with: email)
    //    }
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        
    }
    
    
    
    
    func validateAsPhoneNumber() -> Bool {
        
        let phoneRegEx = "^[0-9]{3}-[0-9]{3}-[0-9]{4}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES[c] %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
        
    }
    
    
    //    func isValidEmail() -> Bool {
    //        // here, `try!` will always succeed because the pattern is valid
    //        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    //        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    //    }
    
    
    func isValidEmail() -> Bool {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    
    func isValidMobileNumber() -> Bool {
        let mobileNumberRegex = "^[0-9]{7,12}$"
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberPredicate.evaluate(with: self)
    }
    
    
    
}
extension NSMutableAttributedString {
    
    func setFontForText(textForAttribute: String, withFont font: UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    
    func setFontForTextWithColor(textForAttribute: String, withFont font: UIFont,textColor: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        //        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        self.addAttributes([NSAttributedString.Key.font: font,
                            NSAttributedString.Key.foregroundColor: textColor], range: range)
        
        // Swift 4.1 and below
        //        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    
    func setButtonAttributedTittle(string1: String,string2: String,color1: UIColor,color2 :UIColor,font1: UIFont,font2 :UIFont) -> NSMutableAttributedString {
        let finalString: NSMutableAttributedString = NSMutableAttributedString()
        let attributes1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : color1]
        let attributes2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : color2]
        
        let attributedString1 : NSAttributedString = NSAttributedString(string: string1, attributes: attributes1)
        let attributedString2 : NSAttributedString = NSAttributedString(string: string2, attributes: attributes2)
        
        finalString.append(attributedString1)
        finalString.append(attributedString2)
        return finalString
    }
    
    
    
}

extension UIView
{
    
    func addCornerRadiusWithShadow(color: UIColor, borderColor: UIColor, cornerRadius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
    }
    
    
    
    func fadeIn(duration: TimeInterval = 1.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.transitionCurlDown, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 3.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.transitionCurlDown, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
}


extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
