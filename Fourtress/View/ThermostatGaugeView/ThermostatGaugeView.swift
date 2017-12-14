//
//  ThermostatGaugeView.swift
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

import UIKit
import NestSDK

class ThermostatGaugeView: UIView {
  
  /// GaugeView to display target thermostat value
  @IBOutlet weak var gaugeView: WMGaugeView?
  
  @IBOutlet weak var updateButton: UIButton?
  
  /// Circular gesture to rotate the gauge view
  var circleGestureRecognizer: XMCircleGestureRecognizer?
  
  /// How many revolutions user needs to make to set the maximum value. Greater this value is - slower the gauge's needle will move
  let maximumRevolutions : Float = 4
  
  /// Thermostat temperature value being observed
  var thermostatTemperatureValue: Float = 0.0 {
    didSet {
      let _max: Float = Float(NTThermostatTempMaxC)
      let _min: Float = Float(NTThermostatTempMinC)

      currentValue = (thermostatTemperatureValue - _min)/(_max - _min)
    }
  }
  
  /// Value in percentage: 0.0 <= x <= 1.0, which indicates the progress
  var currentValue: Float = 0.0 {
    didSet {
      currentValue = min(max(0, currentValue), 1)
      
      displayScaledValue(value: currentValue)
    }
  }

  var viewModel: ThermostatGaugeViewModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    if let gaugeView = self.gaugeView {
      let width = gaugeView.frame.width
      let point = CGPoint.init(x: width/2, y: width/2)
      circleGestureRecognizer = XMCircleGestureRecognizer.init(midPoint: point, target: self, action: #selector(ThermostatGaugeView.rotateGesture(recognizer:)))
      
      gaugeView.addGestureRecognizer(circleGestureRecognizer!)
    }
    
    updateButton?.layer.borderColor = UIColor.fr_white.cgColor
    updateButton?.layer.borderWidth = 1
    updateButton?.layer.cornerRadius = 4    
  }
  
  // MARK: ViewModel
  
  func bindViewModel(viewModel: ThermostatGaugeViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: Gesture
  
  @objc func rotateGesture(recognizer:XMCircleGestureRecognizer) {
    if let rotation = recognizer.rotation {
      currentValue += Float(rotation.degrees) / (360 * maximumRevolutions)
    }
  }
  
  // MARK: IBActions
  
  /// Sets thermostat targetTemperatureC
  @IBAction func updateButtonPressed(sender: AnyObject) {
    if let value = gaugeView?.value {
      self.viewModel?.targetTemperatureC.value = value
    }
  }
  
  
  //MARK: Helpers
  
  /// Scale value to display it in gauge view. Returns normalized value minTemp <= x <= maxTemp
  func displayScaledValue(value: Float) {
    let _max: Float = Float(NTThermostatTempMaxC)
    let _min: Float = Float(NTThermostatTempMinC)
    let scaleValue = (_max - _min) * Float(value) + _min

    gaugeView?.setValue(scaleValue, animated: true)
  }
}

