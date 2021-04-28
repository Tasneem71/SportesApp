//
//  TeamDetailsTableViewController.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/25/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class TeamDetailsTableViewController: UITableViewController {

    @IBOutlet weak var teamBackgroundImgView: UIImageView!
      
      @IBOutlet weak var teamImgView: UIImageView!
      
      @IBOutlet weak var teamNameLbl: UILabel!
      
      @IBOutlet weak var leagueLbl: UILabel!
      
      @IBOutlet weak var stadiumLbl: UILabel!
      
      @IBOutlet weak var countryLbl: UILabel!
      
      @IBOutlet weak var descTextView: UITextView!
      
      
      var team:Teams?
      
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        teamImgView.layer.borderWidth = 1
//        teamImgView.layer.masksToBounds = false
//        teamImgView.layer.borderColor = UIColor.black.cgColor
        teamImgView.layer.cornerRadius = teamImgView.frame.height/2
        teamImgView.clipsToBounds = true
        teamImgView.sd_setImage(with: URL(string:(team?.strTeamBadge)!), placeholderImage: UIImage(named: "placeholde"))
        
        
        if let image = team?.strStadiumThumb  {
            
            teamBackgroundImgView.sd_setImage(with: URL(string:(team?.strStadiumThumb)!), placeholderImage: UIImage(named: "placeholde"))
        }
        
        

        // Do any additional setup after loading the view.
        
        leagueLbl.text=team?.strLeague
        teamNameLbl.text=team?.strTeam
        stadiumLbl.text=team?.strStadium
        countryLbl.text=team?.strCountry
        descTextView.text=team?.strDescriptionEN
        
    }
  
    @IBAction func navigateToFacebook(_ sender: Any) {
        
        print(team?.strFacebook)
               
//        let url = URL(string: "youtube://"+(team?.strFacebook)!)
//
               let facebookQuery =  team?.strFacebook
        let escapedfacebookQuery = facebookQuery!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
               let appURL = NSURL(string: "facebook://www.facebook.com/results?search_query=\(escapedfacebookQuery!)")!
               let webURL = NSURL(string: "https://www.facebook.com/results?search_query=\(escapedfacebookQuery!)")!
               let application = UIApplication.shared

               if application.canOpenURL(appURL as URL) {
                   application.open(appURL as URL)
               } else {
                   // if Youtube app is not installed, open URL inside Safari
                   application.open(webURL as URL)
               }
    }
    
    @IBAction func navigateToInstgram(_ sender: Any) {
        let YoutubeQuery =  team?.strInstagram
        let escapedYoutubeQuery = YoutubeQuery!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
               let appURL = NSURL(string: "instgram://www.instgram.com/results?search_query=\(escapedYoutubeQuery!)")!
               let webURL = NSURL(string: "https://www.instgram.com/results?search_query=\(escapedYoutubeQuery!)")!
               let application = UIApplication.shared

               if application.canOpenURL(appURL as URL) {
                   application.open(appURL as URL)
               } else {
                   // if Youtube app is not installed, open URL inside Safari
                   application.open(webURL as URL)
               }
    }
    @IBAction func navigateToTwitter(_ sender: Any) {
        let YoutubeQuery =  team?.strTwitter
        let escapedYoutubeQuery = YoutubeQuery!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
               let appURL = NSURL(string: "twitter://www.twitter.com/results?search_query=\(escapedYoutubeQuery!)")!
               let webURL = NSURL(string: "https://www.twitter.com/results?search_query=\(escapedYoutubeQuery!)")!
               let application = UIApplication.shared

               if application.canOpenURL(appURL as URL) {
                   application.open(appURL as URL)
               } else {
                   // if Youtube app is not installed, open URL inside Safari
                   application.open(webURL as URL)
               }
    }
}
