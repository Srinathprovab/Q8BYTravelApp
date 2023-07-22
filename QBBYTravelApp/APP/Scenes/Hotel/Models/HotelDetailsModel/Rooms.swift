

import Foundation


struct Rooms : Codable {
    let rateKey : String?
    let rateClass : String?
    let rateType : String?
    let allotment : Int?
    let boardCode : String?
    let boardName : String?
    let code : String?
    let name : String?
    let xml_currency : String?
    let xml_net : String?
    let refund : Bool?
    let currency : String?
    let net : String?
    let cancellationPolicies : [CancellationPolicies]?
    let rooms : Int?
    let adults : Int?
    let children : Int?
    let childrenAges : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case rateKey = "rateKey"
        case rateClass = "rateClass"
        case rateType = "rateType"
        case allotment = "allotment"
        case boardCode = "boardCode"
        case boardName = "boardName"
        case code = "code"
        case name = "name"
        case xml_currency = "xml_currency"
        case xml_net = "xml_net"
        case refund = "refund"
        case currency = "currency"
        case net = "net"
        case cancellationPolicies = "cancellationPolicies"
        case rooms = "rooms"
        case adults = "adults"
        case children = "children"
        case childrenAges = "childrenAges"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
        rateClass = try values.decodeIfPresent(String.self, forKey: .rateClass)
        rateType = try values.decodeIfPresent(String.self, forKey: .rateType)
        allotment = try values.decodeIfPresent(Int.self, forKey: .allotment)
        boardCode = try values.decodeIfPresent(String.self, forKey: .boardCode)
        boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
        refund = try values.decodeIfPresent(Bool.self, forKey: .refund)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        net = try values.decodeIfPresent(String.self, forKey: .net)
        cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
        rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        children = try values.decodeIfPresent(Int.self, forKey: .children)
        childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
