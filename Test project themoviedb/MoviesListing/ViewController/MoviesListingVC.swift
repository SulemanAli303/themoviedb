//
//  MoviesListingVC.swift
//  Test project themoviedb
//
//  Created by Suleman on 14/10/2021.
//

import UIKit

class MoviesListingVC: UIViewController{
    
    // MARK:- IBOutlets
    @IBOutlet weak var constraintSBBottom: NSLayoutConstraint!
    @IBOutlet weak var txtSearchBar: UISearchBar!
    @IBOutlet weak var tblMovieListing: UITableView!
    var objVM:MoviesListingViewModel!
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objVM = MoviesListingViewModel(context: self)
        
        tblMovieListing.register(UINib(nibName: MoviesListingTVC.identifier, bundle: nil), forCellReuseIdentifier: MoviesListingTVC.identifier)
        tblMovieListing.delegate = objVM
        tblMovieListing.dataSource = objVM
        txtSearchBar.delegate = objVM
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(objVM, action: #selector(objVM.startPreviousMoviesProces), for: .valueChanged)
        
        tblMovieListing.addSubview(refreshControl) // not required when using UITableViewController

        
        NotificationCenter.default.addObserver(self,
              selector: #selector(self.keyboardNotification(notification:)),
              name: UIResponder.keyboardWillChangeFrameNotification,
              object: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailSegue" {
            if let destination = segue.destination as? MovieDetailsVC ,let movie = sender as? Movie {
                destination.movieObj = movie
            }
        }
    }
   
     
       @objc func keyboardNotification(notification: NSNotification) {
         guard let userInfo = notification.userInfo else { return }

         let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
         let endFrameY = endFrame?.origin.y ?? 0
         let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
         let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
         let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
         let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

         if endFrameY >= UIScreen.main.bounds.size.height {
           self.constraintSBBottom?.constant = 0.0
         } else {
           self.constraintSBBottom?.constant = endFrame?.size.height ?? 0.0
         }

         UIView.animate(
           withDuration: duration,
           delay: TimeInterval(0),
           options: animationCurve,
           animations: { self.view.layoutIfNeeded() },
           completion: nil)
       }
    deinit {
         NotificationCenter.default.removeObserver(self)
       }
}


extension MoviesListingVC: MoviesListingDelegate {
    func ReloadTableView() {
        tblMovieListing.reloadData()
        refreshControl.endRefreshing()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tblMovieListing.contentOffset.y >= (tblMovieListing.contentSize.height - tblMovieListing.frame.size.height) {
             
        }
    }
}


