/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Get_flight_ret : Codable {
	let id : String?
	let tours_id : String?
	let flight_book_id_onward : String?
	let flight_book_id_return : String?
	let created : String?
	let fsid : String?
	let is_domestic : String?
	let origin : String?
	let destination : String?
	let days : String?
	let dep_to_date : String?
	let arrival_time : String?
	let dep_from_date : String?
	let departure_time : String?
	let return_departure_from : String?
	let return_departure_from_time : String?
	let flight_num : String?
	let carrier_code : String?
	let airline_name : String?
	let class_type : String?
	let baggage : String?
	let checkin_baggage : String?
	let meals : String?
	let extra : String?
	let fare_rules : String?
	let fareType : String?
	let actual_basefare : String?
	let adult_basefare : String?
	let adult_selling_fare : String?
	let tax : String?
	let s_tax : String?
	let s_charge : String?
	let t_discount : String?
	let adult_tax : String?
	let child_basefare : String?
	let child_selling_fare : String?
	let child_tax : String?
	let infant_basefare : String?
	let infant_selling_fare : String?
	let infant_tax : String?
	let tax_breakup : String?
	let no_of_stops : String?
	let origin_city : String?
	let destination_city : String?
	let aircraft : String?
	let seats : String?
	let pilots_type : String?
	let pnr : String?
	let active : String?
	let update_time : String?
	let dep_from_date_1 : String?
	let crs_currency : String?
	let trip_type : String?
	let dep_terminal : String?
	let arr_terminal : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case tours_id = "tours_id"
		case flight_book_id_onward = "flight_book_id_onward"
		case flight_book_id_return = "flight_book_id_return"
		case created = "created"
		case fsid = "fsid"
		case is_domestic = "is_domestic"
		case origin = "origin"
		case destination = "destination"
		case days = "days"
		case dep_to_date = "dep_to_date"
		case arrival_time = "arrival_time"
		case dep_from_date = "dep_from_date"
		case departure_time = "departure_time"
		case return_departure_from = "return_departure_from"
		case return_departure_from_time = "return_departure_from_time"
		case flight_num = "flight_num"
		case carrier_code = "carrier_code"
		case airline_name = "airline_name"
		case class_type = "class_type"
		case baggage = "baggage"
		case checkin_baggage = "checkin_baggage"
		case meals = "meals"
		case extra = "extra"
		case fare_rules = "fare_rules"
		case fareType = "FareType"
		case actual_basefare = "actual_basefare"
		case adult_basefare = "adult_basefare"
		case adult_selling_fare = "adult_selling_fare"
		case tax = "tax"
		case s_tax = "s_tax"
		case s_charge = "s_charge"
		case t_discount = "t_discount"
		case adult_tax = "adult_tax"
		case child_basefare = "child_basefare"
		case child_selling_fare = "child_selling_fare"
		case child_tax = "child_tax"
		case infant_basefare = "infant_basefare"
		case infant_selling_fare = "infant_selling_fare"
		case infant_tax = "infant_tax"
		case tax_breakup = "tax_breakup"
		case no_of_stops = "no_of_stops"
		case origin_city = "origin_city"
		case destination_city = "destination_city"
		case aircraft = "aircraft"
		case seats = "seats"
		case pilots_type = "pilots_type"
		case pnr = "pnr"
		case active = "active"
		case update_time = "update_time"
		case dep_from_date_1 = "dep_from_date_1"
		case crs_currency = "crs_currency"
		case trip_type = "trip_type"
		case dep_terminal = "dep_terminal"
		case arr_terminal = "arr_terminal"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		tours_id = try values.decodeIfPresent(String.self, forKey: .tours_id)
		flight_book_id_onward = try values.decodeIfPresent(String.self, forKey: .flight_book_id_onward)
		flight_book_id_return = try values.decodeIfPresent(String.self, forKey: .flight_book_id_return)
		created = try values.decodeIfPresent(String.self, forKey: .created)
		fsid = try values.decodeIfPresent(String.self, forKey: .fsid)
		is_domestic = try values.decodeIfPresent(String.self, forKey: .is_domestic)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		days = try values.decodeIfPresent(String.self, forKey: .days)
		dep_to_date = try values.decodeIfPresent(String.self, forKey: .dep_to_date)
		arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
		dep_from_date = try values.decodeIfPresent(String.self, forKey: .dep_from_date)
		departure_time = try values.decodeIfPresent(String.self, forKey: .departure_time)
		return_departure_from = try values.decodeIfPresent(String.self, forKey: .return_departure_from)
		return_departure_from_time = try values.decodeIfPresent(String.self, forKey: .return_departure_from_time)
		flight_num = try values.decodeIfPresent(String.self, forKey: .flight_num)
		carrier_code = try values.decodeIfPresent(String.self, forKey: .carrier_code)
		airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
		class_type = try values.decodeIfPresent(String.self, forKey: .class_type)
		baggage = try values.decodeIfPresent(String.self, forKey: .baggage)
		checkin_baggage = try values.decodeIfPresent(String.self, forKey: .checkin_baggage)
		meals = try values.decodeIfPresent(String.self, forKey: .meals)
		extra = try values.decodeIfPresent(String.self, forKey: .extra)
		fare_rules = try values.decodeIfPresent(String.self, forKey: .fare_rules)
		fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
		actual_basefare = try values.decodeIfPresent(String.self, forKey: .actual_basefare)
		adult_basefare = try values.decodeIfPresent(String.self, forKey: .adult_basefare)
		adult_selling_fare = try values.decodeIfPresent(String.self, forKey: .adult_selling_fare)
		tax = try values.decodeIfPresent(String.self, forKey: .tax)
		s_tax = try values.decodeIfPresent(String.self, forKey: .s_tax)
		s_charge = try values.decodeIfPresent(String.self, forKey: .s_charge)
		t_discount = try values.decodeIfPresent(String.self, forKey: .t_discount)
		adult_tax = try values.decodeIfPresent(String.self, forKey: .adult_tax)
		child_basefare = try values.decodeIfPresent(String.self, forKey: .child_basefare)
		child_selling_fare = try values.decodeIfPresent(String.self, forKey: .child_selling_fare)
		child_tax = try values.decodeIfPresent(String.self, forKey: .child_tax)
		infant_basefare = try values.decodeIfPresent(String.self, forKey: .infant_basefare)
		infant_selling_fare = try values.decodeIfPresent(String.self, forKey: .infant_selling_fare)
		infant_tax = try values.decodeIfPresent(String.self, forKey: .infant_tax)
		tax_breakup = try values.decodeIfPresent(String.self, forKey: .tax_breakup)
		no_of_stops = try values.decodeIfPresent(String.self, forKey: .no_of_stops)
		origin_city = try values.decodeIfPresent(String.self, forKey: .origin_city)
		destination_city = try values.decodeIfPresent(String.self, forKey: .destination_city)
		aircraft = try values.decodeIfPresent(String.self, forKey: .aircraft)
		seats = try values.decodeIfPresent(String.self, forKey: .seats)
		pilots_type = try values.decodeIfPresent(String.self, forKey: .pilots_type)
		pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
		active = try values.decodeIfPresent(String.self, forKey: .active)
		update_time = try values.decodeIfPresent(String.self, forKey: .update_time)
		dep_from_date_1 = try values.decodeIfPresent(String.self, forKey: .dep_from_date_1)
		crs_currency = try values.decodeIfPresent(String.self, forKey: .crs_currency)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		dep_terminal = try values.decodeIfPresent(String.self, forKey: .dep_terminal)
		arr_terminal = try values.decodeIfPresent(String.self, forKey: .arr_terminal)
	}

}