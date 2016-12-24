//
//  BaseViewController.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 22/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.gradientWith(topLeftColor: UIColor.green.withAlphaComponent(0.5), bottomRightColor: UIColor.blue.withAlphaComponent(0.5))
        
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
