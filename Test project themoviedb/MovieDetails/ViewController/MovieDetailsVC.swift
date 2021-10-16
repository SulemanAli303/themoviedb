//
//  MovieDetailsVC.swift
//  Test project themoviedb
//
//  Created by Suleman on 15/10/2021.
//

import UIKit
import Kingfisher
class MovieDetailsVC: UIViewController {
// MARK:- IBOutlets
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGeneres: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    var movieObj:Movie!
    var objVM:DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objVM = DetailsViewModel(context: self)
        LoadData()
        
        
    }
    // MARK:- show data on views and call api for Details
    func LoadData(){
        if movieObj != nil {
            lblOverView.text = movieObj.overview
            lblDate.text = movieObj.releaseDate
            lblGeneres.text = movieObj.title
            lblTitle.text = movieObj.originalTitle
            
            if let url = URL(string: APPURL.imageOrignalURL + movieObj.backdropPath){
                ivPoster.kf.indicatorType = .activity
                ivPoster.kf.setImage(
                    with: url,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
            objVM.startMovieDetailsProces(movie_id: "\(movieObj.id ?? 500)")
        }
    }
    // MARK:- IBActions
    /// to play song in player
    @IBAction func btnWatchTrailerAction(_ sender: UIButton) {
     
        objVM.startTrailerProces(movie_id: "\(movieObj.id ?? 0)")
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MovieDetailsVC: DetailsDelegate {
    func ReloadViews(response:MovieDetailsReponse) {
       
            lblOverView.text = response.overview
            lblDate.text = response.releaseDate
       var genelist = ""
        for genere in response.genres  {
           
            genelist = genelist + genere.name + ","
        }
        lblGeneres.text = genelist
        lblTitle.text = response.originalTitle
        if let url = URL(string: APPURL.imageOrignalURL + response.backdropPath){
                ivPoster.kf.indicatorType = .activity
                ivPoster.kf.setImage(
                    with: url,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
            
        
    }
}
