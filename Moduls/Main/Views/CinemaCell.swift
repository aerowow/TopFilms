//
//  CinemaCell.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit
import Kingfisher

class CinemaCell: UITableViewCell {
    
    var videoImageView = UIImageView()
    var videoTitleLabel = UILabel()
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
    
    
    func configureImageView() {
        videoImageView.layer.cornerRadius = 10
        videoImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        videoTitleLabel.font = .systemFont(ofSize: 20)
        videoTitleLabel.numberOfLines = 2
        videoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        addSubview(videoImageView)
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        videoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        videoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func setTitleLabelConstraints() {
        addSubview(videoTitleLabel)
        
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        videoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 20).isActive = true
        videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    //Update the UI Views
    func updateUI(film: Film) {
        
        self.videoTitleLabel.text = film.nameRu
        
        guard let posterImageURL = URL(string: film.posterUrl ?? "") else {
            self.videoImageView.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.videoImageView.image = nil
        videoImageView.kf.setImage(with: posterImageURL, placeholder: UIImage(named: "noImageAvailable"), options: [.transition(.fade(0.7))], progressBlock: nil)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            // Handle error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                //Handle Empty Data
                print("Empty Data")
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView?.image = UIImage(data: data)
            }
        } .resume()
    }
}

extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
