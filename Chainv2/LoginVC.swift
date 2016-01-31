//
//  ViewController.swift
//  Chainv2
//
//  Created by Jordan Olson on 1/13/16.
//  Copyright © 2016 JPRODUCTION. All rights reserved.
//

import UIKit


class LoginVC: UIViewController, UITextFieldDelegate {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpBtnTouched: UIButton!
    @IBOutlet weak var logInBtnTouched: UIButton!
    @IBOutlet weak var errorMessageLbl: UILabel!
    @IBOutlet weak var SignUpBtnBOTTOM: UIButton!
    
    var DashboardView : DashboardVC! = DashboardVC(nibName: "DashboardVC", bundle: nil)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserResume()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        usernameTextField.hidden = true
        passwordTextField.hidden = true
        emailTextField.hidden = true
        errorMessageLbl.hidden = true
        SignUpBtnBOTTOM.hidden = true
        
        
      }
        
    @IBAction func signUpBtnTouched(sender: AnyObject) {
        usernameTextField.hidden = false
        passwordTextField.hidden = false
        emailTextField.hidden = false
        logInBtnTouched.hidden = true
        signUpBtnTouched.hidden = true
        SignUpBtnBOTTOM.hidden = false
        
    }
    
    @IBAction func logInBtnTouched(sender: AnyObject) {
        usernameTextField.hidden = false
        passwordTextField.hidden = false
        signUpBtnTouched.hidden = true
        logInBtnTouched.hidden = true
        SignUpBtnBOTTOM.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func currentUserResume() {
        
        
        
    }
    
    
    func signUpUser() {
        self.presentViewController(self.DashboardView, animated: true, completion: nil)
        
        
     }
    
    func logInUser() {
        
        
        self.presentViewController(self.DashboardView, animated: true, completion: nil)
        
    }
    
    @IBAction func goToMainCameraVC(sender: AnyObject) {
        
        
        
        if emailTextField.hidden == true {
            
            logInUser()
        } else {
            signUpUser()
        }
    }
    
    

}