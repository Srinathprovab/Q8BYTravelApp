
import Foundation
struct SearchResult : Codable {
    let id : String?
    let package_id : String?
    let package_name : String?
    let package_description : String?
    let expire_date : String?
    let destination : String?
    let tour_type : String?
    let theme : String?
    let tours_continent : String?
    let tours_country : String?
    let tours_city : String?
    let duration : String?
    let adult_twin_sharing : String?
    let adult_tripple_sharing : String?
    let child_with_bed : String?
    let child_without_bed : String?
    let joining_directly : String?
    let single_suppliment : String?
    let service_tax : String?
    let tcs : String?
    let highlights : String?
    let inclusions : String?
    let exclusions : String?
    let terms : String?
    let canc_policy : String?
    let banner_image : String?
    let gallery : String?
    let image_description : String?
    //	let inclusions_checks : [String]?
    let date : String?
    let perfect_holidays : String?
    let agent_id : String?
    let admin_approve_status : String?
    let agent_request_status : String?
    let added_by : String?
    let supplier_name : String?
    let email : String?
    let trip_notes : String?
    let status : String?
    let status_delete : String?
    let tour_id : String?
    let country_id : String?
    let city_id : String?
    let name : String?
    let isocode : String?
    let continent : String?
    let cityCode : String?
    let cityName : String?
    let countryCode : String?
    let countryName : String?
    let publish_status : String?
    let tour_code : String?
    let dep_date : String?
    let no_of_seats : String?
    let total_booked : String?
    let available_seats : String?
    let booking_hold : String?
    let tour_visited_city_id : String?
    let itinerary : String?
    let sightseeing : String?
    let no_of_nights : String?
    let includes_city_tours : String?
    let reporting : String?
    let reporting_date : String?
    let reporting_desc : String?
    let city : String?
    let adult_price : String?
    let child_price : String?
    let currency : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case package_id = "package_id"
        case package_name = "package_name"
        case package_description = "package_description"
        case expire_date = "expire_date"
        case destination = "destination"
        case tour_type = "tour_type"
        case theme = "theme"
        case tours_continent = "tours_continent"
        case tours_country = "tours_country"
        case tours_city = "tours_city"
        case duration = "duration"
        case adult_twin_sharing = "adult_twin_sharing"
        case adult_tripple_sharing = "adult_tripple_sharing"
        case child_with_bed = "child_with_bed"
        case child_without_bed = "child_without_bed"
        case joining_directly = "joining_directly"
        case single_suppliment = "single_suppliment"
        case service_tax = "service_tax"
        case tcs = "tcs"
        case highlights = "highlights"
        case inclusions = "inclusions"
        case exclusions = "exclusions"
        case terms = "terms"
        case canc_policy = "canc_policy"
        case banner_image = "banner_image"
        case gallery = "gallery"
        case image_description = "image_description"
        //	case inclusions_checks = "inclusions_checks"
        case date = "date"
        case perfect_holidays = "perfect_holidays"
        case agent_id = "agent_id"
        case admin_approve_status = "admin_approve_status"
        case agent_request_status = "agent_request_status"
        case added_by = "added_by"
        case supplier_name = "supplier_name"
        case email = "email"
        case trip_notes = "trip_notes"
        case status = "status"
        case status_delete = "status_delete"
        case tour_id = "tour_id"
        case country_id = "country_id"
        case city_id = "city_id"
        case name = "name"
        case isocode = "isocode"
        case continent = "continent"
        case cityCode = "CityCode"
        case cityName = "CityName"
        case countryCode = "CountryCode"
        case countryName = "CountryName"
        case publish_status = "publish_status"
        case tour_code = "tour_code"
        case dep_date = "dep_date"
        case no_of_seats = "no_of_seats"
        case total_booked = "total_booked"
        case available_seats = "available_seats"
        case booking_hold = "booking_hold"
        case tour_visited_city_id = "tour_visited_city_id"
        case itinerary = "itinerary"
        case sightseeing = "sightseeing"
        case no_of_nights = "no_of_nights"
        case includes_city_tours = "includes_city_tours"
        case reporting = "reporting"
        case reporting_date = "reporting_date"
        case reporting_desc = "reporting_desc"
        case city = "city"
        case adult_price = "adult_price"
        case child_price = "child_price"
        case currency = "currency"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        package_id = try values.decodeIfPresent(String.self, forKey: .package_id)
        package_name = try values.decodeIfPresent(String.self, forKey: .package_name)
        package_description = try values.decodeIfPresent(String.self, forKey: .package_description)
        expire_date = try values.decodeIfPresent(String.self, forKey: .expire_date)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        tour_type = try values.decodeIfPresent(String.self, forKey: .tour_type)
        theme = try values.decodeIfPresent(String.self, forKey: .theme)
        tours_continent = try values.decodeIfPresent(String.self, forKey: .tours_continent)
        tours_country = try values.decodeIfPresent(String.self, forKey: .tours_country)
        tours_city = try values.decodeIfPresent(String.self, forKey: .tours_city)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        adult_twin_sharing = try values.decodeIfPresent(String.self, forKey: .adult_twin_sharing)
        adult_tripple_sharing = try values.decodeIfPresent(String.self, forKey: .adult_tripple_sharing)
        child_with_bed = try values.decodeIfPresent(String.self, forKey: .child_with_bed)
        child_without_bed = try values.decodeIfPresent(String.self, forKey: .child_without_bed)
        joining_directly = try values.decodeIfPresent(String.self, forKey: .joining_directly)
        single_suppliment = try values.decodeIfPresent(String.self, forKey: .single_suppliment)
        service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
        tcs = try values.decodeIfPresent(String.self, forKey: .tcs)
        highlights = try values.decodeIfPresent(String.self, forKey: .highlights)
        inclusions = try values.decodeIfPresent(String.self, forKey: .inclusions)
        exclusions = try values.decodeIfPresent(String.self, forKey: .exclusions)
        terms = try values.decodeIfPresent(String.self, forKey: .terms)
        canc_policy = try values.decodeIfPresent(String.self, forKey: .canc_policy)
        banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
        gallery = try values.decodeIfPresent(String.self, forKey: .gallery)
        image_description = try values.decodeIfPresent(String.self, forKey: .image_description)
        //		inclusions_checks = try values.decodeIfPresent([String].self, forKey: .inclusions_checks)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        perfect_holidays = try values.decodeIfPresent(String.self, forKey: .perfect_holidays)
        agent_id = try values.decodeIfPresent(String.self, forKey: .agent_id)
        admin_approve_status = try values.decodeIfPresent(String.self, forKey: .admin_approve_status)
        agent_request_status = try values.decodeIfPresent(String.self, forKey: .agent_request_status)
        added_by = try values.decodeIfPresent(String.self, forKey: .added_by)
        supplier_name = try values.decodeIfPresent(String.self, forKey: .supplier_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        trip_notes = try values.decodeIfPresent(String.self, forKey: .trip_notes)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        status_delete = try values.decodeIfPresent(String.self, forKey: .status_delete)
        tour_id = try values.decodeIfPresent(String.self, forKey: .tour_id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isocode = try values.decodeIfPresent(String.self, forKey: .isocode)
        continent = try values.decodeIfPresent(String.self, forKey: .continent)
        cityCode = try values.decodeIfPresent(String.self, forKey: .cityCode)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        publish_status = try values.decodeIfPresent(String.self, forKey: .publish_status)
        tour_code = try values.decodeIfPresent(String.self, forKey: .tour_code)
        dep_date = try values.decodeIfPresent(String.self, forKey: .dep_date)
        no_of_seats = try values.decodeIfPresent(String.self, forKey: .no_of_seats)
        total_booked = try values.decodeIfPresent(String.self, forKey: .total_booked)
        available_seats = try values.decodeIfPresent(String.self, forKey: .available_seats)
        booking_hold = try values.decodeIfPresent(String.self, forKey: .booking_hold)
        tour_visited_city_id = try values.decodeIfPresent(String.self, forKey: .tour_visited_city_id)
        itinerary = try values.decodeIfPresent(String.self, forKey: .itinerary)
        sightseeing = try values.decodeIfPresent(String.self, forKey: .sightseeing)
        no_of_nights = try values.decodeIfPresent(String.self, forKey: .no_of_nights)
        includes_city_tours = try values.decodeIfPresent(String.self, forKey: .includes_city_tours)
        reporting = try values.decodeIfPresent(String.self, forKey: .reporting)
        reporting_date = try values.decodeIfPresent(String.self, forKey: .reporting_date)
        reporting_desc = try values.decodeIfPresent(String.self, forKey: .reporting_desc)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        adult_price = try values.decodeIfPresent(String.self, forKey: .adult_price)
        child_price = try values.decodeIfPresent(String.self, forKey: .child_price)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}
