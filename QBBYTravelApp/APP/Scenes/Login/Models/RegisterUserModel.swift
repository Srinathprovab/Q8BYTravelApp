//
//  RegisterUserModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation



struct RegisterUserModel : Codable {
    let status : Bool?
    let data : RegisterUserModelData?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(RegisterUserModelData.self, forKey: .data)
    }
    
}




struct RegisterUserModelData : Codable {
    
    let user_id : String?
    let domain_list_fk : String?
    let uuid : String?
    let user_name_type : String?
    let user_type : String?
    let usertype : String?
    let email : String?
    let password : String?
    let status : String?
    let date_of_birth : String?
    let gender : String?
    let image : String?
    let title : String?
    let agency_name : String?
    let agency_licence_number : String?
    let company_file : String?
    let agent_name : String?
    let first_name : String?
    let last_name : String?
    let address : String?
    let address2 : String?
    let country_code : String?
    let country_name : String?
    let state_origin : String?
    let state_name : String?
    let city_origin : String?
    let city_name : String?
    let pin_code : String?
    let phone_code : String?
    let phone_country : String?
    let phone : String?
    let office_phone : String?
    let pan_number : String?
    let pan_image : String?
    let about_us : String?
    let creation_source : String?
    let created_datetime : String?
    let created_by_id : String?
    let last_password_updated_date : String?
    let group_fk : String?
    let language_preference : String?
    let enable_agent_login : String?
    let signature : String?
    let iata_code : String?
    let reward_point_earned : String?
    let fax_no : String?
    let arc_no : String?
    let clia_no : String?
    let agency_url : String?
    let business_type : String?
    let mailing_street_address : String?
    let mailing_city_name : String?
    let mailing_country_code : String?
    let mailing_state_name : String?
    let mailing_pin_code : String?
    let mailing_phone : String?
    let hba : String?
    let host : String?
    let asta : String?
    let other : String?
    let sabre : String?
    let galileo : String?
    let worldspan : String?
    let amadeus : String?
    let agent_emp_type : String?
    let agent_consortium : String?
    let payment_privilege_action : String?
    let general_reward : String?
    let pending_reward : String?
    let spefic_reward : String?
    let used_reward : String?
    let business_name : String?
    let ein : String?
    let business_address : String?
    let business_city_origin : String?
    let business_city_name : String?
    let business_state_origin : String?
    let business_state_name : String?
    let business_pin_code : String?
    let acceptance_message : String?
    let w_9 : String?
    let driving_license : String?
    let driver_licence_state : String?
    let security_card : String?
    let new_york : String?
    let hawali : String?
    let california : String?
    let lowa : String?
    let wire_information : String?
    let e_o_insurance : String?
    let agent_form_submission : String?
    let background_check : String?
    let credit_check : String?
    let driver_licence_number : String?
    let deposit : String?
    let social_security : String?
    let modified_datetime : String?
    let activation_link : String?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case domain_list_fk = "domain_list_fk"
        case uuid = "uuid"
        case user_name_type = "user_name_type"
        case user_type = "user_type"
        case usertype = "usertype"
        case email = "email"
        case password = "password"
        case status = "status"
        case date_of_birth = "date_of_birth"
        case gender = "gender"
        case image = "image"
        case title = "title"
        case agency_name = "agency_name"
        case agency_licence_number = "agency_licence_number"
        case company_file = "company_file"
        case agent_name = "agent_name"
        case first_name = "first_name"
        case last_name = "last_name"
        case address = "address"
        case address2 = "address2"
        case country_code = "country_code"
        case country_name = "country_name"
        case state_origin = "state_origin"
        case state_name = "state_name"
        case city_origin = "city_origin"
        case city_name = "city_name"
        case pin_code = "pin_code"
        case phone_code = "phone_code"
        case phone_country = "phone_country"
        case phone = "phone"
        case office_phone = "office_phone"
        case pan_number = "pan_number"
        case pan_image = "pan_image"
        case about_us = "about_us"
        case creation_source = "creation_source"
        case created_datetime = "created_datetime"
        case created_by_id = "created_by_id"
        case last_password_updated_date = "last_password_updated_date"
        case group_fk = "group_fk"
        case language_preference = "language_preference"
        case enable_agent_login = "enable_agent_login"
        case signature = "signature"
        case iata_code = "iata_code"
        case reward_point_earned = "reward_point_earned"
        case fax_no = "fax_no"
        case arc_no = "arc_no"
        case clia_no = "clia_no"
        case agency_url = "agency_url"
        case business_type = "business_type"
        case mailing_street_address = "mailing_street_address"
        case mailing_city_name = "mailing_city_name"
        case mailing_country_code = "mailing_country_code"
        case mailing_state_name = "mailing_state_name"
        case mailing_pin_code = "mailing_pin_code"
        case mailing_phone = "mailing_phone"
        case hba = "hba"
        case host = "host"
        case asta = "asta"
        case other = "other"
        case sabre = "sabre"
        case galileo = "galileo"
        case worldspan = "worldspan"
        case amadeus = "amadeus"
        case agent_emp_type = "agent_emp_type"
        case agent_consortium = "agent_consortium"
        case payment_privilege_action = "Payment_privilege_action"
        case general_reward = "general_reward"
        case pending_reward = "pending_reward"
        case spefic_reward = "spefic_reward"
        case used_reward = "used_reward"
        case business_name = "business_name"
        case ein = "ein"
        case business_address = "business_address"
        case business_city_origin = "business_city_origin"
        case business_city_name = "business_city_name"
        case business_state_origin = "business_state_origin"
        case business_state_name = "business_state_name"
        case business_pin_code = "business_pin_code"
        case acceptance_message = "acceptance_message"
        case w_9 = "w_9"
        case driving_license = "driving_license"
        case driver_licence_state = "driver_licence_state"
        case security_card = "security_card"
        case new_york = "new_york"
        case hawali = "hawali"
        case california = "california"
        case lowa = "lowa"
        case wire_information = "wire_information"
        case e_o_insurance = "e_o_insurance"
        case agent_form_submission = "agent_form_submission"
        case background_check = "background_check"
        case credit_check = "credit_check"
        case driver_licence_number = "driver_licence_number"
        case deposit = "deposit"
        case social_security = "social_security"
        case modified_datetime = "modified_datetime"
        case activation_link = "activation_link"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        domain_list_fk = try values.decodeIfPresent(String.self, forKey: .domain_list_fk)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        user_name_type = try values.decodeIfPresent(String.self, forKey: .user_name_type)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        usertype = try values.decodeIfPresent(String.self, forKey: .usertype)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        agency_name = try values.decodeIfPresent(String.self, forKey: .agency_name)
        agency_licence_number = try values.decodeIfPresent(String.self, forKey: .agency_licence_number)
        company_file = try values.decodeIfPresent(String.self, forKey: .company_file)
        agent_name = try values.decodeIfPresent(String.self, forKey: .agent_name)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        state_origin = try values.decodeIfPresent(String.self, forKey: .state_origin)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_origin = try values.decodeIfPresent(String.self, forKey: .city_origin)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        pin_code = try values.decodeIfPresent(String.self, forKey: .pin_code)
        phone_code = try values.decodeIfPresent(String.self, forKey: .phone_code)
        phone_country = try values.decodeIfPresent(String.self, forKey: .phone_country)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        office_phone = try values.decodeIfPresent(String.self, forKey: .office_phone)
        pan_number = try values.decodeIfPresent(String.self, forKey: .pan_number)
        pan_image = try values.decodeIfPresent(String.self, forKey: .pan_image)
        about_us = try values.decodeIfPresent(String.self, forKey: .about_us)
        creation_source = try values.decodeIfPresent(String.self, forKey: .creation_source)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        last_password_updated_date = try values.decodeIfPresent(String.self, forKey: .last_password_updated_date)
        group_fk = try values.decodeIfPresent(String.self, forKey: .group_fk)
        language_preference = try values.decodeIfPresent(String.self, forKey: .language_preference)
        enable_agent_login = try values.decodeIfPresent(String.self, forKey: .enable_agent_login)
        signature = try values.decodeIfPresent(String.self, forKey: .signature)
        iata_code = try values.decodeIfPresent(String.self, forKey: .iata_code)
        reward_point_earned = try values.decodeIfPresent(String.self, forKey: .reward_point_earned)
        fax_no = try values.decodeIfPresent(String.self, forKey: .fax_no)
        arc_no = try values.decodeIfPresent(String.self, forKey: .arc_no)
        clia_no = try values.decodeIfPresent(String.self, forKey: .clia_no)
        agency_url = try values.decodeIfPresent(String.self, forKey: .agency_url)
        business_type = try values.decodeIfPresent(String.self, forKey: .business_type)
        mailing_street_address = try values.decodeIfPresent(String.self, forKey: .mailing_street_address)
        mailing_city_name = try values.decodeIfPresent(String.self, forKey: .mailing_city_name)
        mailing_country_code = try values.decodeIfPresent(String.self, forKey: .mailing_country_code)
        mailing_state_name = try values.decodeIfPresent(String.self, forKey: .mailing_state_name)
        mailing_pin_code = try values.decodeIfPresent(String.self, forKey: .mailing_pin_code)
        mailing_phone = try values.decodeIfPresent(String.self, forKey: .mailing_phone)
        hba = try values.decodeIfPresent(String.self, forKey: .hba)
        host = try values.decodeIfPresent(String.self, forKey: .host)
        asta = try values.decodeIfPresent(String.self, forKey: .asta)
        other = try values.decodeIfPresent(String.self, forKey: .other)
        sabre = try values.decodeIfPresent(String.self, forKey: .sabre)
        galileo = try values.decodeIfPresent(String.self, forKey: .galileo)
        worldspan = try values.decodeIfPresent(String.self, forKey: .worldspan)
        amadeus = try values.decodeIfPresent(String.self, forKey: .amadeus)
        agent_emp_type = try values.decodeIfPresent(String.self, forKey: .agent_emp_type)
        agent_consortium = try values.decodeIfPresent(String.self, forKey: .agent_consortium)
        payment_privilege_action = try values.decodeIfPresent(String.self, forKey: .payment_privilege_action)
        general_reward = try values.decodeIfPresent(String.self, forKey: .general_reward)
        pending_reward = try values.decodeIfPresent(String.self, forKey: .pending_reward)
        spefic_reward = try values.decodeIfPresent(String.self, forKey: .spefic_reward)
        used_reward = try values.decodeIfPresent(String.self, forKey: .used_reward)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        ein = try values.decodeIfPresent(String.self, forKey: .ein)
        business_address = try values.decodeIfPresent(String.self, forKey: .business_address)
        business_city_origin = try values.decodeIfPresent(String.self, forKey: .business_city_origin)
        business_city_name = try values.decodeIfPresent(String.self, forKey: .business_city_name)
        business_state_origin = try values.decodeIfPresent(String.self, forKey: .business_state_origin)
        business_state_name = try values.decodeIfPresent(String.self, forKey: .business_state_name)
        business_pin_code = try values.decodeIfPresent(String.self, forKey: .business_pin_code)
        acceptance_message = try values.decodeIfPresent(String.self, forKey: .acceptance_message)
        w_9 = try values.decodeIfPresent(String.self, forKey: .w_9)
        driving_license = try values.decodeIfPresent(String.self, forKey: .driving_license)
        driver_licence_state = try values.decodeIfPresent(String.self, forKey: .driver_licence_state)
        security_card = try values.decodeIfPresent(String.self, forKey: .security_card)
        new_york = try values.decodeIfPresent(String.self, forKey: .new_york)
        hawali = try values.decodeIfPresent(String.self, forKey: .hawali)
        california = try values.decodeIfPresent(String.self, forKey: .california)
        lowa = try values.decodeIfPresent(String.self, forKey: .lowa)
        wire_information = try values.decodeIfPresent(String.self, forKey: .wire_information)
        e_o_insurance = try values.decodeIfPresent(String.self, forKey: .e_o_insurance)
        agent_form_submission = try values.decodeIfPresent(String.self, forKey: .agent_form_submission)
        background_check = try values.decodeIfPresent(String.self, forKey: .background_check)
        credit_check = try values.decodeIfPresent(String.self, forKey: .credit_check)
        driver_licence_number = try values.decodeIfPresent(String.self, forKey: .driver_licence_number)
        deposit = try values.decodeIfPresent(String.self, forKey: .deposit)
        social_security = try values.decodeIfPresent(String.self, forKey: .social_security)
        modified_datetime = try values.decodeIfPresent(String.self, forKey: .modified_datetime)
        activation_link = try values.decodeIfPresent(String.self, forKey: .activation_link)
    }
    
}
