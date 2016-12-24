//
//  SessionManager.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 23/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation
import TwitterKit

class SessionManager {
    
    // One line singleton.
    static let shared = SessionManager()
    fileprivate init() {}//This prevents others from using the default '()' initializer for this class.
    
    func GetFollowers(onCompletion:@escaping (_ followers: [User]?) -> Void) {
        // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            
            let client = TWTRAPIClient(userID: userID)
            
            let followersEndpoint = "https://api.twitter.com/1.1/followers/list.json"
            
            let params = ["count": "200",
                          "skip_status": "1"]
            
            var clientError : NSError?
            
            let request = client.urlRequest(withMethod: "GET", url: followersEndpoint, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                    onCompletion(nil)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    // Followers array to be filled.
                    var followersArray = [User]()
                    
                    if let jsonDict = json as? [String: AnyObject] {
                    
                        if let usersArray = jsonDict["users"] as? [[String: AnyObject]] {
                            
                            for user in usersArray {
                                
                                // Follower object to be filled
                                let follower = User()
                                
                                // Get screen name.
                                if let screenName = user["screen_name"] as? String {
                                    follower.screenName = screenName
                                }
                                
                                // Get profile background color
                                if let bkgColor = user["profile_background_color"] as? String {
                                    follower.profileBackgroundColor = bkgColor
                                }
                                
                                // Get url to the profile image
                                if let imageURL = user["profile_image_url_https"] as? String {
                                    follower.profileImageUrlHttps = imageURL
                                }
                                
                                // Add mapped follower to followers array
                                followersArray.append(follower)
                                
                            }
                        }
                    }
                    
                    // Retreive followers to callee
                    onCompletion(followersArray)
                    
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                    onCompletion(nil)
                }
            }
        }
    }
    
    
}
