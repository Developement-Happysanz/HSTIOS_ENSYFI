//
//  ForgotPasswordController.h
//  EducationApp
//
//  Created by HappySanz on 26/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordController : UIViewController<UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)conformBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *conformOutlet;
@property (weak, nonatomic) IBOutlet UITextField *username;

@end
