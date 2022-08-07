//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

protocol ListCinemaViewControllerProtocol: AnyObject {
    func reloadData()
}

final class ListCinemaViewController: UIViewController, ListCinemaViewControllerProtocol {
    
    var presenter: ListCinemaPresenterProtocol?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kinopoisk"
        configureTableView()
        presenter?.fetchPopularMoviesData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = 130 //?
        tableView.pin(to: view)
        tableView.register(CinemaCell.self, forCellReuseIdentifier: CinemaCell.cellIdentifier())
    }
}

// MARK: -  UITableViewDataSource
extension ListCinemaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let filmsCount = presenter?.popularFilms.count else { return 0 }
        return filmsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CinemaCell.cellIdentifier(), for: indexPath) as? CinemaCell else { return UITableViewCell() }
        
        guard let film = presenter?.popularFilms[indexPath.row] else { return cell }
        cell.updateUI(film: film)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCinemaViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DetailViewController()
        let detailViewPresenter = DetailViewPresenter(viewController: detailViewController)
        detailViewController.presenter = detailViewPresenter
        
        guard let film = presenter?.popularFilms[indexPath.row].filmId else { return }
        detailViewPresenter.fetchDescriptionFilm(filmId: String(film))
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension ListCinemaViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        guard let presenter = presenter else { return }
        if offsetY > (contentHeight - scrollView.frame.height) && !presenter.isFetching  {
            presenter.beginBatchFetch()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
//                            print("asyncAfter")
//
//                        }
        }
    }
}
