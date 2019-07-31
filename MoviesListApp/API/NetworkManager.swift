//
//  APIClient.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 19/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<APIService> { get }
    
    func getFilms(comletion: @escaping ([Film], String?) -> ())
}

struct NetworkManager: Networkable {
    static let shared = NetworkManager()
    private init() {}
    
    var provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getFilms(comletion: @escaping ([Film], String?) -> ()) {
        provider.request(.getFilms) { result in
            switch result {
            case let .success(response):
                let data = response.data
                if let mappedData = try? JSONDecoder().decode(FilmModel.self
                    , from: data),
                    let films = mappedData.films {
                    comletion(films, nil)
                } else {
                    comletion([], "Ошибка получения списка фильмов")
                }
            case let .failure(error):
                comletion([], error.localizedDescription)
            }
        }
    }
}
