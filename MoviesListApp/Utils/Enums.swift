//
//  Enums.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 29/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit

enum RatingEnum {
    case awesome
    case good
    case bad
    
    static func from(rating: Double?) -> RatingEnum {
        guard let rating = rating else { return .bad }
        
        if rating >= 7.0 {
            return .awesome
        } else if rating >= 5.0 && rating < 7.0 {
            return .good
        } else {
            return .bad
        }
    }
    
    var color: UIColor {
        switch self {
        case .awesome:
            return #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        case .good:
            return #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        case .bad:
            return #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        }
    }
}
