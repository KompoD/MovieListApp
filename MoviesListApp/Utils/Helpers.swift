//
//  Helpers.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 29/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit

final class Helpers {
    static func getRatingColor(_ rating: Double?) -> UIColor {
        guard let rating = rating else { return RatingEnum.bad.color }
        
        if rating >= 7.0 {
            return RatingEnum.awesome.color
        } else if rating >= 5.0 && rating < 7.0 {
            return RatingEnum.good.color
        } else if rating < 5.0 {
            return RatingEnum.bad.color
        }
        return RatingEnum.bad.color
    }
}
