//
//  ViewController.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }

    private func makeRequest() {
        var request = URLRequest(url: URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1")!)
        request.allHTTPHeaderFields = ["X-API-KEY" : "5259413b-9a44-4fd8-b938-da9d556e7724"]
        request.httpMethod = "GET"
        
        //Создаем задачу на отправку нашего запроса.
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            print(String(decoding: data!, as: UTF8.self))
            print(error)
        }
        task.resume()
    }

}

