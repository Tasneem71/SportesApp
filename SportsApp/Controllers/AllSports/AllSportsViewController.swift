//
//  AllSportsViewController.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class AllSportsViewController: UIViewController {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sportsCollectionView.dataSource = self
    }
}

extension AllSportsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "SportCollectionViewCell", for: indexPath) as! SportCollectionViewCell
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
}
