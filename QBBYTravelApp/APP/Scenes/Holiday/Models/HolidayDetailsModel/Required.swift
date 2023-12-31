/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Required : Codable {
	let created_by : String?
	let booking_source : String?
	let module : String?
	let module_id : String?
	let title : String?
	let address : String?
	let tour_id : String?
	let tours_itinerary_id : String?

	enum CodingKeys: String, CodingKey {

		case created_by = "created_by"
		case booking_source = "booking_source"
		case module = "module"
		case module_id = "module_id"
		case title = "title"
		case address = "address"
		case tour_id = "tour_id"
		case tours_itinerary_id = "tours_itinerary_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		module_id = try values.decodeIfPresent(String.self, forKey: .module_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		tour_id = try values.decodeIfPresent(String.self, forKey: .tour_id)
		tours_itinerary_id = try values.decodeIfPresent(String.self, forKey: .tours_itinerary_id)
	}

}