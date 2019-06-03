//
//  Webservice.h
//  EducationApp
//
//  Created by HappySanz on 03/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
@interface Webservice : NSObject
{
    AFHTTPSessionManager *managerObject;
}

+(Webservice * _Nonnull)sharedInstance;
-(nonnull id)init;

-(void)getJsonResponse:(nonnull NSString *)urlStr success:(nonnull void (^)(NSDictionary *_Nonnull responseDict))success failure:(nonnull void(^)(NSError * _Nonnull error))failure;

-(void)PostDataWithUrl:(nonnull NSString *)urlstr
        withParameters:(nullable id)parameters
           withSuccess:(nonnull void (^)(id _Nonnull responseObject))
success withFailure:(nonnull void (^)(NSError * _Nonnull error))failure;

@end
