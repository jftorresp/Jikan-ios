//
//  SearchAnimesViewController.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import UIKit

class SearchAnimesViewController: UIViewController {

    // Outlets
    @IBOutlet weak var animesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Atributes
    private var animesViewModel: AnimesViewModel!
    private var animeDetailViewModel: AnimesDetailViewModel!
    var filteredAnimes: [TopAnimeData]!
    
    let searchBarMessage = UILabel()
    
    private var dataSource : AnimeCollectionViewDataSource<AnimeCollectionViewCell, TopAnimeData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarMessage.text = "Type the title of the anime you're looking for"
        searchBarMessage.textAlignment = .center
        searchBarMessage.sizeToFit()
        searchBarMessage.center = self.view.center
        self.view.addSubview(searchBarMessage)
        
        callToViewModelForUIUpdate()

        self.animesCollectionView.delegate = self
        searchBar.delegate = self

        animesCollectionView.register(UINib(nibName: "AnimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topAnimeCollectionCell")

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Binds the data with the ViewModel
    func callToViewModelForUIUpdate() {
        self.animesViewModel = AnimesViewModel()
        self.animesViewModel.bindAnimeViewModelToController = {
            self.filteredAnimes = self.animesViewModel.animeData.top
        }
        
    }
    
    // Updates de dataSource of the CollectionView
    func updateDataSource() {
        
        // In this case the cells are created with the filteredAnimes, an initial copy of the data fetched.
        self.dataSource = AnimeCollectionViewDataSource(cellIdentifier: "topAnimeCollectionCell", items: filteredAnimes, configureCell: { (cell, anime) in
            
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
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UICollectionViewDelegate methods
extension SearchAnimesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.animeDetailViewModel = AnimesDetailViewModel()
        self.animeDetailViewModel.callFuncToGetAnimeData(id: filteredAnimes[indexPath.row].id)
        self.animeDetailViewModel.bindAnimeDetailViewModelToController = {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = (storyboard.instantiateViewController(withIdentifier: "animeDetailViewController") as? AnimeDetailViewController)!
                vc.anime = self.animeDetailViewModel.animeDetail
                
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}

//MARK: - UISearchBarDelegate methods
extension SearchAnimesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredAnimes = searchText.isEmpty ? self.animesViewModel.animeData.top : self.animesViewModel.animeData.top.filter { (item: TopAnimeData) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        // Shows message indicating no matching criteria and adds the label to the viewController
        if filteredAnimes.count == 0 {
            searchBarMessage.text = "No matching animes"
            searchBarMessage.textAlignment = .center
            searchBarMessage.sizeToFit()
            searchBarMessage.center = self.view.center
            self.view.addSubview(searchBarMessage)
        } else if (filteredAnimes.count > 0){
            searchBarMessage.removeFromSuperview()
        }
             
        // Updates the collectionView with the filtered data
        DispatchQueue.main.async {
            self.animesCollectionView.reloadData()
            self.updateDataSource()
        }
    }
    
    // Dismisses keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
}
