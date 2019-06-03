//
//  TeacherHolidayCalenderViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherHolidayCalenderViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentcontrol;
@property (weak, nonatomic) IBOutlet UIButton *classBtnOtlet;
- (IBAction)classBtn:(id)sender;

@end
