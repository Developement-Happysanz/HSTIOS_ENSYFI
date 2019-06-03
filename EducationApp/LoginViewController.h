//
//  LoginViewController.h
//  EducationApp
//
//  Created by HappySanz on 06/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FMDatabase.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *schoolname;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *signInOtlet;
- (IBAction)signInBtn:(id)sender;
- (IBAction)forgotPaswrdBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) NSString *databasepath;

@end
