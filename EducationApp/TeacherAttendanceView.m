//
//  TeacherAttendanceView.m
//  EducationApp
//
//  Created by HappySanz on 23/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherAttendanceView.h"

@interface TeacherAttendanceView ()
{
    AppDelegate *appDel;
    NSMutableArray *classNameArr;
    NSMutableArray *academic_monthsArr;
    
    NSMutableArray *a_status;
    NSMutableArray *name;
    
    NSMutableArray *montha_status;
    NSMutableArray *Month_name;
    NSMutableArray *month_leaves;
    NSMutableArray *Month_leavedates;

    NSMutableArray *month_enroll_id;
    
    UIToolbar *toolBar;
}
@end

@implementation TeacherAttendanceView

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    classNameArr = [[NSMutableArray alloc]init];
    academic_monthsArr = [[NSMutableArray alloc]init];
    a_status = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    
    montha_status = [[NSMutableArray alloc]init];
    Month_name = [[NSMutableArray alloc]init];
    month_leaves = [[NSMutableArray alloc]init];
    Month_leavedates = [[NSMutableArray alloc]init];
    month_enroll_id = [[NSMutableArray alloc]init];
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebar setTarget: self.revealViewController];
        [self.sidebar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _selectBtnOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _selectBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _selectBtnOtlet.layer.borderWidth = 1.0f;
    [_selectBtnOtlet.layer setCornerRadius:10.0f];
    
    _selectMonthOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _selectMonthOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _selectMonthOtlet.layer.borderWidth = 1.0f;
    [_selectMonthOtlet.layer setCornerRadius:10.0f];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *rs = [database executeQuery:@"SELECT DISTINCT (class_section) From table_create_teacher_student_details"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"Class_Section :%@",[rs stringForColumn:@"class_section"]);
            NSString *class_section = [rs stringForColumn:@"class_section"];
            [classNameArr addObject:class_section];
        }
    }
    [database close];
    NSArray *docPaths_table_create_academic_months = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir_table_create_academic_months = [docPaths_table_create_academic_months objectAtIndex:0];
    NSString *dbPath_table_create_academic_months = [documentsDir_table_create_academic_months  stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database_table_create_academic_months = [FMDatabase databaseWithPath:dbPath_table_create_academic_months];
    [database_table_create_academic_months open];
    FMResultSet *rs_table_create_academic_months = [database_table_create_academic_months executeQuery:@"SELECT * From table_create_academic_months"];
    if(rs_table_create_academic_months)
    {
        while ([rs_table_create_academic_months next])
        {
            NSLog(@"Class_Section :%@",[rs_table_create_academic_months stringForColumn:@"academic_months"]);
            NSString *academic_months = [rs_table_create_academic_months stringForColumn:@"academic_months"];
            [academic_monthsArr addObject:academic_months];
        }
    }
    [database_table_create_academic_months close];
    _selectMonthOtlet.hidden =YES;
    _selectMonthOtlet.enabled =NO;
    self.dayTextfiled.hidden = NO;
    self.dayTextfiled.enabled = YES;
    self.selectMonthImg.hidden = YES;
    self.tableview.hidden = YES;
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    self.dayTextfiled.text = dateString;

    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.dayTextfiled setInputView:datePicker];
    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(ShowsCancelButton)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:cancelBtn,space,doneBtn, nil]];
    [self.dayTextfiled setInputAccessoryView:toolBar];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"class_id_key"];
}
-(void)ShowSelectedDate
{
    NSString *class_id_day = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];

    if ([class_id_day isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please the Class"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"dd-MM-yyyy"];
        self.dayTextfiled.text=[NSString stringWithFormat:@"%@",[formatter2 stringFromDate:datePicker.date]];
        [self.dayTextfiled resignFirstResponder];
        NSString *selectedDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:class_id_day forKey:@"class_id"];
        [parameters setObject:@"day" forKey:@"disp_type"];
        [parameters setObject:selectedDate forKey:@"disp_date"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        /* concordanate with baseurl */
        NSString *disp_Attendence = @"/apiteacher/disp_Attendence/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Attendence, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status =[responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"View Attendence"] && [status isEqualToString:@"success"])
             {
                 [[NSUserDefaults standardUserDefaults]setObject:@"day" forKey:@"dayType_key"];
                 
                 NSArray *attendenceDetails = [responseObject objectForKey:@"attendenceDetails"];
                 
                 [a_status removeAllObjects];
                 [name removeAllObjects];
                 
                 for (int i =0; i < [attendenceDetails count]; i++)
                 {
                     NSDictionary *dict = [attendenceDetails objectAtIndex:i];
                     NSString *str_a_status = [dict objectForKey:@"a_status"];
                     NSString *str_name = [dict objectForKey:@"name"];
                     
                     [a_status addObject:str_a_status];
                     [name addObject:str_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:@"day" forKey:@"view_type"];
                 
                 [self.tableview reloadData];
                 
                 self.tableview.hidden = NO;
                 
                 
             }
             else
             {
                 self.tableview.hidden = YES;

                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:msg
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 
             }
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    
}
-(void)ShowsCancelButton
{
    [datePicker removeFromSuperview];
    [self.dayTextfiled resignFirstResponder];
    [toolBar removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (_segmentControl.selectedSegmentIndex==0)
    {
        return [name count];
    }
    else
    {
        return [Month_name count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherAttendanceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherAttendanceTableCell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"view_type"];
    
    if ([str isEqualToString:@"day"])
    {
        cell.statusColor.hidden = NO;
        cell.statusLabel.hidden = NO;
        cell.monthLeaveLabel.hidden = YES;
        cell.serialNumber.text = [NSString stringWithFormat:@"%li.", indexPath.row +1];
        cell.monthLeaveLabel.hidden = YES;
        
        cell.statusLabel.text = [a_status objectAtIndex:indexPath.row];
        if ([cell.statusLabel.text isEqualToString:@"OD"])
        {
            cell.studentName.text = [name objectAtIndex:indexPath.row];
            cell.statusColor.image = [UIImage imageNamed:@"Red"];
        }
        else if ([cell.statusLabel.text isEqualToString:@"A"])
        {
            cell.studentName.text = [name objectAtIndex:indexPath.row];
            cell.statusLabel.text = @"Absent";
            cell.statusColor.image = [UIImage imageNamed:@"Red"];
        }
        else if ([cell.statusLabel.text isEqualToString:@"P"])
        {
            cell.studentName.text = [name objectAtIndex:indexPath.row];
            cell.statusLabel.text = @"Present";
            cell.statusColor.image = [UIImage imageNamed:@"Green"];
        }
        else if ([cell.statusLabel.text isEqualToString:@"L"])
        {
            cell.studentName.text = [name objectAtIndex:indexPath.row];
            cell.statusLabel.text = @"Leave";
            cell.statusColor.image = [UIImage imageNamed:@"Orange"];
        }
    }
    else
    {
        cell.statusColor.hidden = YES;
        cell.statusLabel.hidden = YES;
        cell.monthLeaveLabel.hidden = NO;
        cell.serialNumber.text = [NSString stringWithFormat:@"%li.", indexPath.row +1];
        cell.statusLabel.text = [montha_status objectAtIndex:indexPath.row];
        if ([cell.statusLabel.text isEqualToString:@"OD"])
        {
            cell.studentName.text = [Month_name objectAtIndex:indexPath.row];
            NSString *strleave = [month_leaves objectAtIndex:indexPath.row];
            float theFloat = [strleave floatValue];
            NSString * allDigits = [NSString stringWithFormat:@"%f", theFloat];
            NSString * topDigits = [allDigits substringToIndex:3];
            cell.monthLeaveLabel.text= [NSString stringWithFormat:@"%@ %@",topDigits,@"Days Leave"];
            cell.monthLeaveLabel.textColor = [UIColor redColor];
        }
        else if ([cell.statusLabel.text isEqualToString:@"L"])
        {
            cell.studentName.text = [Month_name objectAtIndex:indexPath.row];
            NSString *strleave = [month_leaves objectAtIndex:indexPath.row];
            float theFloat = [strleave floatValue];
            NSString * allDigits = [NSString stringWithFormat:@"%f", theFloat];
            NSString * topDigits = [allDigits substringToIndex:3];
            cell.monthLeaveLabel.text= [NSString stringWithFormat:@"%@ %@",topDigits,@"Days Leave"];
            cell.monthLeaveLabel.textColor = [UIColor redColor];
        }
        else if ([cell.statusLabel.text isEqualToString:@"A"])
        {
            cell.studentName.text = [Month_name objectAtIndex:indexPath.row];
            NSString *strleave = [month_leaves objectAtIndex:indexPath.row];
            float theFloat = [strleave floatValue];
            NSString * allDigits = [NSString stringWithFormat:@"%f", theFloat];
            NSString * topDigits = [allDigits substringToIndex:3];
            cell.monthLeaveLabel.text= [NSString stringWithFormat:@"%@ %@",topDigits,@"Days Leave"];
            cell.monthLeaveLabel.textColor = [UIColor redColor];
        }
        else if ([cell.statusLabel.text isEqualToString:@"P"])
        {
            cell.studentName.text = [Month_name objectAtIndex:indexPath.row];
            cell.monthLeaveLabel.text = @"No leave";
            cell.monthLeaveLabel.textColor = [UIColor colorWithRed:37/255.0f green:163/255.0f blue:79/255.0f alpha:1];
        }
    }

    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 49;
        
    }
    else
    {
        return 49;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"view_type"];
    
    if ([str isEqualToString:@"month"])
    {
        NSString *no_leave = [montha_status objectAtIndex:indexPath.row];
        
        if ([no_leave isEqualToString:@"P"])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"No leave"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            if ([str isEqualToString:@"month"])
            {
                NSString *studentId = [month_enroll_id objectAtIndex:indexPath.row];
                
                [[NSUserDefaults standardUserDefaults]setObject:studentId forKey:@"studentId_key"];
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                AttendanceDateView *myNewVC = (AttendanceDateView *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceDateView"];
                [self.navigationController pushViewController:myNewVC animated:YES];
            }
        }
    }
    else
    {
        
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)selectBtn:(id)sender
{
    if(dropDown == nil)
    {
        
        CGFloat f = 300;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :classNameArr :nil :@"down" :self.view];
        [[NSUserDefaults standardUserDefaults]setObject:@"teacher_attendance" forKey:@"teacher_attendanceKey"];
        [_selectBtnOtlet setTitle:@"Class & Section" forState:UIControlStateNormal];
        _selectBtnOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
        [[NSUserDefaults standardUserDefaults]setObject:@"classSection" forKey:@"button_type"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)segementButton:(id)sender
{
    if(_segmentControl.selectedSegmentIndex==0)
    {
        _selectMonthOtlet.hidden =YES;
        _selectMonthOtlet.enabled =NO;

        self.dayTextfiled.hidden = NO;
        self.dayTextfiled.enabled = YES;
        
        self.calenderImg.hidden = NO;
        
        _selectMonthImg.hidden = YES;
        
        [self.tableview reloadData];

    }
    else
    {
        _selectMonthOtlet.hidden =NO;
        _selectMonthOtlet.enabled =YES;
        _selectMonthImg.hidden = NO;
        self.dayTextfiled.hidden = YES;
        self.dayTextfiled.enabled = YES;
        self.calenderImg.hidden = YES;
        
        [self.tableview reloadData];
    }
}
- (IBAction)selectMonthBtn:(id)sender
{
    NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];

    if (![db_class_name isEqualToString:@""])
    {
        CGFloat f;
        if(dropDown == nil)
        {
            if ([academic_monthsArr count] > 8)
            {
                f = 130;
            }
            else
            {
                f = 130;
            }
            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :academic_monthsArr :nil :@"down" :self.view];
            [[NSUserDefaults standardUserDefaults]setObject:@"teacher_attendance" forKey:@"teacher_attendanceKey"];
            [_selectMonthOtlet setTitle:@"Select Month" forState:UIControlStateNormal];
            _selectBtnOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
            [[NSUserDefaults standardUserDefaults]setObject:@"selectMonth" forKey:@"button_type"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:sender];
            [self rel];
        }
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please select the class & section"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}
-(void)rel
{
    dropDown = nil;
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"button_type"];
    if ([str isEqualToString:@"selectMonth"])
    {
        
        NSString *class_id_month = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
        NSString *db_month = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormat stringFromDate:today];
        NSLog(@"date: %@", dateString);
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:class_id_month forKey:@"class_id"];
        [parameters setObject:@"month" forKey:@"disp_type"];
        [parameters setObject:db_month forKey:@"month_year"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        /* concordanate with baseurl */
        NSString *disp_Attendence = @"/apiteacher/disp_Attendence/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Attendence, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];

             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status =[responseObject objectForKey:@"status"];
             
             NSLog(@"%@%@",msg,status);
             
             if ([msg isEqualToString:@"View Attendence"] && [status isEqualToString:@"success"])
             {
                 NSArray *attendenceDetails = [responseObject objectForKey:@"attendenceDetails"];
                 
                 [montha_status removeAllObjects];
                 [Month_leavedates removeAllObjects];
                 [month_leaves removeAllObjects];
                 [Month_name removeAllObjects];
                 [month_enroll_id removeAllObjects];
                 
                 for (int i = 0; i < [attendenceDetails count]; i++)
                 {
                     NSDictionary *month_dict = [attendenceDetails objectAtIndex:i];
                     NSString *strMonth_a_status = [month_dict objectForKey:@"a_status"];
                     NSString *strMonth_abs_date = [month_dict objectForKey:@"abs_date"];
                     NSString *strMonth_leaves = [month_dict objectForKey:@"leaves"];
                     NSString *strMonth_name = [month_dict objectForKey:@"name"];
                     NSString *strMonth_enroll_id = [month_dict objectForKey:@"enroll_id"];
                     
                     [montha_status addObject:strMonth_a_status];
                     [Month_leavedates addObject:strMonth_abs_date];
                     [month_leaves addObject:strMonth_leaves];
                     [Month_name addObject:strMonth_name];
                     [month_enroll_id addObject:strMonth_enroll_id];
                     
                 }
                 [[NSUserDefaults standardUserDefaults]setObject:@"month" forKey:@"view_type"];

                 [self.tableview reloadData];
                 
                 self.tableview.hidden = NO;

             }
             else
             {
                 self.tableview.hidden = YES;

                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:msg
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             

         }

              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }

    else
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *class_id;
        NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        FMResultSet *rs = [database executeQuery:@"Select distinct class_id from table_create_teacher_student_details where class_section= ?",db_class_name];
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"Class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id = [rs stringForColumn:@"class_id"];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];;
        [database close];
        self.tableview.hidden = YES;
    }
}
- (IBAction)plusBtn:(id)sender
{
    [self navigateToMyNewViewController];
}
- (void)navigateToMyNewViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherAttendanceFormView *myNewVC = (TeacherAttendanceFormView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherAttendanceFormView"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
@end
