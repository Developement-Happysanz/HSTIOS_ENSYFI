//
//  TeacherSettingsViewController.h
//  EducationApp
//
//  Created by HappySanz on 18/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherSettingsViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *conformPaswrd;
- (IBAction)updateBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *updateOutlet;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
