//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

protocol ListCinemaViewControllerProtocol: AnyObject {
    func giveMeData()
}

class ListCinemaViewController: UIViewController, ListCinemaViewControllerProtocol {
    
    var presenter: ListCinemaPresenterProtocol?
    let tableView = UITableView()
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kinopoisk"
        configureTableView()
        presenter?.fetchPopularMoviesData()
    }
    
    func giveMeData() {
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 130
        tableView.pin(to: view)
        tableView.register(CinemaCell.self, forCellReuseIdentifier: CinemaCell.cellIdentifier())
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
extension ListCinemaViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let filmsCount = presenter?.popularFilms.count else { return 0 }
        return filmsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.cellIdentifier(), for: indexPath) as! CinemaCell
        
        guard let film = presenter?.popularFilms[indexPath.row] else { return cell }
        cell.updateUI(film: film)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DetailViewController()
        let detailViewPresenter = DetailViewPresenter(viewController: detailViewController)
        
        detailViewController.presenter = detailViewPresenter

        guard let film = presenter?.popularFilms[indexPath.row].filmId else { return }
        detailViewPresenter.fetchDescriptionFilm(filmId: String(film))
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    func beginBatchFetch() {
        fetchingMore = true
        print("beginBatchFetch")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
            print(self.presenter?.popularFilms.count)
            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
}

