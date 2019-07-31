//
//  MovieDetailController.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 29/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController {
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var filmYearLabel: UILabel!
    @IBOutlet weak var filmRatingLabel: UILabel!
    @IBOutlet weak var filmDescriptionLabel: UILabel!
    
    var filmDetail: Film!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    private func setupScreen() {
        title = filmDetail.localizedName
        
        var attributedRating: NSMutableAttributedString {
            let rating = filmDetail.rating ?? 0.0
            let mainString = "Рейтинг: \(rating)"
            let stringToColor = "\(rating)"
            
            let range = (mainString as NSString).range(of: stringToColor)
            
            let ratingColor = RatingEnum.from(rating: rating).color
            
            let attributedRatingString = NSMutableAttributedString(string: mainString)
            attributedRatingString.addAttribute(.foregroundColor, value: ratingColor, range: range)
            return attributedRatingString
        }
        
        filmImageView.sd_setImage(with: URL(string: filmDetail.imageURL ?? ""), placeholderImage: UIImage(named: "PlaceholderImage"))
        filmRatingLabel.attributedText = attributedRating
        originalNameLabel.text = filmDetail.name ?? "Нет названия"
        filmYearLabel.text = "Год: \(filmDetail.year ?? 0)"
        filmDescriptionLabel.text = filmDetail.filmDescription ?? "Нет описания :("
    }
}
