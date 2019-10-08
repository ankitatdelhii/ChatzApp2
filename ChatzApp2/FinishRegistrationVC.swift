//
//  FinishRegistrationVC.swift
//  ChatzApp2
//
//  Created by Ankit Saxena on 08/10/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD


class FinishRegistrationVC: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(email, password)
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        clearTexts()
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        dismissKeyboard()
        ProgressHUD.show("Registering User!")
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneTextField.text != "" {
            
            FUser.registerUserWith(email: email, password: password, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                if error != nil{
                    ProgressHUD.dismiss()
                    ProgressHUD.show(error!.localizedDescription)
                } else {
                    self.registerUser()
                }
            }
            
        } else {
            ProgressHUD.show("Please fill All Fields!")
        }
        
    }
    
    func registerUser(){
        
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        var tempDict : [String: Any] = [kFIRSTNAME: nameTextField.text!, kLASTNAME: surnameTextField.text!, kFULLNAME: fullName, kCOUNTER: countryTextField.text!, kCITY: cityTextField.text!, kPHONE: phoneTextField.text!]
        
        if avatarImage == nil {
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarImg) in
                let avatarData = avatarImg.jpegData(compressionQuality: 0.7)
                let avatar = avatarData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                tempDict[kAVATAR] = avatar
            }
        } else {
            let avatarData = avatarImage!.jpegData(compressionQuality: 0.7)
                let avatar = avatarData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                tempDict[kAVATAR] = avatar
        }
        
    }
    
    
    //MARK: Helper Functions
    
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    func clearTexts(){
        nameTextField.clearText()
        surnameTextField.clearText()
        countryTextField.clearText()
        cityTextField.clearText()
        phoneTextField.clearText()
    }
    
}
