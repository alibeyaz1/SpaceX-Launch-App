//
//  Launch.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import Foundation


struct Launch: Decodable {
    let links: Links
    let flightNumber: Int?
    let name: String
    let dateUTC: String
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let launchLibraryID: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case links, name, upcoming, cores, launchLibraryID, id
        case flightNumber = "flight_number"
        case dateUTC = "date_utc"
        case datePrecision = "date_precision"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        links = try container.decode(Links.self, forKey: .links)
        flightNumber = try container.decodeIfPresent(Int.self, forKey: .flightNumber)
        name = try container.decode(String.self, forKey: .name)
        dateUTC = try container.decode(String.self, forKey: .dateUTC)
        datePrecision = try container.decode(DatePrecision.self, forKey: .datePrecision)
        upcoming = try container.decode(Bool.self, forKey: .upcoming)
        cores = try container.decode([Core].self, forKey: .cores)
        launchLibraryID = try container.decodeIfPresent(String.self, forKey: .launchLibraryID)
        id = try container.decode(String.self, forKey: .id)
        
    }
}

struct Core: Codable {
    let landingAttempt, landingSuccess: Bool?
    let landingType: String?
    let landpad: String?

    enum CodingKeys: String, CodingKey {
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}


struct Links: Codable {
    let patch: Patch
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
   

    enum CodingKeys: String, CodingKey {
        case patch, webcast, presskit
        case youtubeID = "youtube_id"
    }
}

struct Patch: Codable {
    let small, large: String?
}

enum DatePrecision: String, Codable {
    case day = "day"
    case hour = "hour"
    case month = "month"
}
