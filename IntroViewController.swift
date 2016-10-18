//
//  IntroViewController.swift
//  LoginScreen
//
//  Created by Bogdan Koshyrets on 8/20/16.
//  Copyright © 2016 Bogdan Koshyrets. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn") {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButtonPressed() {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let storedUsername = userDefaults.stringForKey("userUsername")
        let storedPassword = userDefaults.stringForKey("userPassword")
        
        if (username == storedUsername && password == storedPassword) {
            view.endEditing(true)
            userDefaults.setBool(true, forKey: "isUserLoggedIn")
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            let alertControl = UIAlertController(title: "Error", message: "Wrong username/password. Try again", preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertControl.addAction(okButton)
            
            presentViewController(alertControl, animated: true, completion: nil)
        }
    }
    @IBAction func hideKeyboard(sender: UITapGestureRecognizer!) -> Void {
        view.endEditing(true)
    }
    
    @IBAction func unwindToIntro(segue: UIStoryboardSegue) {
        print("Unwound to Intro View")
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
