/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Tour_price_changed : Codable {
	let pricing : String?
	let child_pricing : String?
	let occ : String?
	let value_type : String?
	let markup : String?
	let calculated_markup : String?
	let calculated_child_markup : String?
	let tour_id : String?
	let from_date : String?
	let to_date : String?
	let occupancy_name : String?
	let changed_price : Int?

	enum CodingKeys: String, CodingKey {

		case pricing = "pricing"
		case child_pricing = "child_pricing"
		case occ = "occ"
		case value_type = "value_type"
		case markup = "markup"
		case calculated_markup = "calculated_markup"
		case calculated_child_markup = "calculated_child_markup"
		case tour_id = "tour_id"
		case from_date = "from_date"
		case to_date = "to_date"
		case occupancy_name = "occupancy_name"
		case changed_price = "changed_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pricing = try values.decodeIfPresent(String.self, forKey: .pricing)
		child_pricing = try values.decodeIfPresent(String.self, forKey: .child_pricing)
		occ = try values.decodeIfPresent(String.self, forKey: .occ)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		markup = try values.decodeIfPresent(String.self, forKey: .markup)
		calculated_markup = try values.decodeIfPresent(String.self, forKey: .calculated_markup)
		calculated_child_markup = try values.decodeIfPresent(String.self, forKey: .calculated_child_markup)
		tour_id = try values.decodeIfPresent(String.self, forKey: .tour_id)
		from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		occupancy_name = try values.decodeIfPresent(String.self, forKey: .occupancy_name)
		changed_price = try values.decodeIfPresent(Int.self, forKey: .changed_price)
	}

}