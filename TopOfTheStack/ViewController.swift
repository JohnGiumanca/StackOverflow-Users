//
//  ViewController.swift
//  TopOfTheStack
//
//  Created by John Giumanca on 09/03/2018.
//  Copyright © 2018 Dragos Giumanca. All rights reserved.
//

import UIKit
import Alamofire

var userArray:NSArray = []
var myIndex = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let myGroup = DispatchGroup()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.myGroup.enter()
        Alamofire.request("https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow").responseJSON{ response in
            // print(response)
            
            if let usersJSON = response.result.value{
                if let itemsObject:Dictionary = usersJSON as? Dictionary<String,Any>{
                    userArray = itemsObject["items"] as! NSArray
                    self.myGroup.leave()
                }
            }
            
        }
        
       
        
        
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.imageUser.layer.cornerRadius = cell.imageUser.frame.height / 2
        
        self.myGroup.notify(queue: .main){
            var userAttributes:Dictionary = userArray[indexPath.row] as! Dictionary<String,Any>
            cell.labelUser.text = (userAttributes["display_name"] as! String)
            
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
                            cell.imageUser.image = image
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
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
        myIndex = indexPath.row
    }
    
    

    
    

}

