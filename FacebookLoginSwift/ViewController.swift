//
//  ViewController.swift
//  FacebookLoginSwift
//
//  Created by Le Tan Thang on 11/12/16.
//  Copyright © 2016 Le Tan Thang. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    var dict : [String : AnyObject]!

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let button = UIButton()
        //let button = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        //button.setTitle("FB Login", for: UIControlState.normal)
        
        
        //button.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(button)
        
        //button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFBLoginPressed(_ sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }


}

