//
//  MemeCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Jesse Helmers on 1/5/20.
//  Copyright © 2020 Jesse Helmers. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]! {
        let obj = UIApplication.shared.delegate
        let del = obj as! AppDelegate
        return del.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.memes.count)
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as! NSIndexPath).row]
        
        cell.memeImage.image = meme.memeImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailContainer = self.storyboard!.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailContainer.meme = self.memes[(indexPath as! NSIndexPath).row]
        self.navigationController!.pushViewController(detailContainer, animated: true)
        
    }
}
