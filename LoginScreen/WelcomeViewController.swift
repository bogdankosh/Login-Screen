//
//  WelcomeViewController.swift
//  LoginScreen
//
//  Created by Bogdan Koshyrets on 8/25/16.
//  Copyright © 2016 Bogdan Koshyrets. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameImage: UIImageView!
    
    var imageStore = ImageStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutPressed() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        performSegueWithIdentifier("loginView", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        if !(NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")) {
            performSegueWithIdentifier("loginView", sender: self)
        }
        usernameLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("userUsername")
        usernameImage.image = NSUserDefaults.standardUserDefaults().objectForKey("photo") as? UIImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
