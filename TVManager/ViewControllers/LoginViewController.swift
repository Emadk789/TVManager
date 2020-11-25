//
//  ViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 31/08/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;
import WebKit;
import Alamofire;

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        let sessionID = UserDefaults.standard.string(forKey: "sessionID");
        if let sessionID = sessionID {
            TVClient.Auth.SetSessionID(id: sessionID);
            instatiateTabBarController();
        } else {
            TVClient.shared.authUsers();
        }
    }

    @IBAction func loginClicked(_ sender: Any) {
        TVClient.shared.authWith(username: usernameTextField.text!, password: passwordTextField.text!, compleation: self.HandelLoginAuth(success:error:))
    }
    @IBAction func webLoginClicked(_ sender: Any) {
        TVClient.shared.askForPermission();
    }
    
    func HandelLoginAuth(success: Bool, error: Error?) {
        if(success) {
            instatiateTabBarController();
        }
    }
    func instatiateTabBarController() {
        let tabBarController = (storyboard?.instantiateViewController(identifier: "TabBarController"))!
        tabBarController.modalPresentationStyle = .fullScreen;
        present(tabBarController, animated: false)
    }
    
}

