
import Foundation
struct Get_airline_pnr : Codable {
	let airline_pnr : String?

	enum CodingKeys: String, CodingKey {

		case airline_pnr = "airline_pnr"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
	}

}
