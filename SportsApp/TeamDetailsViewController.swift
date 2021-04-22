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
    override func viewDidLoad() {
        super.viewDidLoad()
       

        teamImgView.layer.borderWidth = 1
        teamImgView.layer.masksToBounds = false
        teamImgView.layer.borderColor = UIColor.black.cgColor
        teamImgView.layer.cornerRadius = teamImgView.frame.height/2
        teamImgView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    



}
