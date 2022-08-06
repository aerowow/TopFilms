//
//  MovieViewModel.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 13.07.2022.
//

import Foundation
//import UIKit

protocol ListCinemaPresenterProtocol {
    var popularFilms: [Film] { get set }
    func fetchPopularMoviesData()
}

class ListCinemaPresenter: ListCinemaPresenterProtocol {
    
    weak var viewController: ListCinemaViewControllerProtocol?
    private var apiService = NetworkManager()
    var popularFilms: [Film] = []
    
    init(viewController: ListCinemaViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchPopularMoviesData() {
        apiService.getPopularMoviesData { [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.popularFilms = listOf.films
                self?.viewController?.giveMeData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
