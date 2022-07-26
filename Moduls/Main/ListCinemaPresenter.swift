//
//  MovieViewModel.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 13.07.2022.
//

import Foundation
import UIKit

protocol ListCinemaPresenterProtocol {
    func fetchPopularMoviesData()
}

class ListCinemaPresenter: ListCinemaPresenterProtocol  {
    
    weak var viewController: ListCinemaViewControllerProtocol?
    private var apiService = NetworkManager()
    private var popularFilms = [Film]()
    
    init(viewController: ListCinemaViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchPopularMoviesData() {
        apiService.getPopularMoviesData { [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.viewController?.giveMeData(films: listOf.films)
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    
}
