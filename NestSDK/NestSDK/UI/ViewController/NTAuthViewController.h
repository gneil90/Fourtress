//
//  NTAuthViewController.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <UIKit/UIKit.h>

///Result codes returned when the autherization interface is dismissed.
typedef NS_ENUM(NSUInteger, NTAuthResult) {
  NTAuthResultCancelled,
  NTAuthResultSucceeded,
  NTAuthResultFailed
};

///The NTAuthViewControllerDelegate protocol defines the method that your delegate must implement to manage the authorization interface. The method of this protocol notifies your delegate object when the user has finished with the interface and is ready to dismiss it.

@class NTAuthViewController;
@protocol NTAuthViewControllerDelegate

- (void)authenticationController:(NTAuthViewController * _Nonnull)controller
          didFinishWithResult:(NTAuthResult)result
                        error:(NSError * _Nullable)error;
@end

/// The NTAuthViewControllerDataSource defines the method your datasource must implement to manage the location to send the user to for authorization
@protocol NTAuthViewControllerDataSource

- (NSURL * _Nonnull)authorizationURL:(NTAuthViewController * _Nonnull)controller;

@end

@interface NTAuthViewController : UIViewController

/// UIWebView which presents Nest authorization form
@property (weak, nonatomic, nullable) IBOutlet UIWebView * webView;

@property (weak, nonatomic, nullable) id <NTAuthViewControllerDelegate> delegate;
@property (weak, nonatomic, nullable) id <NTAuthViewControllerDataSource> dataSource;

/// xib fileName where IBOutlets are connected. Should be used in `initWithNibName:bundle:` method to initialized the NTAuthViewController
+ (NSString * _Nonnull)nibName;

@end
