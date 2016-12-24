//
//  LoginViewController.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 22/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: BaseViewController {
    
    var logoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    var logInButton = TWTRLogInButton()
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var barrier = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Logo
        logoLabel.text = "T"
        logoLabel.textAlignment = .center
        logoLabel.textColor = UIColor.white
        let fontSize = CGFloat(70)
        logoLabel.font = UIFont.systemFont(ofSize: fontSize)
        logoLabel.sizeToFit()
        logoLabel.center = CGPoint(x: view.bounds.width/2, y: 0)
        view.addSubview(logoLabel)
        
        // Twitter
        logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                self.performSegue(withIdentifier: "toMainTabBarViewController", sender: nil)
                print(unwrappedSession.userName)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        logInButton.center = view.center
        logInButton.addBorder(width: 1, color: UIColor.black.withAlphaComponent(0.4))
        logInButton.addShadow(offset: .zero, radius: 1.3, color: .black, opacity: 1, shouldRasterize: false)
        view.addSubview(logInButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // HIDE NAV AND TAB BAR
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Animate Logo
        animateLogo()
    }
    
    func animateLogo() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [logoLabel])
        collision = UICollisionBehavior(items: [logoLabel])
        collision.addBoundary(withIdentifier: "logInButton" as NSCopying, for: UIBezierPath(rect: logInButton.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        let bounceBehaviour = UIDynamicItemBehavior(items: [logoLabel])
        bounceBehaviour.elasticity = 0.5//0.2
        bounceBehaviour.allowsRotation = false
        animator.removeAllBehaviors()
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(bounceBehaviour)
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

extension LoginViewController: UICollisionBehaviorDelegate {
}
