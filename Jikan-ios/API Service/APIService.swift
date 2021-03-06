//
//  APIService.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import Foundation

class APIService: NSObject {
    
    private let apiURL = "https://api.jikan.moe/v3/"
    
    func getTopAnimes(page: Int, completion : @escaping (TopAnimes) -> ()){
        
        let url = URL(string: apiURL + "top/anime/\(page)/bypopularity")!
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let animeData = try! jsonDecoder.decode(TopAnimes.self, from: data)
                    completion(animeData)
            }
        }.resume()
    }
    
    func getSeasonLast(completion : @escaping (SeasonsLast) -> ()){
        
        let url = URL(string: apiURL + "season/later")!
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let animeData = try! jsonDecoder.decode(SeasonsLast.self, from: data)
                    completion(animeData)
            }
        }.resume()
    }
    
    func getAnimeById(id: Int, completion : @escaping (Anime) -> ()){
        
        let url = URL(string: apiURL + "anime/\(id)")!
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let animeData = try! jsonDecoder.decode(Anime.self, from: data)
                    completion(animeData)
            }
        }.resume()
    }
}
