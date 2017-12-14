//
//  NTRestClient+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTRestClient+NestMethods.h"

@implementation NTRestClient (NestMethods)

- (RACSignal * _Nonnull)restSignalWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters {
  return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    void (^successBlock)(id response) = ^(id response) {
      NSError * error;
      if (!error && response) {
        [subscriber sendNext:response];
      } else {
        [subscriber sendError:error];
      }
      [subscriber sendCompleted];
    };
    
    void (^failureBlock)(NSError * error) = ^(NSError * error) {
      [subscriber sendError:error];
      [subscriber sendCompleted];
    };

    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:method
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                    redirect:^(id redirectURL) {
                                                                    }
                                                                     success:successBlock failure:failureBlock];
    
    // Starts the the network request once someone subscribes to the signal.
    [dataTask resume];
    
    // Creates and returns an RACDisposable object which handles any cleanup when the signal is destroyed.
    return [RACDisposable disposableWithBlock:^{
      [dataTask cancel];
    }];
  }] doError:^(NSError *error) {
    NTLogDebug(@"%@",error);
  }];
}

@end
