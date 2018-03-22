//
//  InfoViewController.swift
//  TopOfTheStack
//
//  Created by John Giumanca on 10/03/2018.
//  Copyright © 2018 Dragos Giumanca. All rights reserved.
//

import UIKit
import Kingfisher


class InfoViewController: UIViewController {

    var userAttributes = Dictionary<String,Any>()
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var locationUser: UILabel!
    @IBOutlet weak var goldBadges: UILabel!
    @IBOutlet weak var silverBadges: UILabel!
    @IBOutlet weak var bronzeBadges: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundCorners()
        
        
        if(userAttributes["display_name"] != nil){
            nameUser.text = (userAttributes["display_name"] as! String)
        }
        if(userAttributes["location"] != nil){
            locationUser.text = (userAttributes["location"] as! String)
        }
        
        let userBadges:Dictionary = userAttributes["badge_counts"] as! Dictionary<String,Any>
        if userBadges["gold"] != nil{
            goldBadges.text = "\(userBadges["gold"]!)"
        }
        else { print("error")}
        
        if userBadges["silver"] != nil{
            silverBadges.text = "\(userBadges["silver"]!)"
        }
        else { print("error")}
        
        if userBadges["bronze"] != nil{
            bronzeBadges.text = "\(userBadges["bronze"]!)"
        }
        else { print("error")}
        
        if userAttributes["profile_image"] != nil {
            let profileImageURL = URL(string: (userAttributes["profile_image"] as! String) )
            let resource = ImageResource(downloadURL: profileImageURL!, cacheKey: nameUser.text)
            imageUser.kf.setImage(with:resource)
            
        }
        
        
    }
    
    public func roundCorners(){
        goldBadges.layer.masksToBounds = true
        goldBadges.layer.cornerRadius = goldBadges.frame.height / 2
        silverBadges.layer.masksToBounds = true
        silverBadges.layer.cornerRadius = goldBadges.frame.height / 2
        bronzeBadges.layer.masksToBounds = true
        bronzeBadges.layer.cornerRadius = goldBadges.frame.height / 2
        
    }

    

}
