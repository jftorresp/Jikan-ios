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
    
    private var animesViewModel: AnimesViewModel!
    private var dataSource : AnimeCollectionViewDataSource<AnimeCollectionViewCell, AnimeData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        
        animesCollectionView.register(UINib(nibName: "AnimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topAnimeCollectionCell")
    }
    
    func callToViewModelForUIUpdate() {
        self.animesViewModel = AnimesViewModel()
        self.animesViewModel.bindAnimeViewModelToController = {
            self.updateDataSource()
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
}
