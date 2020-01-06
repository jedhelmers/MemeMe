//
//  MemeDetailViewController.swift
//  MemeMe1.0
//
//  Created by Jesse Helmers on 1/5/20.
//  Copyright © 2020 Jesse Helmers. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("self.meme", self.meme)
        self.imageView.image = self.meme.memeImage
    }
}
