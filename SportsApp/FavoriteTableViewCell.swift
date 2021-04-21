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
    

    
    var youtubeStr=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
