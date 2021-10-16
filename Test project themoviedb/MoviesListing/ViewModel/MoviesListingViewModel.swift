//
//  MoviesListingViewModel.swift
//  Test project themoviedb
//
//  Created by Suleman on 15/10/2021.
//

import Foundation
import UIKit
protocol MoviesListingDelegate:UIViewController {
    func ReloadTableView()
}


class MoviesListingViewModel: NSObject {
    private weak var context:MoviesListingDelegate?
    private var tbl:UITableView!
    private var orignalMovies:[Movie] = []
    private var currentShowing:[Movie] = []
    private var page = 9
    private var previuousPage = 10
    private var totalPage = 11
    private var isLoading = false
   
    public init(context:MoviesListingDelegate) {
        super.init()
        
        self.context = context
            startNextMoviesProces()
        
        
    }
    
    @objc  func startNextMoviesProces(){
        if page == 0 {
            Functions.showActivity()
        }
       
       
        let params:[String:Any] = ["api_key":APPURL.api_key,"page": page + 1 ]
        ApiManager.getRequest(with:  APPURL.popularMovies, parameters: params, completion:{[weak self] response in
            switch(response) {
            case .success(let respo):
                
                let response = PopularMovies(fromJson: respo)
              
              
                self?.page = response.page
                self?.totalPage = response.totalPages
                self?.orignalMovies.append(contentsOf: response.results)
              
              
                self?.currentShowing = self?.orignalMovies ?? []
                DispatchQueue.main.async {
               
                    self?.context?.ReloadTableView()
                    self?.isLoading = false
                }
                
                break
            case .failure(let error):
                print(error)
                
                break
            }
            
        })
       
    }
    @objc  func startPreviousMoviesProces(){

        if (previuousPage - 1) > 1 {
           
            let params:[String:Any] = ["api_key":APPURL.api_key,"page":previuousPage - 1]
            ApiManager.getRequest(with:  APPURL.popularMovies, parameters: params, completion:{[weak self] response in
                switch(response) {
                case .success(let respo):
                    
                    let response = PopularMovies(fromJson: respo)
                  
                    self?.previuousPage = response.page
                    self?.totalPage = response.totalPages
                    self?.orignalMovies.insert(contentsOf: response.results, at: 0)
                    self?.currentShowing =  self?.orignalMovies ?? []
                    DispatchQueue.main.async {
                   
                        self?.context?.ReloadTableView()
                        self?.isLoading = false
                    }
                    break
                case .failure(let error):
                    Functions.showToast(message: error.localizedDescription)
                    break
                }
                
            })
        }
        else {
            Functions.showToast(message: "No More Old Records")
            DispatchQueue.main.async {
           
                self.context?.ReloadTableView()
                self.isLoading = false
            }
        }
       
    }
}
    
extension MoviesListingViewModel:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  currentShowing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: MoviesListingTVC.identifier, for: indexPath) as! MoviesListingTVC
            cell.accessibilityIdentifier = MoviesListingTVC.identifier + "_\(indexPath.row)"
            cell.movie = currentShowing[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (orignalMovies.count - 3) && !isLoading{
            if page < totalPage {
                startNextMoviesProces()
            }else {
                Functions.showToast(message: "No More Result Next")
            }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.context?.performSegue(withIdentifier: "MovieDetailSegue", sender: currentShowing[indexPath.row])
    }
    
}
extension MoviesListingViewModel: UISearchBarDelegate ,UIScrollViewDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        searchBar.resignFirstResponder()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentShowing = orignalMovies

        if searchText.isEmpty == false {
            currentShowing = orignalMovies.filter({ $0.title.contains(searchText) || $0.originalTitle.contains(searchText) || $0.releaseDate.contains(searchText)  })
        }

        self.context?.ReloadTableView()
    }
  
    }


