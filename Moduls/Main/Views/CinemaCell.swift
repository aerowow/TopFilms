//
//  CinemaCell.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit
import Kingfisher

final class CinemaCell: UITableViewCell {
    
    private let filmImageView: UIImageView = {
        let filmImageView = UIImageView()
        filmImageView.layer.cornerRadius = 5
        filmImageView.clipsToBounds = true
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
       return filmImageView
    }()
    
    private let nameRuTitleLabel: UILabel = {
        let nameRuTitleLabel = UILabel()
        nameRuTitleLabel.font = .boldSystemFont(ofSize: 18)
        nameRuTitleLabel.adjustsFontSizeToFitWidth = true
        nameRuTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameRuTitleLabel
    }()
    
    private let nameEnTitleLabel: UILabel = {
        let nameEnTitleLabel = UILabel()
        nameEnTitleLabel.font = .systemFont(ofSize: 15)
        nameEnTitleLabel.numberOfLines = 2
        nameEnTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameEnTitleLabel
    }()
    
    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.font = .systemFont(ofSize: 15)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
    }()
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 20)
        ratingLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    private let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.font = .systemFont(ofSize: 15)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    
    private let lengthLabel: UILabel = {
        let lengthLabel = UILabel()
        lengthLabel.font = .systemFont(ofSize: 15)
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        return lengthLabel
    }()
    
    
    private var urlString: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuring ImageView
    
    private func addSubviews() {
        let views = [filmImageView,
                     nameRuTitleLabel,
                     nameEnTitleLabel,
                     yearLabel,
                     genreLabel,
                     ratingLabel,
                     lengthLabel,
                     countryLabel]
        contentView.addSubviews(views)
    }
    
   private func setImageConstraints() {
        filmImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        filmImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    // MARK: - Configuring Labels
    
   private func setTitleLabelConstraints() { //сделать через массив
        nameRuTitleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        nameRuTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        nameEnTitleLabel.topAnchor.constraint(equalTo: nameRuTitleLabel.bottomAnchor, constant: 5).isActive = true
        nameEnTitleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        nameEnTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        yearLabel.topAnchor.constraint(equalTo: nameRuTitleLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: nameEnTitleLabel.trailingAnchor, constant: 2).isActive = true
        
        genreLabel.topAnchor.constraint(equalTo: nameEnTitleLabel.bottomAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    
        ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        
        lengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        lengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        
        
        countryLabel.trailingAnchor.constraint(equalTo: lengthLabel.leadingAnchor, constant: -10).isActive = true
        countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5).isActive = true
        countryLabel.textAlignment = .right
       
        lengthLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
    }
    
    // MARK: - Update UI Views
    
    func updateUI(film: Film) {
        
        nameRuTitleLabel.text = film.nameRu
        nameEnTitleLabel.text = "\(film.nameEn ?? "") (\(film.year ?? ""))" // логика в презеторе
        lengthLabel.text = film.filmLength
        
        //let rating = film.rating
        //ratingLabel.text = rating
        ratingLabel.text = film.rating
        
        //чделать через switch case
        if Double(ratingLabel.text ?? "") ?? 0.0 > 7.0 {
            ratingLabel.textColor = .green
        } else if Double(ratingLabel.text ?? "") ?? 0.0 < 5.0 {
            ratingLabel.textColor = .red
        } else {
            ratingLabel.textColor = .darkGray
        }
        
        var element: [String] = []
        //обыграть это в presenter
        for genres in film.genres {
            element.append(genres.genre ?? "")
        }
        genreLabel.text = element.joined(separator: ", ")
        
        //обыграть это в presenter
        var countryElement: [String] = []
        for countries in film.countries {
            countryElement.append(countries.country ?? "")
        }
        countryLabel.text = countryElement.joined(separator: ", ")
        
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
