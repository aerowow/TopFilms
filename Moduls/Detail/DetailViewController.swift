//
//  DetailViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 24.07.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func updateUI(model: Film)
}

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    func updateUI(model: Film) {
        filmNameLabel.text = model.nameRu
        descriptionLabel.text = model.description
        
        guard let posterImageURL = URL(string: model.posterUrl ?? "") else {
            return imageView.image = UIImage(named: "noImageAvailable")
        }
        
        imageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "noImageAvailable"), options: [.transition(.fade(0.7))], progressBlock: nil)
    }
    
    
    var presenter: DetailPresenterProtocol?
    var films: [Film] = [Film]()
    
    var hello = "hello"

    
    
    // MARK: - Private UI Elements
    private let imageView = UIImageView()
    private let filmNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var urlString: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupFilmNameLabel()
        setupDescription()
        hello = "gay"
    }
}

// MARK: - SetupUI Elements
private extension DetailViewController {
    
    
    
    func setupImageView() {
        let image = UIImage(named: "noImageAvailable")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
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
    //Update the UI Views
    func updateUI(nameRu: String?, posterURL: String?, description: String?) {
        self.filmNameLabel.text = nameRu

        guard let posterImageURL = URL(string: posterURL ?? "") else {
            self.imageView.image = UIImage(named: "noImageAvailable")
            return
        }

        // Before we download the image we clear out the old one
        self.imageView.image = nil
        imageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "noImageAvailable"), options: [.transition(.fade(0.7))], progressBlock: nil)

    }
}
    

