//
//  DetailPresenter.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 24.07.2022.
//

import Foundation
import UIKit

protocol DetailPresenterProtocol {
    func fetchDescriptionFilm()
}

class DetailViewPresenter: DetailPresenterProtocol {
    
    weak var viewController: DetailViewControllerProtocol?
    private var apiService = NetworkManager()
    private var popularFilms = [Film]()
    
    init(viewController: DetailViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchDescriptionFilm() {
        apiService.getMoviesDescription(filmId: "301") { [weak self] result in
            
            switch result {
            case .success(let film):
                print("0")
            case.failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
