//
//  AnimeCollectionViewCell.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 14/05/21.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        animeImage.layer.cornerRadius = 15.0
    }
    
    @IBAction func animePressed(_ sender: Any) {
    }
}

