//
//  NewTimeTableViewcontroller.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 25/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface NewTimeTableViewcontroller : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarbutton;

@end
