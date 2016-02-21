//
//  LoginViewController.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/14/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login({ () -> () in
            print("Logged in!")
            self.performSegueWithIdentifier("tweetsSegue", sender: nil)
            
        }) { (error: NSError) -> () in
            print("Error: \(error.localizedDescription)")
        }
    }
}

