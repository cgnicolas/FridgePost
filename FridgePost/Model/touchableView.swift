//
//  touchableView.swift
//  FridgePost
//
//  Created by Cedric Nicolas on 12/18/17.
//  Copyright © 2017 NativeTech. All rights reserved.
//

import UIKit

class touchableView : UIView {
    var postKey : String
    var labelRect : CGRect
    var label : UILabel
    let openButton : UIButton
    var lastLocation = CGPoint(x: 0, y: 0)
    var title : String = ""
    var content : String = ""
    //TODO: Put Label in this model so that way they're customizable and visible
    
    //MARK: Initializers
    override init(frame: CGRect) {
        labelRect = frame
        self.label = UILabel(frame: labelRect)
        self.openButton = UIButton(frame: labelRect)
        self.postKey = ""
        super.init(frame: frame)
        let panRecog = UIPanGestureRecognizer(target: self, action: #selector(detectPan(_ :)))
        let tapRecog = UITapGestureRecognizer(target: self, action: #selector(detectTap(_ :)))
        self.gestureRecognizers = [panRecog, tapRecog]
        
        self.backgroundColor = .yellow
        self.layer.borderWidth = 1
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    convenience init(frame: CGRect, name : String, content : String, key: String){
        self.init(frame: frame)
        label.center = CGPoint(x: lastLocation.x + 60, y: lastLocation.y + 60)
        label.textAlignment = .center
        label.text = name
        postKey = key
        addSubview(label)
        self.backgroundColor = .yellow
        self.layer.borderWidth = 1
    }
    
    //MARK: Gesture Detectors
    
    @objc func detectPan(_ recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    @objc func detectTap(_ recognizer: UITapGestureRecognizer){
        if recognizer.state == .ended {
            let detail = PopUpDetail(frame: CGRect(x:((superview?.frame.width)! - 350)/2, y: 100, width: 350, height: 350), name: title, post: content, key: postKey)
            detail.contentLabel.text = content
            detail.titleLabel.text = title
            superview?.addSubview(detail)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
        
        lastLocation = self.center
    }
    
    
    
    

    
}
