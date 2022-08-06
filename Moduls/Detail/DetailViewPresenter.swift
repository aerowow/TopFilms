//
//  DetailPresenter.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 24.07.2022.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol {
    func fetchDescriptionFilm(filmId: String)
}

class DetailViewPresenter: DetailPresenterProtocol {
    
    weak var viewController: DetailViewControllerProtocol?
    private var apiService = NetworkManager()
    private var popularFilms = [Film]()
    
    init(viewController: DetailViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchDescriptionFilm(filmId: String) {
        apiService.getMoviesDescription(movieDescriptionURL: "https://kinopoiskapiunofficial.tech/api/v2.2/films/", filmId: filmId) { [weak self] result in
            
            switch result {
            case .success(let film):
                self?.viewController?.updateUI(model: film)
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
