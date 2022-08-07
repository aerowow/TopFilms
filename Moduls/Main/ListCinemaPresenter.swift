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
    var isFetching: Bool { get set }
    func fetchPopularMoviesData()
    func beginBatchFetch()
    
}

class ListCinemaPresenter: ListCinemaPresenterProtocol {
    
    weak var viewController: ListCinemaViewControllerProtocol?
    private var apiService = NetworkManager()
    var popularFilms: [Film] = []
    var isFetching = false
    var pageCounter = 1
    
    init(viewController: ListCinemaViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchPopularMoviesData() {
        apiService.getPopularMoviesData(page: pageCounter) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.popularFilms += model.films
                self?.viewController?.reloadData()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            
            self?.isFetching = false
            
        }
    }
    func beginBatchFetch() {
        isFetching = true
        pageCounter += 1
        fetchPopularMoviesData()
    }
}
