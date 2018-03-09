//
//  ViewController.swift
//  StackUsers
//
//  Created by John Giumanca on 08/03/2018.
//  Copyright © 2018 Dragos Giumanca. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow").responseJSON{ response in
           // print(response)
            
            if let usersJSON = response.result.value{
                let userItemsObject:Dictionary = usersJSON as! Dictionary<String,Any>
                for users in userItemsObject{
                    let user:Dictionary = users as! Dictionary<String,Any>
                    print(user["display_name"])
                }
                
            }
            
        }
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

