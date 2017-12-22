//
//  PopUpDetail.swift
//  FridgePost
//
//  Created by Cedric Nicolas on 12/18/17.
//  Copyright © 2017 NativeTech. All rights reserved.
//

import UIKit
import Firebase


class PopUpDetail : UIView {
    var passedKey : String
    var titleLabel : UILabel
    var contentLabel : UILabel
    var closeButton : UIButton
    var deleteButton : UIButton
    var ref = Database.database().reference().child("Post")
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel(frame: frame)
        self.contentLabel = UILabel(frame: frame)
        self.closeButton = UIButton(frame: frame)
        self.deleteButton = UIButton(frame: frame)
        self.passedKey = ""
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, name: String, post: String, key: String) {
        self.init(frame: frame)
        configureDetailView()
        titleLabel.text = name
        contentLabel.text = post
        passedKey = key
        print(passedKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func configureDetailView() {
        titleLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 87.5))
        contentLabel = UILabel(frame: CGRect(x: 0, y: 87.5, width: self.frame.width, height: 175))
        closeButton = UIButton(frame: CGRect.init(x: 0.0, y: 262.5, width: (self.frame.width)/2, height: 87.5))
        deleteButton = UIButton(frame: CGRect(x: (self.frame.width)/2, y: 262.5, width: (self.frame.width)/2, height: 87.5))
        
        
        titleLabel.textAlignment = .center
        contentLabel.textAlignment = .center
        
        
        
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(closeButton)
        addSubview(deleteButton)
        
        
        self.backgroundColor = .yellow
        self.layer.borderWidth = 1
        
        
    }
    
    @objc func dismissView(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @objc func deletePost(sender: UIButton) {
        ref = Database.database().reference().child("Posts").child(passedKey)
        ref.setValue(nil)
        self.removeFromSuperview()
    }
    
}
