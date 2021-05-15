//
//  AnimeCollectionViewDataSource.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import Foundation
import UIKit

class AnimeCollectionViewDataSource<Cell: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (Cell, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (Cell, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
       
       let item = self.items[indexPath.row]
       self.configureCell(cell, item)
       return cell
    }
        
                
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle Tap
    }
    
}
