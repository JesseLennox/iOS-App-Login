//
//  SignUpViewController.swift
//  PappaDemo
//
//  Created by Jesse Lennox on 8/28/19.
//  Copyright © 2019 Jesse Hanna. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameTextField: UITextField!
   
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
    
        //Hide the error label
        
    ErrorLabel.alpha = 0
    
        //Style the elements
        
    Utilities.styleTextField(FirstNameTextField)
    Utilities.styleTextField(LastNameTextField)
    Utilities.styleTextField(EmailTextField)
    Utilities.styleTextField(PasswordTextField)
    }

    // Check the fields and validate that the data is correct. If all correct this method returns nil or returns error message.
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
            return "Please fill in all fields"
        }
        
        // Check if password is secure
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in:
            .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password is not secure enough
            return "Please make sure you password is at least 8 characters, contains a special character and a number"
            }
        
        return nil
        
    }

    
    @IBAction func SignUpTap(_ sender: Any) {
        
        //Validate the fields
        let Error = validateFields()
        
        if Error != nil {
            // There is something wrong with the fields, show error message
          showError(Error!)
        }
        else{
            // Create the user
            Auth.auth().createUser(withEmail: "", password: "") { (result, err) in
                
                // Check for errors
                if err != nil {
                    //There was an error creating the user
                    self.showError("Error creating user")
                }
                else{
                    // User was created successfully, now store the first and last name
                }
            }
            //Transition to the home screen
        }
       
        }
    
    func showError(_ message:String){
        ErrorLabel.text = message
        ErrorLabel.alpha = 1}
}
