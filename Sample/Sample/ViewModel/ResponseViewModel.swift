//
//  ResponseViewModel.swift
//  Sample
//
//  Created by Gopi Krishna on 09/04/21.
//

import Foundation
import Alamofire

// MARK: - TopRated
struct TopRated: Codable {
    var page: Int?
    var results: [Result]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Upcoming
struct UpcomingResponseViewModel {
    struct Upcoming: Codable {
        var dates: Dates?
        var page: Int?
        var results: [Result]?
        var totalPages, totalResults: Int?

        enum CodingKeys: String, CodingKey {
            case dates, page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }

    // MARK: - Dates
    struct Dates: Codable {
        var maximum, minimum: String?
    }

    // MARK: - Result
    struct Result: Codable {
        var adult: Bool?
        var backdropPath: String?
        var genreIDS: [Int]?
        var id: Int?
        var originalLanguage, originalTitle, overview: String?
        var popularity: Double?
        var posterPath, releaseDate, title: String?
        var video: Bool?
        var voteAverage: Double?
        var voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

}

class RequestAPI {
    func getTopRatedMovies(selectedtypeList : SelectedTypes, page : String, completion : @escaping (_ isSuccess : Bool, _ dataObj : TopRated) -> ()) {
        
        let queryParams: [String: Any] = [
            "api_key": AppUtility.apiKey,
            "language": "en-US",
            "page": page
        ]
        
        let url = URL(string: "\(AppUtility.baseUrl)\(selectedtypeList.rawValue)?")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = queryParams.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        urlComponents?.queryItems = queryItems
        
        AF.request(urlComponents?.url?.absoluteString ?? "")
            .validate()
            .responseDecodable(of: TopRated.self) { (response) in
                guard let films = response.value else {
                    completion(false, TopRated())
                    return
                }
                completion(true, films)
                debugPrint(films, "---------fils")
                
            }
        
    }
    
    func getUpcomingMovies(selectedtypeList : SelectedTypes, page : String, completion : @escaping (_ isSuccess : Bool, _ dataObj : UpcomingResponseViewModel.Upcoming) -> ()) {
        
        let queryParams: [String: Any] = [
            "api_key": AppUtility.apiKey,
            "language": "en-US",
            "page": page
        ]
        
        let url = URL(string: "\(AppUtility.baseUrl)\(selectedtypeList.rawValue)?")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = queryParams.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        urlComponents?.queryItems = queryItems
        
        AF.request(urlComponents?.url?.absoluteString ?? "")
            .validate()
            .responseDecodable(of: UpcomingResponseViewModel.Upcoming.self) { (response) in
                guard let films = response.value else {
                    completion(false, UpcomingResponseViewModel.Upcoming())
                    return
                }
                completion(true, films)
                debugPrint(films, "---------fils")
                
            }
        
    }
    
}
