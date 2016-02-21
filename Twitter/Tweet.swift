//
//  Tweet.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/19/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var name: String?
    var screenName: String?
    var text: String?
    var profileImageUrl: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favouritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        name = dictionary["user"]!["name"] as? String
        screenName = dictionary["user"]!["screen_name"] as? String
        text = dictionary["text"] as? String
        profileImageUrl = dictionary["user"]!["profile_image_url"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["user"]!["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        let dateFormatter = NSDateFormatter()
        
        if let timestampString = timestampString {
            // Tue Aug 28 21:16:23 +0000 2012
            dateFormatter.dateFormat = "EEE MMM d HH:ss Z y"
            timestamp = dateFormatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}