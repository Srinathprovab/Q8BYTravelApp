
import Foundation
struct Post_data : Codable {
	let appreference : String?
	let searchid : String?
	let apicurrency : String?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case appreference = "appreference"
		case searchid = "searchid"
		case apicurrency = "apicurrency"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		appreference = try values.decodeIfPresent(String.self, forKey: .appreference)
		searchid = try values.decodeIfPresent(String.self, forKey: .searchid)
		apicurrency = try values.decodeIfPresent(String.self, forKey: .apicurrency)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
