//
//  SeasonLastTableViewCell.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import UIKit

class SeasonLastTableViewCell: UITableViewCell {

    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var sinopsis: UILabel!
    @IBOutlet weak var source: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        typeView.layer.cornerRadius = 8.0
        seasonImage.layer.cornerRadius = 15.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
