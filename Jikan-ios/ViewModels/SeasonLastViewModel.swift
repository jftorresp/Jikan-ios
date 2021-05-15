//
//  SeasonLastViewModel.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import Foundation

class SeasonLastViewModel: NSObject {
    
    private var apiService: APIService!
    
    private(set) var seasonData : SeasonsLast! {
        didSet {
            self.bindAnimeSeasonViewModelToController()
        }
    }

    var bindAnimeSeasonViewModelToController : (() -> ()) = {}
        
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetSeasonLastData()
    }
        
    func callFuncToGetSeasonLastData() {
        self.apiService.getSeasonLast { (seasonData) in
            self.seasonData = seasonData
        }
    }
}
