//
//  APIService.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 19/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import Moya

enum APIService {
    case getFilms
}

extension APIService: TargetType {
    var baseURL: URL { return URL(string: Constants.apiUrl)! }
    
    var path: String {
        switch self {
        case .getFilms:
            return "/films.json"
        }
    }
    
    var method: Method { return .get }
    
    var sampleData: Data { return Data() }
    
    var task: Task { return .requestPlain }
    
    var headers: [String : String]? { return ["Content-type": "application/json", "Cache-Control": "no-cache"] }
}
