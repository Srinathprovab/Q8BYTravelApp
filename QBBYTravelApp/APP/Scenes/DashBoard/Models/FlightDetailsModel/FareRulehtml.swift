

import Foundation
struct FareRulehtml : Codable {
    let rule_content : String?
    let rule_type : String?
    let rule_heading : String?
    let rule_category : String?

    enum CodingKeys: String, CodingKey {

        case rule_content = "rule_content"
        case rule_type = "rule_type"
        case rule_heading = "rule_heading"
        case rule_category = "rule_category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rule_content = try values.decodeIfPresent(String.self, forKey: .rule_content)
        rule_type = try values.decodeIfPresent(String.self, forKey: .rule_type)
        rule_heading = try values.decodeIfPresent(String.self, forKey: .rule_heading)
        rule_category = try values.decodeIfPresent(String.self, forKey: .rule_category)
    }

}
