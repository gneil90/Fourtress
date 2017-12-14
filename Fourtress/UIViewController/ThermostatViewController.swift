//
//  ViewController.swift
//  Fourtress
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

import UIKit
import NestSDK
import RxSwift

class ThermostatViewController: UIViewController, UIScrollViewDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView?
  
  var previousPage = 0
  
  @IBOutlet weak var thermostatGaugeView: ThermostatGaugeView?
  @IBOutlet weak var thermostatView: ThermostatView?
  
  var viewModel: ThermostatGaugeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    viewModel = ThermostatGaugeViewModel()
    
    thermostatGaugeView?.bindViewModel(viewModel: viewModel!)
    thermostatView?.bindViewModel(viewModel!)
    
    bindViewModel()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func bindViewModel() {
    let _ =  viewModel!.isUpdadingThermostat.asObservable().subscribe { value in
      guard let isUpdating = value.element else {
        return
      }
      
      if isUpdating {
        self.displayProgressHUD(withTitle: nil)
      } else {
        self.hideProgressHUD()
      }
    }    
  }

  // MARK: UIScrollViewDelegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageHeight = scrollView.frame.size.height;

    let fractionalPage = scrollView.contentOffset.y / pageHeight;
    let page = lround(Double(fractionalPage));
    if (previousPage != page) {
      previousPage = page;
      if let value = self.viewModel?.thermostat?.targetTemperatureC {
        thermostatGaugeView?.thermostatTemperatureValue = Float(value)
      }
    }
  }

}

