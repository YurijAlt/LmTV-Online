//
//  ViewTVViewController.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import AVKit

class ViewTVViewController: UIViewController {
    
    let urlString = "http://iptvm3u.ru/onelist.m3u"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func createPlayer() {
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
        
    }

    
}
