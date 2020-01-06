//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Jesse Helmers on 1/4/20.
//  Copyright © 2020 Jesse Helmers. All rights reserved.
//
import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let obj = UIApplication.shared.delegate
        let appDel = obj as! AppDelegate
        return appDel.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detail.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeViewCell")
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell?.textLabel?.text = meme.topText
        cell?.imageView?.image = meme.memeImage
        cell?.detailTextLabel?.text = meme.bottomText
        return cell!
    }
}
