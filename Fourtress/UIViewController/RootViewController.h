//
//  RootViewController.h
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

/// IBOutlets

@property (weak, nonatomic, nullable) IBOutlet UIView * authorizationContainerView;
@property (weak, nonatomic, nullable) IBOutlet UIView * thermostatContainerView;
@property (weak, nonatomic, nullable) IBOutlet UIVisualEffectView * blurView;


@end
