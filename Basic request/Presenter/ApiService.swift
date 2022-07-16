//
//  ApiService.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 13.07.2022.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<Films, Error>) -> Void) {
        
        let popularMoviesURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1"
        
        guard let url = URL(string: popularMoviesURL) else { return }
        var request = URLRequest(url: url)
        
                request.allHTTPHeaderFields = ["X-API-KEY" : "5259413b-9a44-4fd8-b938-da9d556e7724"]
                request.httpMethod = "GET"
        
        
        // Create URL Session - work on the background
        
        dataTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                print(" DataTask Error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle empty Responce
                print("Empty Responce")
                return
            }
            print("Responce status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Films.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}

