//
//  DetailsViewModel.swift
//  Test project themoviedb
//
//  Created by Suleman on 15/10/2021.
//

import Foundation
import UIKit
protocol DetailsDelegate:UIViewController {
    /// HTTP Response for Movie Details Api so that Vides can reload
    /// - Parameter response:MovieDetailsReponse  id of Movie
    func ReloadViews(response:MovieDetailsReponse)
}


class DetailsViewModel: NSObject {
    private weak var context:DetailsDelegate?
  
    public init(context:DetailsDelegate) {
        super.init()
        
        self.context = context
     
    }
    /// Process Movie Details Calling HTTP Request
    /// - Warning: call delegate function or show Toast
    /// - Parameter movie_id:String  id of Movie
    /// - Returns: call delegate function when response is 200 on reloadViews.
    func startMovieDetailsProces(movie_id:String){
        Functions.showActivity()
        let params:[String:Any] = ["api_key":APPURL.api_key,"movie_id":movie_id]
        ApiManager.getRequest(with:  APPURL.movieDetails , parameters: params, completion:{[weak self] response in
            switch(response) {
            case .success(let respo):
                
               
                DispatchQueue.main.async {
                    self?.context?.ReloadViews(response:MovieDetailsReponse(fromJson: respo))
                }
                
                break
            case .failure(let error):
                Functions.showToast(message: error.localizedDescription)
                break
            }
            
        })
       
    }
    
    /// Process Movie Trailers Calling HTTP Request
    /// - Warning: play video in Youtube Player
    /// - Parameter movie_id:String  id of Movie
    /// - Returns: direct play video in Youtube player
    func startTrailerProces(movie_id:String){
        Functions.showActivity()
        let params:[String:Any] = ["api_key":APPURL.api_key,"movie_id":movie_id]
        ApiManager.getRequest(with:  APPURL.movieVideos, parameters: params, completion:{[weak self] response in
            switch(response) {
            case .success(let respo):
             let MVR =   MovieVideoResponse(fromJson: respo)
                if let trail = MVR.trailers.first{
                self?.playVideo(trailer: trail)
                }
                else {
                    Functions.showToast(message: "No Trailer Found")
                }
                break
            case .failure(let error):
               
                Functions.showToast(message: error.localizedDescription)
                break
            }
            
        })
       
    }
    /// start YouTubeViewController and play video in it
    /// - Warning: play video in Youtube Player
    /// - Parameter trailer:Video Trailer for Movie
    /// - Returns: direct play video in Youtube player in YouTubeViewController
    func playVideo(trailer:Trailer){
        let Sb = UIStoryboard(name: "Main", bundle: nil)
        let vc =    Sb.instantiateViewController(withIdentifier: "YouTubeViewController") as! YouTubeViewController
      
        vc.trailer = trailer
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        self.context?.present(navController, animated: true, completion: nil)
    }
}
    

