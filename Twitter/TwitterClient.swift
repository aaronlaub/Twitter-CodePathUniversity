//
//  TwitterClient.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/14/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

let baseUrl = "https://api.twitter.com"
let consumerKey = "YqlE7POoFOwO1OaBav06QYTqY"
let consumerSecret = "gABJT8RlybRw8nQeNcGm6KV8otrKI54Jh5xqJkhVtPDdRJgsoT"
let homeTimeLineEndPoint = "1.1/statuses/home_timeline.json"
let verifyAccountEndPoint = "1.1/account/verify_credentials.json"

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: baseUrl), consumerKey: consumerKey, consumerSecret: consumerSecret)
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    
    func login(success: () -> (), failure: (NSError)-> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterDemo://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                print("Got token!")
                
                let authorizeURL = NSURL(string: "\(baseUrl)/oauth/authorize?oauth_token=\(requestToken.token)")!
                
                // Open URL in mobile Safari
                UIApplication.sharedApplication().openURL(authorizeURL)
                
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure!(error)
            }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken,
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                
                self.verifyAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                    
                }, failure: { (error: NSError) -> () in
                        self.loginFailure?(error)
                        
                })
                
                print("Got access token!")
                self.loginSuccess!()
                
            }) { (error: NSError!) -> Void in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure!(error)
            }
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET(homeTimeLineEndPoint, parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries)
                
                success(tweets)
            },
            
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
            })
    }
    
    func verifyAccount(success: (User)->(), failure: (NSError)->()) {
        GET(verifyAccountEndPoint, parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                
                success(user)
                
                print("name: \(user.name)")
                print("screenname: \(user.screenname)")
                print("profileURL: \(user.profileImageUrl)")
                print("description: \(user.tagline)")
            },
            
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
            })   
    }
}
