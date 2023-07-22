

import Foundation
struct Flight_details : Codable {
    let summary : [Summary]?
    let refundable : Bool?
    let fareType : String?
    let totalPrice : String?
    let currency : String?
    
    enum CodingKeys: String, CodingKey {
        
        case summary = "summary"
        case refundable = "Refundable"
        case fareType = "FareType"
        case totalPrice = "TotalPrice"
        case currency = "Currency"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
        refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
    }
    
}
