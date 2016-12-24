//
//  FollowersViewController.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 22/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import UIKit
import TwitterKit
import Kingfisher

class FollowersViewController: BaseViewController {

    var dataSource = [User]() {
        didSet {
            // When data is added, reload table view with animation.
            followersTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            
            if dataSource.count > 0 {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.followersTableView.alpha = 1
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.noFollowersLabel.alpha = 1
                })
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noFollowersLabel: UILabel!
    @IBOutlet weak var followersTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide table view
        followersTableView.alpha = 0
        
        
        // Add background to the table view
        let bkgImage = UIImageView(image: #imageLiteral(resourceName: "background"))
        bkgImage.alpha = 0.8
        followersTableView.backgroundView = bkgImage
        
        
        SessionManager.shared.GetFollowers { (followersArray) in
            self.activityIndicator.stopAnimating()
            if let followersArray = followersArray {
                self.dataSource = followersArray
            }
        }
        
    }
    
    /// Fill cell with selected follower.
    func followerCell(cell: TFollowerTableViewCell, follower: User) -> TFollowerTableViewCell {
        
        // Make the cell background clear
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        // Name
        if let screenName = follower.screenName {
            cell.profileNameLabel.text = screenName
        }
        
        // Background Color
        if let bkgColor = follower.profileBackgroundColor {
            cell.backgroundColoredView.gradientWith(topLeftColor: UIColor.lightGray, bottomRightColor: UIColor.colorFromHexString(bkgColor))
            cell.backgroundColoredView.alpha = 0.4
        }
        
        // Profile Image
        if let thumbURL = follower.profileImageUrlHttps {
            cell.profileImageView.kf.setImage(with: URL(string: thumbURL))
            cell.profileImageView.clipsToBounds = true
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height/2
            cell.profileImageView.addBorder(width: 1, color: UIColor.black.withAlphaComponent(0.2))
        }
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FollowersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tFollowerCell", for: indexPath) as! TFollowerTableViewCell
        return followerCell(cell: cell, follower: dataSource[indexPath.row])
    }
}
