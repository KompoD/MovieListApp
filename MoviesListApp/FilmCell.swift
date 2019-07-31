//
//  FilmCell.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 29/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    @IBOutlet weak var localizedNameLabel: UILabel!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setupCell(with film: Film) {
        localizedNameLabel.text = film.localizedName ?? "Нет названия"
        originalNameLabel.text = film.name ?? "No name"
        ratingLabel.text = "\(film.rating ?? 0.0)"
        ratingLabel.textColor = RatingEnum.from(rating: film.rating).color
    }
}
