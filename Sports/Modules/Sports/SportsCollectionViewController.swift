//
//  SportsCollectionViewController.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class SportsCollectionViewController: UICollectionViewController {
    var sportsTitleArr:[String] = []
    var sportsImageArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        sportsImageArr = ["football","basketball","cricket","baseball","tennis","americanFootball"]
        sportsTitleArr = ["Football","Basketball","Cricket","Baseball","Tennis","American Football"]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }


}
