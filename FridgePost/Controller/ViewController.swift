//
//  ViewController.swift
//  FridgePost
//
//  Created by Cedric Nicolas on 12/18/17.
//  Copyright © 2017 NativeTech. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ViewController: UIViewController {
    
    //MARK: - Properties
    var postArray = [touchableView]()
    
    //MARK: - InfoView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrievePosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newPostPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toEdit", sender: self)
        
    }
    
    
    func retrievePosts() {
        let postDB = Database.database().reference().child("Posts")
        
        postDB.observe(.childAdded) {
            (snapshot) in
                let snapshotValue = snapshot.value as! Dictionary<String, String>
                let title = snapshotValue["Title"]!
                let content = snapshotValue["Note"]!
                self.configureView(title: title, content: content, key: snapshot.key)
        }
        
        //TODO: Get the live removals to work
        postDB.observe(.childRemoved) {
            (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let title = snapshotValue["Title"]
            let content = snapshotValue["Note"]
            for post in self.postArray {
                
                if post.postKey == snapshot.key{
                    post.removeFromSuperview()
                }
                
            }
            
        }
    }
    
    func configureView(title : String, content : String, key : String) {
        let halfSizeOfView = 60
        let insetSize = self.view.bounds.insetBy(dx: CGFloat(Int(2 * halfSizeOfView)), dy: CGFloat(Int(2 * halfSizeOfView))).size
        let pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
        let pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
        let rect = CGRect(x: pointX, y: pointY, width: 120, height: 120)
        let view = touchableView(frame: rect, name: title, content: content, key: key)
        postArray.append(view)
        view.title = title
        view.content = content
        self.view.addSubview(view)
        
    }
    

}

