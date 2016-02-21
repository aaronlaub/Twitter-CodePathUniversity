//
//  TweetsCell.swift
//  Twitter
//
//  Created by Julio Hernandez-Duran on 2/20/16.
//  Copyright © 2016 Sosuke. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var reply: UIButton!
    @IBOutlet weak var retweet: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
