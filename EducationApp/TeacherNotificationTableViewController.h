//
//  TeacherNotificationTableViewController.h
//  EducationApp
//
//  Created by HappySanz on 18/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherNotificationTableViewController : UITableViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBar;
- (IBAction)plusButton:(id)sender;

@end
