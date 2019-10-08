//
//  ViewController.swift
//  ChatzApp2
//
//  Created by Ankit Saxena on 16/08/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if emailTextField.text! != "" && passwordTextfield.text! != ""{
            loginUser()
        } else{
            ProgressHUD.showError("Enter email or password!")
        }
        dismissKeyboard()
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        print("Register Pressed!")
        if emailTextField.text! != "" && passwordTextfield.text! != "" && repeatPasswordTextField.text! != ""{
            
            if passwordTextfield.text! == repeatPasswordTextField.text!{
                registerUser()
            } else {
                ProgressHUD.showError("Password not Matched!")
            }
            
        } else{
            ProgressHUD.showError("Enter required values!")
        }
        dismissKeyboard()
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
        print("Background Tapped!")
        dismissKeyboard()
    }
    
    //MARK: Login and Signup Functions
    func loginUser(){
        print("Logging you In!")
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextfield.text!) { (error) in
            if error != nil{
                ProgressHUD.showError(error?.localizedDescription)
            } else{
                print("Present the app!")
            }
        }
    }
    
    func registerUser(){
        performSegue(withIdentifier: "welcomeToFinishReg", sender: nil)
        clearTexts()
        dismissKeyboard()
        print("Registering User!")
    }
    
    func goToApp(){
        ProgressHUD.dismiss()
        clearTexts()
        dismissKeyboard()
        //Present the app
    }
    
    
    //MARK: Helper Functions
    
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    func clearTexts(){
        emailTextField.text = ""
        passwordTextfield.text = ""
        repeatPasswordTextField.text = ""
    }
    
    //MARK: Perform Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeToFinishReg" {
            let vc = segue.destination as! FinishRegistrationVC
            vc.email = emailTextField.text!
            vc.password = passwordTextfield.text!
        }
    }
    
}

