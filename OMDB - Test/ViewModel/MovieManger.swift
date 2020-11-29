//
//  MovieManger.swift
//  OMDB - Test
//
//  Created by Preston Grisham on 6/13/20.
//  Copyright © 2020 Preston Grisham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class MovieManager: ObservableObject {
    
    // Replaced by bag of AnyCancellable below!
//    var imageCanceallable: AnyCancellable?
//    var cancellable: AnyCancellable?
    
    private var bag = Set<AnyCancellable>()
    
    init(movieName movie: String) {
        getMovie(movieName: movie)
    }
    
    var title: String {
        movie.title ?? "Movie Not Found"
    }
    
    var plot: String {
        movie.plot ?? ""
    }
    
    var ratings: String {
        if let ratings = movie.ratings {
            for rating in ratings {
                if rating.source == "Rotten Tomatoes" {
                    return rating.rating
                }
            }
        } 
        return ""
    }
    
    @Published var movie: Movie = Movie() {
        didSet {
            if let posterURL = movie.poster, movie.poster != "N/A" {
                self.getImage(url: posterURL)
            } else {
                self.image = UIImage()
            }
        }
    }
    
    @Published var image = UIImage() {
        didSet{
            print(image)
        }
    }
    
    func getMovie(movieName movie: String) {
        
        let movieTitle = movie
        let escaptedMovieTitle = movieTitle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! // USE GUARD LET to protect inside function

        let baseURL = "https://www.omdbapi.com/?apikey=\(OMDB_API)&t=\(escaptedMovieTitle)"
        print(baseURL)
        let url = URL(string: baseURL)!

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .print()
            .decode(type: Movie.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .assign(to: \.movie, on: self)
            .store(in: &bag)
    }
    
    func getImage(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .assertNoFailure()
            .assign(to: \.image, on: self)
            .store(in: &bag)
    }
    
}



