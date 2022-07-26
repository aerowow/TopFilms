//
//  DetailViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 24.07.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func getMoviesDescription(films: [Film])
}

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    var presenter: DetailPresenterProtocol?
    var films: [Film] = [Film]()

    
    
    
    // MARK: - Private UI Elements
    private let imageView = UIImageView()
    private let filmNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var urlString: String = ""
    
    func getMoviesDescription(films: [Film]) {
        self.films = films
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupFilmNameLabel()
        setupDescription()
        presenter?.fetchDescriptionFilm()
    }
}

// MARK: - SetupUI Elements
private extension DetailViewController {
    
    
    
    func setupImageView() {
        let image = UIImage(named: "noImageAvailable")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupFilmNameLabel() {
        filmNameLabel.text = "Film Name"
        filmNameLabel.font = .systemFont(ofSize: 35, weight: .bold)
        
        filmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filmNameLabel)
        
        NSLayoutConstraint.activate([
            filmNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            filmNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filmNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupDescription() {
        descriptionLabel.text = "We present an automatic framework for extracting, interpreting and generating linked data from tables. In the process of representing tables as linked data, we assign every column header a class label from an appropriate ontology, link table cells (if appropriate) to an entity from the Linked Open Data cloud and"
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
}