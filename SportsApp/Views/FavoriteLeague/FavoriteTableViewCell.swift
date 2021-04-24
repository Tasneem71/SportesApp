//
//  FavoriteTableViewCell.swift
//  SportsApp
//
//  Created by tasneem on 4/20/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImg: UIImageView!
    
    @IBOutlet weak var leagueStr: UILabel!
    
    @IBOutlet weak var youtubeBtn: UIButton!
    
    
    public var youtubeStr=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func youtubBtn(_ sender: Any) {
        
        print(youtubeStr)
        
        let url = URL(string: "youtube://"+youtubeStr)
        
        let YoutubeQuery =  youtubeStr
        let escapedYoutubeQuery = YoutubeQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let appURL = NSURL(string: "youtube://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
        let webURL = NSURL(string: "https://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    
        //UIApplication.shared.openURL(url as! URL)
        
        
//        if let url = URL(string: "https://www.hackingwithswift.com") {
//            do {
//                let contents = try String(contentsOf: url)
//                print(contents)
//            } catch {
//                // contents could not be loaded
//            }
//        } else {
//            // the URL was bad!
//        }
//
        
        
//        do {
//            var g_home_url = try String(contentsOf: URL.init(string:"youtube://"+youtubeStr)!, encoding: String.Encoding.utf8)
//            print(g_home_url)
//        }
//        catch {
//           print(error)
//        }
//
        
    }
    
}
