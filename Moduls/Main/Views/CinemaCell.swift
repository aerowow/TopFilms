//
//  CinemaCell.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit
import Kingfisher

class CinemaCell: UITableViewCell {
    
    var filmImageView = UIImageView()
    var nameRuTitleLabel = UILabel()
    var nameEnTitleLabel = UILabel()
    var yearLabel = UILabel()
    var genreLabel = UILabel()
    var ratingLabel = UILabel()
    var countryLabel = UILabel()
    var lengthLabel = UILabel()
    
    
    private var urlString: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuring ImageView
    func configureImageView() {
        filmImageView.layer.cornerRadius = 5
        filmImageView.clipsToBounds = true
    }
    
    func setImageConstraints() {
        addSubview(filmImageView)
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        filmImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        filmImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    // MARK: - Configuring Labels
    func configureTitleLabel() {
        nameRuTitleLabel.font = .boldSystemFont(ofSize: 18)
        nameRuTitleLabel.adjustsFontSizeToFitWidth = true

        nameEnTitleLabel.font = .systemFont(ofSize: 15)
        nameEnTitleLabel.numberOfLines = 2
        
        yearLabel.font = .systemFont(ofSize: 15)
        
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
        ratingLabel.font = .systemFont(ofSize: 20)
        ratingLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
    }
    
    func setTitleLabelConstraints() {
        addSubview(nameRuTitleLabel)
        nameRuTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameEnTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameRuTitleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        nameRuTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(nameEnTitleLabel)
        nameEnTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameEnTitleLabel.topAnchor.constraint(equalTo: nameRuTitleLabel.bottomAnchor, constant: 5).isActive = true
        nameEnTitleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        nameEnTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.topAnchor.constraint(equalTo: nameRuTitleLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: nameEnTitleLabel.trailingAnchor, constant: 2).isActive = true
//        yearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.topAnchor.constraint(equalTo: nameEnTitleLabel.bottomAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 5).isActive = true
        
    }
    
    // MARK: - Update UI Views
    
    func updateUI(film: Film) {
        
        nameRuTitleLabel.text = film.nameRu
        nameEnTitleLabel.text = "\(film.nameEn ?? "") (\(film.year ?? ""))"
        ratingLabel.text = film.rating
        
        var element: [String] = []
        for genres in film.genres {
            element.append(genres.genre ?? "")
        }
        
        genreLabel.text = element.joined(separator: ", ")
        
        
        
        guard let posterImageURL = URL(string: film.posterUrl ?? "") else {
            filmImageView.image = UIImage(named: "noImageAvailable")
            return
        }
    
        
        // Before we download the image we clear out the old one
        filmImageView.image = nil
        filmImageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "noImageAvailable"), options: [.transition(.fade(0.7))], progressBlock: nil)
    }
}

extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
