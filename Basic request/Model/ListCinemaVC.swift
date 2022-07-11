//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

class ListCinemaVC: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        makeRequest()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func makeRequest() {
        var request = URLRequest(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1")!)
        request.allHTTPHeaderFields = ["X-API-KEY" : "5259413b-9a44-4fd8-b938-da9d556e7724"]
        request.httpMethod = "GET"

        //Создаем задачу на отправку нашего запроса.
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data, let film = try? JSONDecoder().decode(Films.self, from: data) {
                let filmNameRu = film.films[0].nameRu
                print(filmNameRu)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListCinemaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell tapped")
    }
}


