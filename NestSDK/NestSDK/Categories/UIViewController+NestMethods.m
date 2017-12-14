//
//  UIViewController+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "UIViewController+NestMethods.h"
#import "NSString+NestMethods.h"

@import MBProgressHUD;
@import ReactiveObjC.RACEXTScope;

@implementation UIViewController (NestMethods)

- (void)displayProgressHUDWithTitle:(NSString * _Nullable)title {
  MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.label.text = title;
}

- (void)hideProgressHUD {
  [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)displayAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController * alert = [UIAlertController
                               alertControllerWithTitle:title
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];
  
  //Add Buttons
  
  UIAlertAction* okButton = [UIAlertAction
                              actionWithTitle:[@"OK" localized]
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                [alert dismissViewControllerAnimated:true completion:nil];
                              }];
  
  //Add your buttons to alert controller
  
  [alert addAction:okButton];
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)displayAlertViewControllerWithTitle:(NSString *)title textFieldPlaceholder:(NSString *)placeholder completionHandler:(void (^)(NSString * text))completion {
  UIAlertController * alert = [UIAlertController
                               alertControllerWithTitle:title
                               message:nil
                               preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = placeholder;
  }];
  
  //Add Buttons
  
  UIAlertAction* okButton = [UIAlertAction
                             actionWithTitle:[@"OK" localized]
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                               NSString * enteredPIN = [[alert textFields][0] text];
                               completion(enteredPIN);
                             }];

  [alert addAction:okButton];
  
  [self presentViewController:alert animated:YES completion:nil];
}

@end
