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
    
    var bindAnimeViewModelToController : (() -> ()) = {}
        
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetAnimeData()
    }
    
    func callFuncToGetAnimeData() {
        self.apiService.getTopAnimes(page: 1) { (animeData) in
            self.animeData = animeData
        }
    }
}
