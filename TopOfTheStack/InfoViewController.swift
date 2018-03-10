//
//  InfoViewController.swift
//  TopOfTheStack
//
//  Created by John Giumanca on 10/03/2018.
//  Copyright © 2018 Dragos Giumanca. All rights reserved.
//

import UIKit


class InfoViewController: UIViewController {

    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var locationUser: UILabel!
    @IBOutlet weak var goldBadges: UILabel!
    @IBOutlet weak var silverBadges: UILabel!
    @IBOutlet weak var bronzeBadges: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goldBadges.layer.masksToBounds = true
        goldBadges.layer.cornerRadius = goldBadges.frame.height / 2
        silverBadges.layer.masksToBounds = true
        silverBadges.layer.cornerRadius = goldBadges.frame.height / 2
        bronzeBadges.layer.masksToBounds = true
        bronzeBadges.layer.cornerRadius = goldBadges.frame.height / 2
        

        var userAttributes:Dictionary = userArray[myIndex] as! Dictionary<String,Any>
        nameUser.text = (userAttributes["display_name"] as! String)
        locationUser.text = (userAttributes["location"] as! String)
        
        var userBadges:Dictionary = userAttributes["badge_counts"] as! Dictionary<String,Any>
        goldBadges.text = "\(userBadges["gold"]!)"
        silverBadges.text = "\(userBadges["silver"]!)"
        bronzeBadges.text = "\(userBadges["bronze"]!)"
        
        let profileImageURL = URL(string: (userAttributes["profile_image"] as! String) )
        let session = URLSession(configuration: .default)
        let getImageFromUrl = session.dataTask(with: profileImageURL!) { (data, response, error) in
            if let e = error {
                print("Error Occurred: \(e)")
            }
            else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        self.imageUser.image = image
                    }
                    else {
                        print("Image file is currupted")
                    }
                    
                }
                else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
        
        
        
        
    }

    

}
