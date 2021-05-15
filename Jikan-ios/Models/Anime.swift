//
//  Anime.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import Foundation

//MARK: - AnimeData
struct Animes: Decodable {
    
    let request_hash: String
    let top: [AnimeData]
}

//MARK: - Anime
struct AnimeData: Decodable {
    
    let id, rank, members: Int
    let episodes: Int?
    let endDate: String?
    let score: Double?
    let title, url, imageUrl, type, startDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case rank
        case episodes
        case members
        case score
        case title
        case url
        case imageUrl = "image_url"
        case type
        case startDate = "start_date"
        case endDate = "end_date"
    }
}


