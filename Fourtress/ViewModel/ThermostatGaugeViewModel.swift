//
//  ThermostatGaugeViewModel.swift
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/14/17.
//  Copyright © 2017 Nest. All rights reserved.
//

import RxSwift
import Foundation
import NestSDK

class ThermostatGaugeViewModel : ThermostatViewModel {
  var isUpdadingThermostat = Variable(false)
  var targetTemperatureC = Variable<Float>(0)
  
  override init() {
    super.init()
    
    let _ = self.targetTemperatureC.asObservable().skip(1).subscribe { event in
      guard let newValue = event.element, let deviceId = self.thermostat?.deviceId else {
        return
      }
      
      self.isUpdadingThermostat.value = true
      
      let mergedSignal = NTDeviceApiService.shared().setTargetTemperature(Int(newValue), forThermostat: deviceId).flattenMap({ (response) -> RACSignal<AnyObject>? in
        return self.fetchThermostatSignal()
      })
      
      mergedSignal.subscribeNext({ (response) in
        self.isUpdadingThermostat.value = false
      }, error: { (error) in
        self.isUpdadingThermostat.value = false
      })
    }
  }  
}
