//
//  YouTubeViewController.swift
//  Test project themoviedb
//
//  Created by Suleman on 15/10/2021.
//

import UIKit
import YouTubePlayer
import WebKit
class YouTubeViewController: UIViewController{
//MARK:- IBOutlets
    /// youtube player need video id to load video need delegate for corresponding functions  and params to show and hide info on player like controlls
    @IBOutlet weak var ytPlayer: YouTubePlayerView!
    /// video obje in which key is the video id
    var trailer:Trailer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let  letftbutton = UIBarButtonItem(title:"Done",style: .plain, target: self, action: #selector(btnDoneTapped))
    
        self.navigationItem.leftBarButtonItem = letftbutton
        loadAndPlayVideo()
       
    }
    func loadAndPlayVideo(){
        ytPlayer.playerVars = ["playsinline": "1",
                      "controls": "1",
                      "showinfo": "0",
                      "fs":"0",
                      "disablekb":"0",
                      "iv_load_policy":"3",
                      "modestbranding":"0",
                      "autohide":"1",
                      "rel":"1"]   as YouTubePlayerView.YouTubePlayerParameters
        ytPlayer.delegate = self
        ytPlayer.UIdelegate = self
        ytPlayer.loadVideoID(trailer.key)
       
    }
    
    @objc func btnDoneTapped(){
        ytPlayer.clear()
        self.navigationController?.dismiss(animated: true, completion: nil)
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
extension YouTubeViewController: YouTubePlayerDelegate,WKUIDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
       
        ytPlayer.play()
    }
    
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == .Ended {
            btnDoneTapped()
        }
    }

}
