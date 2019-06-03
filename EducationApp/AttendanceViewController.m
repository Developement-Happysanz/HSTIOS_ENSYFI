//
//  AttendanceViewController.m
//  EducationApp
//
//  Created by HappySanz on 19/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AttendanceViewController.h"

@interface AttendanceViewController ()
{
    NSMutableDictionary *eventsByDate;
    AppDelegate *appDel;
    NSMutableArray *ab_date;
    NSMutableArray *attendenceHistory;
}
@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    ab_date = [[NSMutableArray alloc]init];
    attendenceHistory = [[NSMutableArray alloc]init];

    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([stat_user_type isEqualToString:@"admin"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        self.navigationItem.leftBarButtonItem = backButton;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else if ([stat_user_type isEqualToString:@"teachers"])
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = backButton;
        
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];

    }
    self.mainView.layer.borderWidth = 1.0f;
    self.mainView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.subView.layer.borderWidth = 1.0f;
    self.subView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld\n%@", comps.year, monthText];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calenderMenuView];
    [self.calendar setContentView:self.calenderContentView];
    [self.calendar setDataSource:self];

//    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"msg_attendance_Key"];
//    if ([str isEqualToString:@"View Attendence"])
//    {
//        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"msg_attendance_Key"];
//
//        NSString *total_working_Days = [[NSUserDefaults standardUserDefaults]objectForKey:@"total_working_days_Key"];
//        NSString *absentDays= [[NSUserDefaults standardUserDefaults]objectForKey:@"absent_days_Key"];
//        NSString *odDays = [[NSUserDefaults standardUserDefaults]objectForKey:@"od_days_Key"];
//        NSString *presentDays = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"present_days_Key"]];
//        NSString *leaveDays = [[NSUserDefaults standardUserDefaults]objectForKey:@"leave_days_Key"];
//        
//        self.total_working_Days.text = [NSString stringWithFormat:@"%@",total_working_Days];
//        self.absentDays.text = [NSString stringWithFormat:@"%@",absentDays];
//        self.odDays.text = [NSString stringWithFormat:@"%@",odDays];
//        self.presentDays.text = [NSString stringWithFormat:@"%@",presentDays];
//        self.leaveDays.text = [NSString stringWithFormat:@"%@",leaveDays];
//
//        [self createRandomEvents];
//
//    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.student_id forKey:@"stud_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *forAttendance = @"/apistudent/disp_Attendence/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forAttendance, nil];
    NSString *api = [NSString pathWithComponents:components];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSArray *arr_Attendance = [responseObject objectForKey:@"attendenceDetails"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         [attendenceHistory removeAllObjects];
         if ([msg isEqualToString:@"View Attendence"])
         {
             
             attendenceHistory = [responseObject objectForKey:@"attendenceHistory"];
             NSLog(@"%@",attendenceHistory);
             NSString *absent_days = [attendenceHistory valueForKey:@"absent_days"];
             NSString *leave_days = [attendenceHistory valueForKey:@"leave_days"];
             NSString *od_days = [attendenceHistory valueForKey:@"od_days"];
             NSString *present_days = [attendenceHistory valueForKey:@"present_days"];
             NSString *total_working_days = [attendenceHistory valueForKey:@"total_working_days"];
             
             [ab_date removeAllObjects];
             
             for (int i = 0; i < [arr_Attendance count]; i++)
             {
                 NSDictionary *dict = [arr_Attendance objectAtIndex:i];
                 NSLog(@"%@",dict);
                 NSString *abDate= [dict valueForKey:@"abs_date"];
                 [ab_date addObject:abDate];
             }
             
             NSArray *abs_date = [NSArray arrayWithArray:ab_date];
             [[NSUserDefaults standardUserDefaults] setObject:abs_date forKey:@"abs_date_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:absent_days forKey:@"absent_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:leave_days forKey:@"leave_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:od_days forKey:@"od_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:present_days forKey:@"present_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:total_working_days forKey:@"total_working_days_Key"];
             
         }
         
         [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"msg_attendance_Key"];
         NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"msg_attendance_Key"];
         if ([str isEqualToString:@"View Attendence"])
         {
             [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"msg_attendance_Key"];
             NSString *total_working_Days = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"total_working_days_Key"]];
             NSString *absentDays= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"absent_days_Key"]];
             NSString *odDays = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"od_days_Key"]];
             NSString *presentDays = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"present_days_Key"]];
             NSString *leaveDays = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"leave_days_Key"]];
             
             if ([total_working_Days isEqualToString:@"0"] || [total_working_Days isEqualToString:@"1"])
             {
                 self.total_working_Days.text = [NSString stringWithFormat:@"%@ %@",total_working_Days,@"Day"];
             }
             else
             {
                 self.total_working_Days.text = [NSString stringWithFormat:@"%@ %@",total_working_Days,@"Days"];
             }
             if ([absentDays isEqualToString:@"0"] || [absentDays isEqualToString:@"1"])
             {
                 self.absentDays.text = [NSString stringWithFormat:@"%@ %@",absentDays,@"Day"];
             }
             else
             {
                 self.absentDays.text = [NSString stringWithFormat:@"%@ %@",absentDays,@"Days"];
             }
             if ([odDays isEqualToString:@"0"] || [odDays isEqualToString:@"1"])
             {
                 self.odDays.text = [NSString stringWithFormat:@"%@ %@",odDays,@"Day"];
             }
             else
             {
                 self.odDays.text = [NSString stringWithFormat:@"%@ %@",odDays,@"Days"];
             }
             if ([presentDays isEqualToString:@"0"] || [presentDays isEqualToString:@"1"])
             {
                 self.presentDays.text = [NSString stringWithFormat:@"%@ %@",presentDays,@"Day"];
             }
             else
             {
                 self.presentDays.text = [NSString stringWithFormat:@"%@ %@",presentDays,@"Days"];
             }
             if ([leaveDays isEqualToString:@"0"] || [leaveDays isEqualToString:@"1"])
             {
                 self.leaveDays.text = [NSString stringWithFormat:@"%@ %@",leaveDays,@"Day"];
             }
             else
             {
                 self.leaveDays.text = [NSString stringWithFormat:@"%@ %@",leaveDays,@"Days"];
             }
             [self createRandomEvents];
         }
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (IBAction)Back
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_key"];
    
    if ([str isEqualToString:@"teachers_attendance"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_key"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        AdminStudentProfileView *adminStudentProfileView = (AdminStudentProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentProfileView"];
        [self.navigationController pushViewController:adminStudentProfileView animated:YES];
    }
    
 // ios 6
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
// Update the position of calendar when rotate the screen, call `calendarDidLoadPreviousPage` or `calendarDidLoadNextPage`
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.calendar repositionViews];
}
- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}
- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    [self transitionExample];
}
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    NSLog(@"Date: %@ - %ld events", date, [events count]);
}
- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
}
- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode)
    {
        newHeight = 75.;
    }
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calenderContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calenderContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter)
    {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dateFormatter;
}
- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"abs_date_Key"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    for(int i = 0; i < [arr count]; ++i)
    {
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [dateFormatter dateFromString:arr[i]];
        //[NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        if(!eventsByDate[key])
        {
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];

    }
       [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"abs_date_Key"];
}
#pragma mark - CalendarManager delegate - Page mangement
// Used to limit the date for the calendar, optional
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
