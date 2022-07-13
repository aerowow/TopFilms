//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

class ListCinemaVC: UIViewController {
    
    var apiService = ApiService()
    let tableView = UITableView()
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kinopoisk"
        configureTableView()
        apiService.getPopularMoviesData { (result) in
            print(result)
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.pin(to: view)
        tableView.register(CinemaCell.self, forCellReuseIdentifier: CinemaCell.cellIdentifier())
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListCinemaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    
    // indexPath - местоположение нашей ячейки. У него есть поля row(строка) и section(секция)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.cellIdentifier(), for: indexPath) as! CinemaCell
        
        let cinema = films[indexPath.row]
        
        //        cell.textLabel?.text = cinema.nameRu
        cell.detailTextLabel?.text = cinema.nameEn
        cell.imageView?.image = #imageLiteral(resourceName: "swiftLogo.jpeg")
        cell.videoTitleLabel.text = cinema.nameRu
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell tapped")
    }
}
