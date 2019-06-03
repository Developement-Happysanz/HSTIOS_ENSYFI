//
//  HolidayCalenderViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HolidayCalenderViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentcontrol;

@end
