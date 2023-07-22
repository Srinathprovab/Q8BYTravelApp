
import Foundation

struct Format_desc : Codable {
	let heading : String?
	let content : String?

	enum CodingKeys: String, CodingKey {

		case heading = "heading"
		case content = "content"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		heading = try values.decodeIfPresent(String.self, forKey: .heading)
		content = try values.decodeIfPresent(String.self, forKey: .content)
	}

}
