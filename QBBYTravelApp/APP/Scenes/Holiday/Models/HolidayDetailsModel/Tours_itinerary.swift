/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Tours_itinerary : Codable {
	let id : String?
	let publish_status : String?
	let tour_id : String?
	let tour_code : String?
	let dep_date : String?
	let no_of_seats : String?
	let total_booked : String?
	let available_seats : String?
	let booking_hold : String?
	let tour_visited_city_id : String?
	let itinerary : String?
	let adult_twin_sharing : String?
	let adult_tripple_sharing : String?
	let service_tax : String?
	let tcs : String?
	let sightseeing : String?
	let no_of_nights : String?
	let includes_city_tours : String?
	let reporting : String?
	let reporting_date : String?
	let reporting_desc : String?
	let highlights : String?
	let inclusions : String?
	let exclusions : String?
	let terms : String?
	let canc_policy : String?
	let inclusions_checks : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case publish_status = "publish_status"
		case tour_id = "tour_id"
		case tour_code = "tour_code"
		case dep_date = "dep_date"
		case no_of_seats = "no_of_seats"
		case total_booked = "total_booked"
		case available_seats = "available_seats"
		case booking_hold = "booking_hold"
		case tour_visited_city_id = "tour_visited_city_id"
		case itinerary = "itinerary"
		case adult_twin_sharing = "adult_twin_sharing"
		case adult_tripple_sharing = "adult_tripple_sharing"
		case service_tax = "service_tax"
		case tcs = "tcs"
		case sightseeing = "sightseeing"
		case no_of_nights = "no_of_nights"
		case includes_city_tours = "includes_city_tours"
		case reporting = "reporting"
		case reporting_date = "reporting_date"
		case reporting_desc = "reporting_desc"
		case highlights = "highlights"
		case inclusions = "inclusions"
		case exclusions = "exclusions"
		case terms = "terms"
		case canc_policy = "canc_policy"
		case inclusions_checks = "inclusions_checks"
		case date = "date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		publish_status = try values.decodeIfPresent(String.self, forKey: .publish_status)
		tour_id = try values.decodeIfPresent(String.self, forKey: .tour_id)
		tour_code = try values.decodeIfPresent(String.self, forKey: .tour_code)
		dep_date = try values.decodeIfPresent(String.self, forKey: .dep_date)
		no_of_seats = try values.decodeIfPresent(String.self, forKey: .no_of_seats)
		total_booked = try values.decodeIfPresent(String.self, forKey: .total_booked)
		available_seats = try values.decodeIfPresent(String.self, forKey: .available_seats)
		booking_hold = try values.decodeIfPresent(String.self, forKey: .booking_hold)
		tour_visited_city_id = try values.decodeIfPresent(String.self, forKey: .tour_visited_city_id)
		itinerary = try values.decodeIfPresent(String.self, forKey: .itinerary)
		adult_twin_sharing = try values.decodeIfPresent(String.self, forKey: .adult_twin_sharing)
		adult_tripple_sharing = try values.decodeIfPresent(String.self, forKey: .adult_tripple_sharing)
		service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
		tcs = try values.decodeIfPresent(String.self, forKey: .tcs)
		sightseeing = try values.decodeIfPresent(String.self, forKey: .sightseeing)
		no_of_nights = try values.decodeIfPresent(String.self, forKey: .no_of_nights)
		includes_city_tours = try values.decodeIfPresent(String.self, forKey: .includes_city_tours)
		reporting = try values.decodeIfPresent(String.self, forKey: .reporting)
		reporting_date = try values.decodeIfPresent(String.self, forKey: .reporting_date)
		reporting_desc = try values.decodeIfPresent(String.self, forKey: .reporting_desc)
		highlights = try values.decodeIfPresent(String.self, forKey: .highlights)
		inclusions = try values.decodeIfPresent(String.self, forKey: .inclusions)
		exclusions = try values.decodeIfPresent(String.self, forKey: .exclusions)
		terms = try values.decodeIfPresent(String.self, forKey: .terms)
		canc_policy = try values.decodeIfPresent(String.self, forKey: .canc_policy)
		inclusions_checks = try values.decodeIfPresent(String.self, forKey: .inclusions_checks)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}

}