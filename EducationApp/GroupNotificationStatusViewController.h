//
//  GroupNotificationStatusViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationStatusViewController : UIViewController<UITextFieldDelegate>
- (IBAction)notificationButton:(id)sender;
- (IBAction)addMemberButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *notificationOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMemberOutlet;
@property (weak, nonatomic) IBOutlet UITextField *deactiveLeadLabel;
@property (weak, nonatomic) IBOutlet UIView *titleDownView;
@property (weak, nonatomic) IBOutlet UIImageView *dropDownImageView;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextField *titleTxtfield;
@property (weak, nonatomic) IBOutlet UITextField *LeadTxtfield;
- (IBAction)editButton:(id)sender;
- (IBAction)updateButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *updateOutlet;
- (IBAction)backButton:(id)sender;
- (IBAction)switchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switchOutlet;
@end
