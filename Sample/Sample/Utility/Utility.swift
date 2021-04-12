//
//  Utility.swift
//  Sample
//
//  Created by Gopi Krishna on 09/04/21.
//

import Foundation
import UIKit

enum SelectedTypes : String {
    case upcoming
    case top_rated
}

class AppUtility {
    //https://api.themoviedb.org/3/movie/upcoming?api_key=2afb52bc6e3bb3e18dbe58c2b04841fc&language=en-US&page=1
    //https://api.themoviedb.org/3/movie/top_rated?api_key=2afb52bc6e3bb3e18dbe58c2b04841fc&language=en-US&page=1
    //https://image.tmdb.org/t/p/w500/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg
    static let posterBasePath = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "2afb52bc6e3bb3e18dbe58c2b04841fc"
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    
}

extension UIViewController {
    func hideTabBar() {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    func showTabBar() {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
