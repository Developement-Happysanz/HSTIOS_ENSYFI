//
//  NewTeachetNotifiationViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 14/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTeachetNotifiationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
