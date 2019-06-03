//
//  Webservice.m
//  EducationApp
//
//  Created by HappySanz on 03/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "Webservice.h"
#import "AppDelegate.h"

@implementation Webservice
{
    AppDelegate *appDel;
}

+ (instancetype)sharedInstance
{
    static Webservice *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Webservice alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(id)init
{
    if (!self)
    {
        self = [super init];
    }
    managerObject = [AFHTTPSessionManager manager];    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return self;
}
-(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSLog(@"%@",data);
                                                if (error)
                                                    failure(error);
                                                else {
                                                    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                    NSLog(@"%@",json);
                                                    success(json);
                                                }
                                            }];
    [dataTask resume];    // Executed First
}
-(void)PostDataWithUrl:(nonnull NSString *)urlstr
        withParameters:(nullable id)parameters
           withSuccess:(nonnull void (^)(id _Nonnull responseObject))success
           withFailure:(nonnull void (^)(NSError * _Nonnull error))failure {
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    if (parameters) {
        [urlRequest setHTTPBody:[NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]]];
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
                                                           if(error == nil) {
                                                               
                                                               NSString *text = [[NSString alloc] initWithData:data
                                                                                                      encoding: NSUTF8StringEncoding];
                                                               NSLog(@"%@ :\n %@",urlstr,text);                                                               success(data);
                                                           }
                                                           else {
                                                               
                                                               failure(error);
                                                           }
                                                       }];
    [dataTask resume];
}
@end
