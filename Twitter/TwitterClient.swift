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

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "YqlE7POoFOwO1OaBav06QYTqY"
let twitterConsumerSecret = "gABJT8RlybRw8nQeNcGm6KV8otrKI54Jh5xqJkhVtPDdRJgsoT"

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
