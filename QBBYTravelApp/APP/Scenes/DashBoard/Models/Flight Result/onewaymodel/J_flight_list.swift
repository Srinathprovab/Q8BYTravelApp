

import Foundation


struct J_flight_list : Codable {
    
    let totalPrice : String?
    //   let basePrice : String?
    //    let taxes : String?
    let totalPrice_API : String?
    //    let aPICurrencyType : String?
    //    let sITECurrencyType : String?
    //   let refundable : String?
    //    let platingCarrier : String?
    let fareType : String?
    //    let all_Passenger : String?
    let adults : Int?
    let childs : Int?
    let infants : Int?
    let adults_Base_Price : String?
    let childs_Base_Price : String?
    let infants_Base_Price : String?
    let adults_Tax_Price : String?
    let childs_Tax_Price : String?
    let infants_Tax_Price : String?
    //    let travelTime : String?
    //    let airSegment_Key : String?
    let token : String?
    let token_key : String?
    let flight_details : Flight_details?
    let access_key : String?
    
    enum CodingKeys: String, CodingKey {
        
        
        case totalPrice = "TotalPrice"
        //        case basePrice = "BasePrice"
        //        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        //        case aPICurrencyType = "APICurrencyType"
        //        case sITECurrencyType = "SITECurrencyType"
        //    case refundable = "Refundable"
        //        case platingCarrier = "PlatingCarrier"
        case fareType = "FareType"
        //        case all_Passenger = "All_Passenger"
        case adults = "Adults"
        case childs = "Childs"
        case infants = "Infants"
        case adults_Base_Price = "Adults_Base_Price"
        case childs_Base_Price = "Childs_Base_Price"
        case infants_Base_Price = "Infants_Base_Price"
        case adults_Tax_Price = "Adults_Tax_Price"
        case childs_Tax_Price = "Childs_Tax_Price"
        case infants_Tax_Price = "Infants_Tax_Price"
        //        case travelTime = "TravelTime"
        //        case airSegment_Key = "AirSegment_Key"
        case token = "token"
        case token_key = "token_key"
        case flight_details = "flight_details"
        case access_key = "access_key"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        //        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        //        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        //        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        //        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        //    refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
        //        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        //        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        childs = try values.decodeIfPresent(Int.self, forKey: .childs)
        infants = try values.decodeIfPresent(Int.self, forKey: .infants)
        adults_Base_Price = try values.decodeIfPresent(String.self, forKey: .adults_Base_Price)
        childs_Base_Price = try values.decodeIfPresent(String.self, forKey: .childs_Base_Price)
        infants_Base_Price = try values.decodeIfPresent(String.self, forKey: .infants_Base_Price)
        adults_Tax_Price = try values.decodeIfPresent(String.self, forKey: .adults_Tax_Price)
        childs_Tax_Price = try values.decodeIfPresent(String.self, forKey: .childs_Tax_Price)
        infants_Tax_Price = try values.decodeIfPresent(String.self, forKey: .infants_Tax_Price)
        //        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
        //        airSegment_Key = try values.decodeIfPresent(String.self, forKey: .airSegment_Key)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
    }
    
}
