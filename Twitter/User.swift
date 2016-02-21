//
//  User.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/19/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults.standardUserDefaults()

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var tagline: NSString?
    var profileImageUrl: NSURL?
    var dictionary: NSDictionary?
    
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            profileImageUrl = NSURL(string: profileUrlString)
        }
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if let user = user {
               let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
