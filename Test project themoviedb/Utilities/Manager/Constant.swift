//
//  Constant.swift
//  Test project themoviedb
//
//  Created by Suleman on 14/10/2021.
//

import Foundation
import UIKit


struct APPURL{
    
    
    
    static var Domain: String {
        return "https://api.themoviedb.org"
    }
    
    static let Route = "/3/movie/"
    static var BaseURL: String {
        return Domain + Route
    }
    static var popularMovies:String{
        return BaseURL + "popular?api_key={api_key}&page={page}"
    }
    static var movieDetails:String{
        return BaseURL + "{movie_id}?api_key={api_key}"
    }
    static var movieVideos:String{
        return BaseURL + "{movie_id}/videos?api_key={api_key}"
    }
   
    static let api_key = "8a4b29d69a5bf8c0691942a3fe727dfd"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let imageOrignalURL = "https://image.tmdb.org/t/p/original"
    
}


