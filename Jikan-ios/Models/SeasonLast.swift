//
//  SeasonLater.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import Foundation

//MARK: - SeasonLater
struct SeasonsLast: Decodable {
    
    let request_hash: String
    let anime: [SeasonLastData]?
}

//MARK: - SeasonLastData
struct SeasonLastData: Decodable {
    
    let id, members: Int
    let episodes: Int?
    let genres, producers: [Genre]?
    let score: Double?
    let title, url, imageUrl, synopsis, type, source, airingStart: String?
    let r18, kids, continuing: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case episodes
        case members
        case title
        case url
        case genres
        case producers
        case synopsis
        case source
        case score
        case r18
        case kids
        case continuing
        case imageUrl = "image_url"
        case type
        case airingStart = "airing_start"
    }
}

struct Genre: Decodable {
    
    let id: Int
    let type, name, url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case type
        case name
        case url
    }
}
