//
//  Films.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import Foundation

struct Films: Decodable {
    let pagesCount: Int?
    let films: [Film]
}

struct Film: Decodable {
    let filmId: Int?
    let nameRu: String?
    let genres: [Genre]
    let rating: String?
    let posterUrl: String?
    let kinopoiskId: Int?
    let description: String?
    let shortDescription: String?
}

struct Genre: Decodable {
    let genre: String?
}
