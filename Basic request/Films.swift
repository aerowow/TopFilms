//
//  Films.swift
//  Basic request
//
//  Created by Даниил Кирьянчук on 11.07.2022.
//

import Foundation

// MARK: - Films
struct Films: Codable {
    let pagesCount: Int
    let films: [Film]
}

// MARK: - Film
struct Film: Codable {
    let filmID: Int
    let nameRu: String
    let nameEn: String?
    let year, filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterURL, posterURLPreview: String
    let ratingChange: JSONNull?

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, year, filmLength, countries, genres, rating, ratingVoteCount
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case ratingChange
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
