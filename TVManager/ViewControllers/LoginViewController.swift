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
//import Apollo;

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//            let myurl = URL(string: "https://developers.themoviedb.org/3/");
//        TVClient.shared.authUsers();
        
//        JSONSerialization.
//        let url = URL(string: "https://api.themoviedb.org/3/movie/550")!;
//        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/550?api_key=1b2cb3475b2de18edda91152974690ca")!);
//        let param = ["api_key": "1b2cb3475b2de18edda91152974690ca"]
//        AF.request(url, parameters: param).responseData { (response) in
//            let decoder = JSONDecoder();
//            do {
//                let result = try decoder.decode(Welcome.self, from: response.data!);
//                print("First result \n", result);
//            } catch {
//                print(error);
//            }
//        }
//        AF.request(url, parameters: param).responseJSON { (response) in
//            let decoder = JSONDecoder();
//            do {
//                let result = try decoder.decode(Welcome.self, from: response.data!);
//                print("Second result \n", result);
//            } catch {
//                print(error);
//            }
//            print(response)
//            print("\n\n\n")
//            debugPrint(response);
//        }
//        AF.request(url, parameters: param).response { response in
////            debugPrint(response);
//            print(response);
//        }
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            let d = data;
//            let r = response;
//            let e = error;
//            let decoder = JSONDecoder();
//            do {
//               let result = try decoder.decode(Welcome.self, from: d!);
//                print(result);
//            } catch {
//                print(error);
//            }
//
//        }.resume();
        
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated);
//        let hasSessionID = UserDefaults.standard.bool(forKey: "hasSessionID")
//                if hasSessionID {
//                    instatiateHomeViewController();
//                }
//
//                else {
//                    TVClient.shared.authUsers();
//                }
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
//        let hasSessionID = UserDefaults.standard.bool(forKey: "hasSessionID");
        let sessionID = UserDefaults.standard.string(forKey: "sessionID");
//        let session = UserDefaults.standard.string(forKey: "sessionID");
//        print(sessionID);
        if let sessionID = sessionID {
            TVClient.Auth.SetSessionID(id: sessionID);
            instatiateHomeViewController();
        } else {
            TVClient.shared.authUsers();
        }
//        if sessionID {
//                    TVClient.Auth.SetSessionID(id: sessionID);
//                    TVClient.shared.Auth.SetSessionID(id: sessionID);
//                    instatiateHomeViewController();
//                }
                
    }

    @IBAction func loginClicked(_ sender: Any) {
        TVClient.shared.authWith(username: usernameTextField.text!, password: passwordTextField.text!, compleation: self.HandelLoginAuth(success:error:))
    }
    @IBAction func webLoginClicked(_ sender: Any) {
        
        TVClient.shared.askForPermission();
    }
    
    func HandelLoginAuth(success: Bool, error: Error?) {
        if(success) {
            instatiateHomeViewController();
        }
    }
    func instatiateHomeViewController() {
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        present(homeViewController, animated: true)
    }
    
}

