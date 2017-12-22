//
//  NewPostController.swift
//  FridgePost
//
//  Created by Cedric Nicolas on 12/18/17.
//  Copyright © 2017 NativeTech. All rights reserved.
//

import UIKit
import Firebase

class NewPostController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        let postDB = Database.database().reference().child("Posts")
        if textField.text != "" && titleTextField.text != "" {
            let postDictionary = ["Title" : titleTextField.text!, "Note" : textField.text!]
            postDB.childByAutoId().setValue(postDictionary) {
                (error, reference) in
                if(error != nil){
                    print(error!)
                    
                }
                else {
                    print("Message Saved successfully")
                    self.textField.isEnabled = true
                    self.textField.text = ""
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else {
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
