//
//  AnimeDetailViewModel.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import Foundation

class AnimesDetailViewModel: NSObject {
    
    private var apiService: APIService!
    private(set) var animeDetail : Anime! {
        didSet {
            self.bindAnimeDetailViewModelToController()
        }
    }
    
    var bindAnimeDetailViewModelToController : (() -> ()) = { }
        
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    func callFuncToGetAnimeData(id: Int) {
        self.apiService.getAnimeById(id: id) { (animeDetail) in
            self.animeDetail = animeDetail
        }
    }
}

