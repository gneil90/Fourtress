//
//  ThermostatView.h
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThermostatViewModel.h"

@interface ThermostatView : UIView

@property (weak, nonatomic, nullable) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel * humidityLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel * targetTemperatureLabel;
@property (weak, nonatomic, nullable) IBOutlet UILabel * ambientTemperatureLabel;

/// Binds view properties with viewModel properties
- (void)bindViewModel:(ThermostatViewModel * _Nonnull)viewModel;

@end
