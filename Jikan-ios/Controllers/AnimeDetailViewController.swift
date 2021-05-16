//
//  AnimeDetailViewController.swift
//  Jikan-ios
//
//  Created by Juan Felipe Torres on 15/05/21.
//

import UIKit
import Kingfisher

class AnimeDetailViewController: UIViewController {
    
    // Attributes that receives the data from the selected anime in the initial view controller
    var anime: Anime?

    // Outlets
    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreByLabel: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromView.layer.cornerRadius = 10.0
        toView.layer.cornerRadius = 10.0
        animeImage.layer.cornerRadius = 10.0
        
        let url = URL(string: anime!.imageUrl!)!
        animeImage.kf.indicatorType = .activity
        animeImage.kf.setImage(with: url)
        
        animeTitle.text = anime?.title
        UIView.animate(withDuration: 5) {
            self.animeTitle.frame = CGRect(x: 220, y: 350, width: 200, height: 20)
        }

        let delimiter = "to"
        let fromString = anime?.aired.dateString!.components(separatedBy: delimiter)
        fromLabel.text = fromString![0]
        
        if (anime?.status == "Finished Airing" ) {
            toLabel.text = "Finished"
        } else {
            toLabel.text = "To Be Defined"
        }
        
        genresLabel.text = ""
        for i in 0..<(anime?.genres?.count)! {
            genresLabel.text! += (anime?.genres![i].name)! + ", "
        }
        
        durationLabel.text = anime?.duration
        
        if let score = anime?.score {
            if ((score) >= 0.0 && (score) <= 2.0) {
                firstStar.image = UIImage(systemName: "star.fill")
                secondStar.image = UIImage(systemName: "star")
                thirdStar.image = UIImage(systemName: "star")
                fourthStar.image = UIImage(systemName: "star")
                fifthStar.image = UIImage(systemName: "star")

            } else if ((score) > 2.0 && (score) <= 4.0) {
                firstStar.image = UIImage(systemName: "star.fill")
                secondStar.image = UIImage(systemName: "star.fill")
                thirdStar.image = UIImage(systemName: "star")
                fourthStar.image = UIImage(systemName: "star")
                fifthStar.image = UIImage(systemName: "star")
            }  else if (score > 4.0 && score <= 6.0) {
                firstStar.image = UIImage(systemName: "star.fill")
                secondStar.image = UIImage(systemName: "star.fill")
                thirdStar.image = UIImage(systemName: "star.fill")
                fourthStar.image = UIImage(systemName: "star")
                fifthStar.image = UIImage(systemName: "star")
            }  else if (score > 6.0 && score <= 8.0) {
                firstStar.image = UIImage(systemName: "star.fill")
                secondStar.image = UIImage(systemName: "star.fill")
                thirdStar.image = UIImage(systemName: "star.fill")
                fourthStar.image = UIImage(systemName: "star.fill")
                fifthStar.image = UIImage(systemName: "star")
            }  else if (score > 8.0 && score <= 10.0) {
                firstStar.image = UIImage(systemName: "star.fill")
                secondStar.image = UIImage(systemName: "star.fill")
                thirdStar.image = UIImage(systemName: "star.fill")
                fourthStar.image = UIImage(systemName: "star.fill")
                fifthStar.image = UIImage(systemName: "star.fill")
            }
            
            let scoreFormat = String(format: "%.2f", score)
            scoreLabel.text = scoreFormat
            scoreByLabel.text = "(\(anime?.scoredBy! ?? 0))"
        }
        
        synopsis.text = anime?.synopsis
        if let rank = anime?.rank {
            rankingLabel.text = "#\(rank)"
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "viewController") as? ViewController)!
        
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
        
    }
}
