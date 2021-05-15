//
//  AnimeCollectionViewDelegate.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import Foundation
import UIKit

class AnimeCollectionViewDelegate<T>: NSObject, UICollectionViewDelegate {
    
    private var items : [T]!
    var didTap : (T) -> () = { _ in }
    
    init(items : [T], didTap : @escaping (T) -> ()) {
        self.items =  items
        self.didTap = didTap
    }
                
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.items[indexPath.row]
        self.didTap(item)
    }
}
