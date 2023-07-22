/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Review_field : Codable {
	let exist_user1 : String?
	let exist_user0 : String?
	let previously_booked1 : String?
	let previously_booked0 : String?
	let exist_user_field : Exist_user_field?

	enum CodingKeys: String, CodingKey {

		case exist_user1 = "exist_user1"
		case exist_user0 = "exist_user0"
		case previously_booked1 = "previously_booked1"
		case previously_booked0 = "previously_booked0"
		case exist_user_field = "exist_user_field"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		exist_user1 = try values.decodeIfPresent(String.self, forKey: .exist_user1)
		exist_user0 = try values.decodeIfPresent(String.self, forKey: .exist_user0)
		previously_booked1 = try values.decodeIfPresent(String.self, forKey: .previously_booked1)
		previously_booked0 = try values.decodeIfPresent(String.self, forKey: .previously_booked0)
		exist_user_field = try values.decodeIfPresent(Exist_user_field.self, forKey: .exist_user_field)
	}

}