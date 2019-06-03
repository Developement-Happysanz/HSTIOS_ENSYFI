//
//  AdminSettingsView.h
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminSettingsView : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
- (IBAction)updateBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *conformPaswrd;
@property (weak, nonatomic) IBOutlet UIButton *updateOutlet;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
