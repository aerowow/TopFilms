//
//  DetailViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 24.07.2022.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func updateUI(model: FilmDescription)
}

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    func updateUI(model: FilmDescription) {
        filmNameLabel.text = model.nameRu
        descriptionLabel.text = model.description
        
        guard let posterImageURL = URL(string: model.posterUrl ?? "") else {
            return imageView.image = UIImage(named: "noImageAvailable")
        }
        
        imageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "noImageAvailable"), options: [.transition(.fade(0.7))], progressBlock: nil)
    }
    
    var presenter: DetailPresenterProtocol?
    

    // MARK: - Private UI Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "noImageAvailable")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filmNameLabel: UILabel =  {
        let filmNameLabel = UILabel()
        filmNameLabel.font = .systemFont(ofSize: 35, weight: .bold)
        filmNameLabel.adjustsFontSizeToFitWidth = true
        filmNameLabel.textColor = .label
        filmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return filmNameLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        addSubviews()
        setupConstraints()
    }
}

// MARK: - SetupUI Elements
private extension DetailViewController {
    
    private func addSubviews() {
        view.addSubview(scrollView)
        let views = [imageView, filmNameLabel, descriptionLabel]
        scrollView.addSubviews(views)
    }
    
   private func setupConstraints() {

        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 550),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            filmNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            filmNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            filmNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

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
