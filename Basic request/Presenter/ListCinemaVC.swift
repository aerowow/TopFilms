//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

class ListCinemaVC: UIViewController {
    
    var presenter: Presenter?
    let tableView = UITableView()
    var films: [Film] = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kinopoisk"
        configureTableView()
        
        
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

extension ListCinemaVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.textLabel?.text = film.nameEn
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell tapped")
        
    }
}
