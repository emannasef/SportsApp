//
//  SportsCollectionViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class SportsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var sportsTitleArr:[String] = []
    var sportsImageArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sports"
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        sportsImageArr = ["football","basketball","cricket","baseball","tennis","americanFootball"]
        sportsTitleArr = ["Football","Basketball","Cricket","Baseball","Tennis","American Football"]
        self.navigationItem.title = "Sports"
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsTitleArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        
        cell.sportImg.image = UIImage(named: sportsImageArr[indexPath.row])
        cell.sportName.text = sportsTitleArr[indexPath.row]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lvc = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        lvc.sportTitle = sportsTitleArr[indexPath.row]
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width/2-100, height:  200 )
    }


}
