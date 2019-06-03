//
//  AttendanceViewController.h
//  EducationApp
//
//  Created by HappySanz on 19/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
#import "JTCalendar.h"

@interface AttendanceViewController : UIViewController<UIGestureRecognizerDelegate,JTCalendarDataSource>
@property (strong, nonatomic) IBOutlet UILabel *absentDays;
@property (strong, nonatomic) IBOutlet UILabel *leaveDays;
@property (strong, nonatomic) IBOutlet UILabel *odDays;
@property (strong, nonatomic) IBOutlet UILabel *presentDays;
@property (strong, nonatomic) IBOutlet UILabel *total_working_Days;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calenderContentView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calenderMenuView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;
@end
