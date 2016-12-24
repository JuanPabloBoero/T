//
//  TweetsViewController.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 22/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import UIKit
import TwitterKit
import CoreLocation

class TweetsViewController: BaseViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    var timelineViewControlller = TWTRTimelineViewController()
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location stuff.
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // Get user screen name from current session.
        if let session = Twitter.sharedInstance().sessionStore.session() as? TWTRSession {
            
            // Set time line data source.
            let dataSource = TWTRUserTimelineDataSource(screenName: session.userName, apiClient: TWTRAPIClient())
            timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
            timelineViewControlller.showTweetActions = true
            addChildViewController(timelineViewControlller)
            
            // Add Child View as Subview
            containerView.addSubview(timelineViewControlller.view)
            
            // Configure Child View
            timelineViewControlller.view.frame = containerView.bounds
            timelineViewControlller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Notify Child View Controller
            timelineViewControlller.didMove(toParentViewController: self)
            
        }
    }
    
    
    @IBAction func singleTweet(_ sender: Any) {
        let composer = TWTRComposer()
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            } else {
                // Since twitter does not provide a way to determine if tweet was succesfully posted, we should implement some way to refresh the list. using weak self to avoid retain cycles.
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[ weak self] in
                    if let weakSelf = self {
                        weakSelf.timelineViewControlller.refresh()
                    }
                }
            }
        }
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

extension TweetsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
}
