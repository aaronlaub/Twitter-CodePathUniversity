//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/19/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        // Tells the tableView to use the AutoLayout constraints
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 1000
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                print("Text: \(tweet.text!)")
                print("Timestamp: \(tweet.timestamp)")
                print("Favorites: \(tweet.favouritesCount)")
                print("Retweets: \(tweet.retweetCount)")
            }
            
            // Reload data in UITableView after the request is made
            self.tweetsTableView.reloadData()
            
        }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCellWithIdentifier("tweetsCell", forIndexPath: indexPath) as! TweetsCell
        let tweet = tweets[indexPath.row]
        
        cell.fullname.text = tweet.name
        cell.username.text = "@\(tweet.screenName!)"
        cell.tweetText.text = tweet.text
        cell.retweetCount.text = "\(tweet.retweetCount)"
        cell.likeCount.text = "\(tweet.favouritesCount)"
        
        //cell.timestamp.text = tweet.timestamp as? String
        
        let profileImageUrl = NSURL(string: tweet.profileImageUrl!)
        cell.avatar.layer.cornerRadius = 7.0
        cell.avatar.clipsToBounds = true
        cell.avatar.setImageWithURL(profileImageUrl!)
        
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
