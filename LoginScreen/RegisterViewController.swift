//
//  RegisterViewController.swift
//  LoginScreen
//
//  Created by Bogdan Koshyrets on 8/20/16.
//  Copyright © 2016 Bogdan Koshyrets. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let textFieldCount = 4
    
    let WarningTextArray = ["Username text field should not be empty",
                            "E-mail field should not be enpty",
                            "Password field shound not be empty",
                            "Passwords don't match."]
    
//    var textFieldCount: Int {
//        var count: Int = 0
//        for view in self.view.subviews {
//            if let textField = view as? UITextField {
//                count += 1
//            }
//        }
//        print("Number of text fields: \(count)")
//        return count
//    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField! {
        didSet {
            if registerButton != nil {
                checkForAllFieldsToBeFilled()
            }
        }
    }
    
    
    @IBOutlet var textFields: [UITextField]! {
        didSet {
            if registerButton != nil {
                checkForAllFieldsToBeFilled()
            }
        }
    }
    
    @IBOutlet weak var usernameWarningLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var repeatPasswordWarningLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButton(sender: UIButton) {
        register()
        
    }
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePhoto(sender: UITapGestureRecognizer) {
        
        let imagePicker = UIImagePickerController()
        // If device has a camera, take photo, otherwise pick camera from photo library.
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameWarningLabel.text = ""
        emailWarningLabel.text = ""
        passwordWarningLabel.text = ""
        repeatPasswordWarningLabel.text = ""
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self

        checkForAllFieldsToBeFilled()
    }

    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func register() {
        let userUserame = usernameTextField.text
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
//        let photoImage = imageView.image
    
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(userUserame, forKey: "userUsername")
        defaults.setObject(userEmail, forKey: "userEmail")
        defaults.setObject(userPassword, forKey: "userPassword")
        
        defaults.setBool(true, forKey: "isUserLoggedIn")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkForAllFieldsToBeFilled() {
        print("Checking for all fields to be filled.")
        
        var filledFields = true
        var matchedPasswords = false
        
        for field in textFields {
            if field.text!.isEmpty {
                filledFields = false
            }
        }
        
        if (passwordTextField?.text == repeatPasswordTextField?.text) {
            matchedPasswords = true
        }
        
        if filledFields && matchedPasswords {
            registerButton.enabled = true
            registerButton.backgroundColor = UIColor.blackColor()
        }
        else {
            registerButton.enabled = false
            registerButton.backgroundColor = UIColor.lightGrayColor()
            
        }
        
        print("filledFields \(filledFields)")
        print("matchedPasswords \(matchedPasswords)")
        
    }
    
    func changeTextFieldAppearence(textField: UITextField, warning: Bool) {
        var color = UIColor.lightGrayColor()
        if warning {
            color = UIColor.redColor()
        }
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        textField.layer.borderColor = color.CGColor
        textField.layer.borderWidth = 1.0
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
////        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
////        print("TextField tag: \(textField.tag). Range: \(range). Entered string: \(string)")
//        
//        // Checks if all of the fields are filled with valid info to enable 'Register' button.
////        checkForAllFieldsToBeFilled()
//        
//        return true
//    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        // Check if password text field and repeat text field match.
        if (textField.tag == 3 && !textField.text!.isEmpty && passwordTextField.text != textField.text) {
            repeatPasswordWarningLabel.text = "Passwords in both fields should match"
            return
        }
        
        // Check if this particular field is filled in.
        let label = self.view.viewWithTag(100 + textField.tag) as! UILabel
        if textField.text!.isEmpty {
            label.text = WarningTextArray[textField.tag]
            changeTextFieldAppearence(textField, warning: true)
        }
        else {
            label.text = ""
            changeTextFieldAppearence(textField, warning: false)
        }
        
        checkForAllFieldsToBeFilled()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == textFields[textFields.count - 1] {
            self.view.endEditing(true)
        }
        else {
            textFields[textFields.indexOf(textField)! + 1].becomeFirstResponder()
        }
        
        return true
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
