//
//  UIViewController+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NestMethods)

/**
 * Displays the HUD.
 *
 * @param title An optional short message to be displayed below the activity indicator. The HUD is automatically resized to fit
 * @note You need to make sure that the main thread completes its run loop soon after this method call so that
 * the user interface can be updated. Call this method when your task is already set up to be executed in a new thread
 * (e.g., when using something like NSOperation or making an asynchronous call like NSURLRequest).
 *
 */
- (void)displayProgressHUDWithTitle:(NSString * _Nullable)title;

/**
 * Finds the top-most HUD subview that hasn't finished and hides it. The counterpart to this method is displayProgressHUDWithTitle:.
`*/
- (void)hideProgressHUD;

/* Displays UIAlertViewController with `title`, `message` and default `OK` button. After click, alertviewcontroller will be dismissed
 * @param title First-Line text in alertController
 * @param message Subtitle text in alertController
*/
- (void)displayAlertViewControllerWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message;

/* Displays UIAlertViewController with `title` and `textField`.
 * @param title First-Line text in alertController
 * @param placeholder A placeholder text used during constructing `UITextField`
 * @param completion A block to call after user clicked `OK` button, contains text user entered in textField. Always executes on the main thread
 */
- (void)displayAlertViewControllerWithTitle:(NSString * _Nonnull)title textFieldPlaceholder:(NSString * _Nonnull)placeholder completionHandler:(nonnull void (^)(NSString * _Nullable text))completion;

@end
