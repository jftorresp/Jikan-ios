//
//  Anime.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import Foundation

//MARK: - Anime
struct Anime: Decodable {
    
    let id: Int
    let score: Double?
    let rank, episodes, scoredBy: Int?
    let title, url, imageUrl, type, source, status, duration, rating, synopsis: String?
    let airing: Bool?
    let aired: Aired
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case scoredBy = "scored_by"
        case imageUrl = "image_url"
        case title
        case url
        case type
        case source
        case status
        case aired
        case airing
        case duration
        case rating
        case score
        case rank
        case synopsis
        case genres
        case episodes
    }
}

struct Aired: Decodable {
    let from, to, dateString: String?
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case dateString = "string"
    }
}
