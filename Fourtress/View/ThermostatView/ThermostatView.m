//
//  ThermostatView.m
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "ThermostatView.h"

@import ReactiveObjC;

@import NestSDK;

@interface ThermostatView()

@property (strong, nonatomic, nonnull) ThermostatViewModel * viewModel;

@end

@implementation ThermostatView


- (void)bindViewModel:(ThermostatViewModel *)viewModel {
  self.viewModel = viewModel;
  
  @weakify(self)
  
  [[[[RACObserve(self.viewModel, thermostat) ignore:nil] take:1] deliverOnMainThread] subscribeNext:^(id  thermostat) {
    @strongify(self)
    // Each time refreshing or name changed, update the label
    [[[RACSignal combineLatest:@[RACObserve(self.viewModel.thermostat, nameLong), RACObserve(self.viewModel, isRefreshing)] reduce:^id (NSString * name, NSNumber * refreshing) {
      if (![refreshing boolValue] && name) {
        return name;
      } else {
        return [@"Refreshing..." localized];
      }
    }] deliverOnMainThread] subscribeNext:^(NSString * title) {
      @strongify(self)
      self.titleLabel.text = title;
    }];
    
    RAC(self, ambientTemperatureLabel.text) = [[[RACObserve(self.viewModel.thermostat, ambientTemperatureC) ignore:nil] map:^id _Nullable(id  _Nullable value) {
      return [NSString stringWithFormat:@"%d°", [value intValue]];
    }] deliverOnMainThread];
    
    RAC(self, humidityLabel.text) = [[[RACObserve(self.viewModel.thermostat, humidity) ignore:nil] map:^id _Nullable(id  _Nullable value) {
      return [NSString stringWithFormat:@"%d%%", [value intValue]];
    }] deliverOnMainThread];
    
    RAC(self, targetTemperatureLabel.text) = [[[RACObserve(self.viewModel.thermostat, targetTemperatureC) ignore:nil] map:^id _Nullable(id  _Nullable value) {
      return [NSString stringWithFormat:@"%d°", [value intValue]];
    }] deliverOnMainThread];
  }];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
