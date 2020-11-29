//
//  Movie.swift
//  OMDB - Test
//
//  Created by Preston Grisham on 6/13/20.
//  Copyright © 2020 Preston Grisham. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    
    var title: String?
    var year: String?
    var plot: String?
    var imdbID: String?
    var poster: String?
    var ratings: [Rating]?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case plot = "Plot"
        case poster = "Poster"
        case ratings = "Ratings"
        case imdbID
    }

}

struct Rating: Codable, Hashable {
    
    var source: String
    var rating: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case rating = "Value"
    }
}
