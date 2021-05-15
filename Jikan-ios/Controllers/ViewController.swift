//
//  ViewController.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var animesCollectionView: UICollectionView!
    @IBOutlet weak var seasonLastTableView: UITableView!
    
    private var animesViewModel: AnimesViewModel!
    private var dataSource : AnimeCollectionViewDataSource<AnimeCollectionViewCell, AnimeData>!
    private var tableViewDataSource : SeasonLastTableViewDataSource<SeasonLastTableViewCell, SeasonLastData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        
        animesCollectionView.register(UINib(nibName: "AnimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topAnimeCollectionCell")
        
        seasonLastTableView.register(UINib(nibName: "SeasonLastTableViewCell", bundle: nil), forCellReuseIdentifier: "seasonLastCell")
        
        seasonLastTableView.rowHeight = UITableView.automaticDimension
        seasonLastTableView.estimatedRowHeight = 250
    }
    
    func callToViewModelForUIUpdate() {
        self.animesViewModel = AnimesViewModel()
        self.animesViewModel.bindAnimeViewModelToController = {
            self.updateDataSource()
        }
        
        self.animesViewModel.bindAnimeSeasonViewModelToController = {
            self.updateDataSourceSeasonLast()
        }
    }
    
    func updateDataSource() {
        
        self.dataSource = AnimeCollectionViewDataSource(cellIdentifier: "topAnimeCollectionCell", items: self.animesViewModel.animeData.top, configureCell: { (cell, anime) in
            
            let url = URL(string: anime.imageUrl)!
            cell.animeImage.kf.indicatorType = .activity
            cell.animeImage.kf.setImage(with: url)
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 0.0
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
        })
        
        DispatchQueue.main.async {
            self.animesCollectionView.dataSource = self.dataSource
            self.animesCollectionView.reloadData()
        }
    }
    
    func updateDataSourceSeasonLast() {
           
        if let seasonLastData = self.animesViewModel.seasonData.anime {
            self.tableViewDataSource = SeasonLastTableViewDataSource(cellIdentifier: "seasonLastCell", items: seasonLastData, configureCell: { (cell, season) in
                
                let url = URL(string: season.imageUrl ?? "Null")!
                cell.seasonImage.kf.indicatorType = .activity
                cell.seasonImage.kf.setImage(with: url)
                cell.animeTitle.text = season.title
                cell.sinopsis.text = season.synopsis!
                cell.source.text = season.source!
                cell.type.text = season.type
            })
            
            DispatchQueue.main.async {
                self.seasonLastTableView.dataSource = self.tableViewDataSource
                self.seasonLastTableView.reloadData()
            }
        }
    }
}
