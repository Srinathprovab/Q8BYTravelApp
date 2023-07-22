

import Foundation

struct CancellationPolicies : Codable {
	let amount : String?
	let from : String?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
		case from = "from"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		from = try values.decodeIfPresent(String.self, forKey: .from)
	}

}
