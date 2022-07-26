//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

protocol ListCinemaViewControllerProtocol: AnyObject {
    func giveMeData(films: [Film])
}

class ListCinemaViewController: UIViewController, ListCinemaViewControllerProtocol {
    
    var presenter: ListCinemaPresenterProtocol?
    let tableView = UITableView()
    var films: [Film] = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kinopoisk"
        configureTableView()
        presenter?.fetchPopularMoviesData()
    }
    
    func giveMeData(films: [Film]) {
        self.films = films
        tableView.reloadData()
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
extension ListCinemaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if films.count != 0 {
            return films.count
        }
        return 0
    }
    
    // indexPath - местоположение нашей ячейки. У него есть поля row(строка) и section(секция)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.cellIdentifier(), for: indexPath) as! CinemaCell
        
        let film = films[indexPath.row]
        cell.updateUI(nameRu: film.nameRu, posterURL: film.posterUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
