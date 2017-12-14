//
//  CustomAuthViewController.swift
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

import UIKit
import NestSDK

class CustomAuthViewController: UIViewController, NTAuthViewControllerDelegate, NTAuthViewControllerDataSource {

  @IBOutlet weak var loginButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    loginButton?.layer.borderColor = UIColor.fr_white.cgColor
    loginButton?.layer.borderWidth = 1
    loginButton?.layer.cornerRadius = 4    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }

  /// Presents NTAuthViewController, where user can obtain a PIN code and confirm the `Terms of usage`
  @IBAction func presentNestAuthenticationController(sender: AnyObject?) {
    let bundle = Bundle.init(for: NTAuthViewController.self)
    let authViewController = NTAuthViewController.init(nibName: NTAuthViewController.nibName(), bundle: bundle)
    authViewController.delegate = self
    authViewController.dataSource = self
    let navigationViewController = UINavigationController.init(rootViewController: authViewController)
    present(navigationViewController, animated: true, completion: nil)
  }
  
  // MARK: NTAuthViewControllerDelegate
  
  func authenticationController(_ controller: NTAuthViewController, didFinishWith result: NTAuthResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  // MARK: NTAuthViewControllerDataSource
  
  func authorizationURL(_ controller: NTAuthViewController) -> URL {
    return URL.init(string: FRConstants.Nest.authorizationURL)!
  }
}
