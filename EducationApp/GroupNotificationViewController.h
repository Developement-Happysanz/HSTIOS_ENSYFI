//
//  GroupNotificationViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
- (IBAction)plusButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
