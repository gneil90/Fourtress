//
//  RootViewModel.h
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootViewModel : NSObject

/// Indicates if there is a valid access token in the Keychain
@property (readonly, nonatomic) BOOL loggedIn;

@end
