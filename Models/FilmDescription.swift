//
//  FilmDescription.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 04.08.2022.
//

import Foundation

struct FilmDescription: Decodable {
    let kinopoiskID: Int?
    let nameRu, nameEn: String?
    let posterUrl: String?
    let year: Int?
    let description: String?
}
