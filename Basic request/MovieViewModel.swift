//
//  MovieViewModel.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 13.07.2022.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var popularFilms = [Film]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData { (result) in
            
            switch result {
            case .success(let listOf):
                self.popularFilms = listOf.films
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
