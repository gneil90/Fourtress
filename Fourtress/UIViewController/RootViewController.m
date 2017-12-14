//
//  RootViewController.m
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "RootViewController.h"
#import "RootViewModel.h"
#import "Fourtress-Swift.h"

@import ReactiveObjC;

@interface RootViewController ()

@property (strong, nonatomic) RootViewModel * viewModel;

@property (weak, nonatomic) ThermostatViewController * thermostatViewController;
@property (weak, nonatomic) CustomAuthViewController * customAuthViewController;

@end

@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/// Wiring the interface
- (void)bindViewModel {
  self.viewModel = [RootViewModel new];

  // Observes the loggedIn keypath on the viewModel and delivers changes on Main Thread since we are going to update the UI
  @weakify(self)
  [RACObserve(self.viewModel, loggedIn) subscribeNext:^(id  _Nullable x) {
    @strongify(self)
    
    BOOL isLoggedIn = [x boolValue];
    self.authorizationContainerView.hidden = isLoggedIn;
    self.thermostatContainerView.hidden = !isLoggedIn;
    
    [UIView animateWithDuration:0.1 animations:^{
      self.blurView.alpha = isLoggedIn ? 0 : 1;
    }];
  }];
  
  // Smooth alpha transition based on the content offset
  [RACObserve(self.thermostatViewController, scrollView.contentOffset) subscribeNext:^(id x) {
    @strongify(self)

    if (!self.thermostatContainerView.hidden) {
      UIScrollView * scrollView = self.thermostatViewController.scrollView;
      CGFloat height = scrollView.bounds.size.height;
      CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
      CGFloat percent = MIN(position / height, 0.90);
      self.blurView.alpha = percent;
    }
  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  id destinationViewController = [segue destinationViewController];
  
  // Initialize embeded view controllers
  if ([destinationViewController isKindOfClass:[CustomAuthViewController class]]) {
    self.customAuthViewController = destinationViewController;
  } else if ([destinationViewController isKindOfClass:[ThermostatViewController class]]) {
    self.thermostatViewController = destinationViewController;
  }
}


@end
