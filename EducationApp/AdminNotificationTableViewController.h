//
//  AdminNotificationTableViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/03/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminNotificationTableViewController : UITableViewController<UITextViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarBtn;
- (IBAction)backButton:(id)sender;
@end
