//
//  NTAuthViewController.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTAuthViewController.h"
#import "NTAuthorizationService.h"
#import "NSString+NestMethods.h"
#import "UIViewController+NestMethods.h"
#import "Nest.h"
#import "NTConstants.h"
#import "NTAuthViewModel.h"
#import "NSError+NestMethods.h"
#import "NTConstants.h"

@import ReactiveObjC;

@interface NTAuthViewController ()

@property (strong, nonatomic) NTAuthViewModel * viewModel;

@end

@implementation NTAuthViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithTitle:[@"Cancel" localized] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPressed:)];
  UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithTitle:[@"Authorize" localized] style:UIBarButtonItemStylePlain target:self action:@selector(authorizePressed:)];
  
  self.navigationItem.rightBarButtonItem = rightBarButton;
  self.navigationItem.leftBarButtonItem = leftBarButton;
  
  NSURL * url = [self.dataSource authorizationURL:self];
  NSURLRequest * request = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:request];
  
  [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReactiveCocoa

// Subscribe to ReactiveCocoa events and bind UI elements , such as Authorization success and PIN code changes
- (void)bindViewModel {
  self.viewModel = [NTAuthViewModel new];
  
  @weakify(self)
  
  [[RACObserve(self.viewModel, isBusy) deliverOnMainThread] subscribeNext:^(id  _Nullable isBusy) {
    @strongify(self)
    if ([isBusy boolValue]) {
      [self displayProgressHUDWithTitle:nil];
      self.navigationItem.rightBarButtonItem.enabled = false;
      self.navigationItem.leftBarButtonItem.enabled = false;
    } else {
      [self hideProgressHUD];
      self.navigationItem.rightBarButtonItem.enabled = true;
      self.navigationItem.leftBarButtonItem.enabled = true;
    }
  }];

  [[[RACObserve(self.viewModel, error) ignore:nil] deliverOnMainThread] subscribeNext:^(NSError * error) {
    @strongify(self)
    [self displayAlertViewControllerWithTitle:[@"Error" localized] message:error.localizedDescription];
  }];
  
  [[[RACObserve(self.viewModel, isAuthorized) ignore:@NO] deliverOnMainThread] subscribeNext:^(id token) {
    @strongify(self)
    [self.delegate authenticationController:self didFinishWithResult:NTAuthResultSucceeded error:nil];
  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark- Bar Button Actions

- (void)cancelPressed:(id)sender {
  [[NTAuthorizationService sharedService] resetAccessToken];
  [self.delegate authenticationController:self didFinishWithResult:NTAuthResultCancelled error:nil];
}

- (void)authorizePressed:(id)sender {
  [self displayAlertViewControllerWithTitle:[@"Enter PIN" localized]  textFieldPlaceholder:[@"Enter the PIN code you see on the page" localized] completionHandler:^(NSString * _Nullable text) {
    if (text && [text length] > 0) {
      self.viewModel.pinCode = text;
    } else {
      self.viewModel.error = [NSError errorWithMessage:[@"PIN code must be non-empty value" localized] code:NTErrorCodeAuthorization];
    }
  }];
}

#pragma mark- Helpers

+ (NSString * _Nonnull)nibName {
  return NSStringFromClass([self class]);
}

@end
