//
//  AnimesViewModel.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import Foundation

class AnimesViewModel: NSObject {
    
    private var apiService: APIService!
    private(set) var animeData : Animes! {
        didSet {
            self.bindAnimeViewModelToController()
        }
    }
    
    private(set) var seasonData : SeasonsLast! {
        didSet {
            self.bindAnimeSeasonViewModelToController()
        }
    }
    
    var bindAnimeViewModelToController : (() -> ()) = {}
    var bindAnimeSeasonViewModelToController : (() -> ()) = {}

        
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetAnimeData()
        callFuncToGetSeasonLastData()
    }
    
    func callFuncToGetAnimeData() {
        self.apiService.getTopAnimes(page: 1) { (animeData) in
            self.animeData = animeData
        }
    }
    
    func callFuncToGetSeasonLastData() {
        self.apiService.getSeasonLast { (seasonData) in
            self.seasonData = seasonData
        }
    }
}
