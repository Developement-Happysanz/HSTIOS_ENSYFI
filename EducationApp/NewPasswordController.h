//
//  NewPasswordController.h
//  EducationApp
//
//  Created by HappySanz on 26/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPasswordController : UIViewController<UITextFieldDelegate>
- (IBAction)confrmBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cnfrmOutlet;
@property (weak, nonatomic) IBOutlet UITextField *confrmpswd;
@property (weak, nonatomic) IBOutlet UITextField *newpswd;

@end
