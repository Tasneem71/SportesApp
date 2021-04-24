//
//  AllSportsViewController.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit
import SDWebImage

class AllSportsViewController: UIViewController {
    
    var sports=[Sport]()
    
    let allSportsViewModel = AllSportsViewModel()

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Sports:"

        // Do any additional setup after loading the view.
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        
        allSportsViewModel.bindAllSportsViewModelToView = {
                    
            self.onAllSportsSuccessUpdateView()
            
        }
        
        
        allSportsViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title="Sports:"
    }
    
    
    func onAllSportsSuccessUpdateView(){
        
        
        sports = allSportsViewModel.allSports.sports
        self.sportsCollectionView.reloadData()
        
    }
    
    
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: allSportsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        
        }
        alert.addAction(okAction)
             self.present(alert, animated: true, completion: nil)
    }
    
    
    
}







extension AllSportsViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "SportCollectionViewCell", for: indexPath) as! SportCollectionViewCell
        
        cell.sportLblView.text=sports[indexPath.row].strSport
        
        
        cell.sportImgView.translatesAutoresizingMaskIntoConstraints=false
        cell.sportImgView.sd_setImage(with: URL(string:sports[indexPath.row].strSportThumb), placeholderImage: UIImage(named: "placeholde"))
        
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc=self.storyboard?.instantiateViewController(identifier: "league") as! LeagueTableViewController
        vc.sportName=sports[indexPath.row].strSport
        self.navigationItem.title=""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    
//    func getSportsFromApi() {
//
//        SportsApiServies.instance.getSports(url:URLs.getSportsURL)  { (sports, error) in
//        if let myError = error{
//            print(myError)
//        }else{
//            guard let sports = sports else {
//                return
//            }
//            self.sports=sports.sports
//
//            DispatchQueue.main.async {
//             self.sportsCollectionView.reloadData()
//            }
//
//            for item in self.sports{
//                print(item.strSport)}
//            }
//
//        }
//
//    }
    
    
    
}
