//
//  MovieViewModel.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 13.07.2022.
//

import Foundation
import UIKit

class Presenter {
    
    weak var viewController: ListCinemaVC?
    private var apiService = ApiService()
    private var popularFilms = [Film]()
    
    
    
    func fetchPopularMoviesData() {
        
        apiService.getPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.viewController?.giveMeData(films: listOf.films)
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    
}
