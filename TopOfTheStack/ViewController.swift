//
//  ViewController.swift
//  TopOfTheStack
//
//  Created by John Giumanca on 09/03/2018.
//  Copyright © 2018 Dragos Giumanca. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userArray = [[String:Any]]()
    var myIndex = Int()
    let maxUsers = 10
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageCache.default.maxCachePeriodInSecond = 30 * 60     // save on disk for 30min
                                                                // the ram will automatically when need
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow")
        Alamofire.request(url!).responseJSON{ response in
            // print(response)
            
            if let usersJSON = response.result.value{
                if let itemsObject:Dictionary = usersJSON as? Dictionary<String,Any>{
                    var allUsers:[[String:Any]] = itemsObject["items"] as! Array
                    self.userArray = Array(allUsers[0...(self.maxUsers-1)])
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userArray.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.imageUser.layer.cornerRadius = cell.imageUser.frame.height / 2
        
    
        var userAttributes:Dictionary = userArray[indexPath.row]
        cell.labelUser.text = (userAttributes["display_name"] as! String)
        
        let profileImageURL = URL(string: (userAttributes["profile_image"] as! String) )
        let resource = ImageResource(downloadURL: profileImageURL!, cacheKey: cell.labelUser.text)
        cell.imageUser.kf.setImage(with:resource)
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoView = segue.destination as! InfoViewController
        infoView.userAttributes = self.userArray[self.myIndex]
        // we transfer our user info with segue to InfoViewController
    }
    

    
    

    
    

}

