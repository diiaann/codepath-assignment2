//
//  LoginViewController.swift
//  assignment2
//
//  Created by CloudLabs, Inc. on 2/13/16.
//  Copyright © 2016 Codepath. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginNavBar: UIImageView!

    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    let emailAlertController = UIAlertController(title: "Email Required", message: "Please enter your email address", preferredStyle: .Alert)
    let passwordAlertController = UIAlertController(title: "Password Required", message: "Please enter a password", preferredStyle: .Alert)
    let incorrectAlertController = UIAlertController(title: "Sign in incorrect", message: "Please enter a password", preferredStyle: .Alert)

    
    let PASSSWORD = "codepath"
    let EMAIL = "test@codepath.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        activityIndicator.hidden = true
        
        setupActionSheet()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        // Set initial transform values 20% of original size
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        // Apply the transform properties of the views
        loginNavBar.transform = transform
        fieldParentView.transform = transform
        // Set the alpha properties of the views to transparent
        loginNavBar.alpha = 0
        fieldParentView.alpha = 0
    }
    
    // The main view appeared...
    override func viewDidAppear(animated: Bool) {
        //Animate the code within over 0.3 seconds...
        UIView.animateWithDuration(0.3) { () -> Void in
            // Return the views transform properties to their default states.
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.loginNavBar.transform = CGAffineTransformIdentity
            // Set the alpha properties of the views to fully opaque
            self.fieldParentView.alpha = 1
            self.loginNavBar.alpha = 1
        }
    }
    
    @IBAction func onBackPress(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    
    func keyboardWillHide(notification: NSNotification!) {
        buttonParentView.frame.origin.y = buttonInitialY
    }



    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y <= -50 {
            // Hide the keyboard
            view.endEditing(true)
        }
    }
    
    func checkPassword(){
        
        if (emailTextField.text == EMAIL && passwordTextField.text == PASSSWORD) {
            performSegueWithIdentifier("trainingSegue", sender: self)
            
        }
        else {
            presentViewController(incorrectAlertController, animated: true) {
                self.activityIndicator.hidden = true
            }
        }
        
    }
    
    @IBAction func onSignInButtonPress(sender: AnyObject) {
        if (emailTextField.text!.isEmpty) {
            presentViewController(emailAlertController, animated: true) {
            }
        }
        else if (passwordTextField.text!.isEmpty) {
            presentViewController(passwordAlertController, animated: true) {
            }
        }
            
        else {
            activityIndicator.hidden = false
            delay(2) {
                self.checkPassword()
            }
        }
        
    }
    
    func setupActionSheet() {
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        emailAlertController.addAction(OKAction)
        passwordAlertController.addAction(OKAction)
        incorrectAlertController.addAction((OKAction))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
