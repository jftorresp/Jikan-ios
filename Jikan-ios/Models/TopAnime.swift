//
//  Anime.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import Foundation

//MARK: - TopAnimes
struct TopAnimes: Decodable {
    
    let request_hash: String
    let top: [TopAnimeData]
}

//MARK: - TopAnimeData
struct TopAnimeData: Decodable {
    
    let id: Int
    let title, imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case imageUrl = "image_url"
    }
}


