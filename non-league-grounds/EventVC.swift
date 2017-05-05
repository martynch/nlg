//
//  EventVC.swift
//  non-league-grounds
//
//  Created by Martyn Cheatle on 24/04/2017.
//  Copyright © 2017 Martyn Cheatle. All rights reserved.
//

import UIKit

class EventVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // RETURN PLAYER VARIABLE
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:EventPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EventPlayerCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("User Tapped on Player Cell \(indexPath.row)")
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
        
    }
}
