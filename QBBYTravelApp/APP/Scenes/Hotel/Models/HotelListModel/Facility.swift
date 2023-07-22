

import Foundation
struct Facility : Codable {
	let icon_class : String?
	let name : String?
	let cstr : String?
	let hc : String?

	enum CodingKeys: String, CodingKey {

		case icon_class = "icon_class"
		case name = "name"
		case cstr = "cstr"
		case hc = "hc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon_class = try values.decodeIfPresent(String.self, forKey: .icon_class)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		cstr = try values.decodeIfPresent(String.self, forKey: .cstr)
		hc = try values.decodeIfPresent(String.self, forKey: .hc)
	}

}
