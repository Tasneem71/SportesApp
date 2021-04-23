//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/22/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    
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
       

        teamImgView.layer.borderWidth = 1
        teamImgView.layer.masksToBounds = false
        teamImgView.layer.borderColor = UIColor.black.cgColor
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
    



}
