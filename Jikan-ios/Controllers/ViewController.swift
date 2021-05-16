//
//  ViewController.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var animesCollectionView: UICollectionView!
    @IBOutlet weak var seasonLastTableView: UITableView!
    
    // ViewModels
    private var animesViewModel: AnimesViewModel!
    private var seasonLastViewModel: SeasonLastViewModel!
    private var animeDetailViewModel: AnimesDetailViewModel!
    
    // Atributes
    private var dataSource : AnimeCollectionViewDataSource<AnimeCollectionViewCell, TopAnimeData>!
    private var delegate : AnimeCollectionViewDelegate<TopAnimeData>!
    private var tableViewDataSource : SeasonLastTableViewDataSource<SeasonLastTableViewCell, SeasonLastData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animesCollectionView.delegate = self
        self.seasonLastTableView.delegate = self
        callToViewModelForUIUpdate()
        
        animesCollectionView.register(UINib(nibName: "AnimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topAnimeCollectionCell")
        
        seasonLastTableView.register(UINib(nibName: "SeasonLastTableViewCell", bundle: nil), forCellReuseIdentifier: "seasonLastCell")
        
        seasonLastTableView.rowHeight = UITableView.automaticDimension
        seasonLastTableView.estimatedRowHeight = 250
    }
    
    //MARK: - Update UI methods for CollectionView and TableView data
    
    func callToViewModelForUIUpdate() {
        self.animesViewModel = AnimesViewModel()
        self.animesViewModel.bindAnimeViewModelToController = {
            self.updateDataSource()
        }
        
        self.seasonLastViewModel = SeasonLastViewModel()
        self.seasonLastViewModel.bindAnimeSeasonViewModelToController = {
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
           
        if let seasonLastData = self.seasonLastViewModel.seasonData.anime {
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

//MARK: - UICollectionViewDelegate methods
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.animeDetailViewModel = AnimesDetailViewModel()
        self.animeDetailViewModel.callFuncToGetAnimeData(id: self.animesViewModel.animeData.top[indexPath.row].id)
        self.animeDetailViewModel.bindAnimeDetailViewModelToController = {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = (storyboard.instantiateViewController(withIdentifier: "animeDetailViewController") as? AnimeDetailViewController)!
                vc.anime = self.animeDetailViewModel.animeDetail
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UITableViewDelegate methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.animeDetailViewModel = AnimesDetailViewModel()
        self.animeDetailViewModel.callFuncToGetAnimeData(id: self.seasonLastViewModel.seasonData.anime![indexPath.row].id)
        self.animeDetailViewModel.bindAnimeDetailViewModelToController = {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = (storyboard.instantiateViewController(withIdentifier: "animeDetailViewController") as? AnimeDetailViewController)!
                vc.anime = self.animeDetailViewModel.animeDetail
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
