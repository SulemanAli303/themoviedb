//
//  MoviesListingTVC.swift
//  Test project themoviedb
//
//  Created by Suleman on 15/10/2021.
//

import UIKit
import Kingfisher
class MoviesListingTVC: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    static var identifier = "MoviesListingTVC"
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var ivMovieCover: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var movie:Movie!{
        didSet {
            lblMovieTitle.text = movie.originalTitle
            
            if let url = URL(string: APPURL.imageURL + movie.backdropPath){
            ivMovieCover.kf.indicatorType = .activity
            ivMovieCover.kf.setImage(
                    with: url,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        ivMovieCover.kf.cancelDownloadTask() // first, cancel currenct download task
        ivMovieCover.kf.setImage(with: URL(string: "")) // second, prevent kingfisher from setting previous image
        ivMovieCover.image = nil
    }
    
}
