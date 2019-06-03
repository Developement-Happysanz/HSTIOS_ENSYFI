//
//  TeacherHolidayCalenderViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "TeacherHolidayCalenderViewController.h"

@interface TeacherHolidayCalenderViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *leaveTitle;
    NSMutableArray *leaveReson;
    NSMutableArray *leaveDate;
    NSMutableArray *leaveDays;
    NSMutableArray *leaveImages;
    NSMutableArray *classSection_Name;
    
    NSArray *docPaths;
    NSString *documentsDir;
    NSString *dbPath;
    FMDatabase *database;
    FMResultSet *rs;
}
@end

@implementation TeacherHolidayCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
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
    
    _classBtnOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classBtnOtlet.layer.borderWidth = 1.0f;
    [_classBtnOtlet.layer setCornerRadius:10.0f];
    
    leaveTitle = [[NSMutableArray alloc]init];
    leaveReson = [[NSMutableArray alloc]init];
    leaveDate = [[NSMutableArray alloc]init];
    leaveDays = [[NSMutableArray alloc]init];
    leaveImages = [[NSMutableArray alloc]init];
    classSection_Name = [[NSMutableArray alloc]init];

    CGRect frame= _segmentcontrol.frame;
    [_segmentcontrol setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,42)];
    
    [_segmentcontrol setSelectedSegmentIndex:UISegmentedControlNoSegment];
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select distinct class_name,sec_name from table_create_teacher_handling_subjects"];
    [classSection_Name removeAllObjects];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"name :%@",[rs stringForColumn:@"class_name"]);
            NSString *strclass_name = [rs stringForColumn:@"class_name"];
            NSString *strsec_name = [rs stringForColumn:@"sec_name"];
            NSString *strClass_Section_Name = [NSString stringWithFormat:@"%@ %@",strclass_name,strsec_name];
            [classSection_Name addObject:strClass_Section_Name];
        }
    }
    [database close];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
}
- (void)didReceiveMemoryWarning {
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
    return [leaveTitle count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"cell";
    HolidayCalenderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[HolidayCalenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.leaveTitle.text = [NSString stringWithFormat:@"%@ %@",@"Title :",[leaveTitle objectAtIndex:indexPath.row]];
    cell.LeaveDate.text = [leaveDate objectAtIndex:indexPath.row];
    cell.leaveReson.text = [NSString stringWithFormat:@"%@ %@",@"Reson :",[leaveReson objectAtIndex:indexPath.row]];
    
    cell.cellView.layer.cornerRadius = 5;
    cell.cellView.clipsToBounds = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}
- (IBAction)segmentAction:(id)sender
{
    if (_segmentcontrol.selectedSegmentIndex == 1)
    {
        NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
        if ([selected_class_name isEqualToString:@""])
        {
            [_segmentcontrol setSelectedSegmentIndex:UISegmentedControlNoSegment];
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please select the class and section"
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
            NSArray *splitArray = [selected_class_name componentsSeparatedByString:@" "];
            NSString *class_name = [splitArray objectAtIndex:0];
            NSString *section_name = [splitArray objectAtIndex:1];
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select distinct class_master_id from table_create_teacher_handling_subjects where class_name = ? and sec_name = ?",class_name,section_name];
            NSString *strclass_master_id;
            if(rs)
            {
                while ([rs next])
                {
                    NSLog(@"name :%@",[rs stringForColumn:@"class_master_id"]);
                    strclass_master_id = [rs stringForColumn:@"class_master_id"];
                }
            }
            [database close];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:@"" forKey:@"class_id"];
            [parameters setObject:@"" forKey:@"sec_id"];
            [parameters setObject:strclass_master_id forKey:@"class_sec_id"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            /* concordanate with baseurl */
            NSString *forHomeWork = @"/apimain/disp_Leaves/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 if ([msg isEqualToString:@"View Leaves"])
                 {
                     NSArray *dataArray = [responseObject objectForKey:@"leaveDetails"];
                     [leaveTitle removeAllObjects];
                     [leaveDate removeAllObjects];
                     [leaveReson removeAllObjects];
                     [leaveDays removeAllObjects];
                     [leaveImages removeAllObjects];
                     for (int i = 0; i < [dataArray count];i++)
                     {
                         NSArray *Data = [dataArray objectAtIndex:i];
                         NSString *strLeaveTitle = [Data valueForKey:@"title"];
                         NSString *strStart  = [Data valueForKey:@"START"];
                         NSString *strdescrption = [Data valueForKey:@"description"];
                         NSString *strDay = [Data valueForKey:@"day"];
                         
                         if (strDay.length == 0)
                         {
                             strDay = @"";
                         }
                         if (strStart.length == 0)
                         {
                             strStart = @"";
                         }
                         
                         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                         NSDate *date  = [dateFormatter dateFromString:strStart];
                         [dateFormatter setDateFormat:@"MM-dd-yyyy"];
                         NSString *newDate = [dateFormatter stringFromDate:date];
                         
                         NSString *Daydate = [NSString stringWithFormat:@"%@ (%@)",strDay,newDate];
                         
                         [leaveTitle addObject:strLeaveTitle];
                         [leaveDate addObject:Daydate];
                         [leaveReson addObject:strdescrption];
                     }
                     self.tableView.hidden = NO;
                     [self.tableView reloadData];
                 }
                 else
                 {
                     self.tableView.hidden = YES;
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
    }
    else if(_segmentcontrol.selectedSegmentIndex == 0)
    {
        NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
        if ([selected_class_name isEqualToString:@""])
        {
            [_segmentcontrol setSelectedSegmentIndex:UISegmentedControlNoSegment];
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please select the class and section"
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
            NSArray *splitArray = [selected_class_name componentsSeparatedByString:@" "];
            NSString *class_name = [splitArray objectAtIndex:0];
            NSString *section_name = [splitArray objectAtIndex:1];
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select distinct class_master_id from table_create_teacher_handling_subjects where class_name = ? and sec_name = ?",class_name,section_name];
            NSString *strclass_master_id;
            if(rs)
            {
                while ([rs next])
                {
                    NSLog(@"name :%@",[rs stringForColumn:@"class_master_id"]);
                    strclass_master_id = [rs stringForColumn:@"class_master_id"];
                }
            }
            [database close];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:@"" forKey:@"class_id"];
            [parameters setObject:@"" forKey:@"sec_id"];
            [parameters setObject:strclass_master_id forKey:@"class_sec_id"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            
            /* concordanate with baseurl */
            NSString *forHomeWork = @"/apimain/disp_upcomingLeaves/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 if ([msg isEqualToString:@"View Leaves"])
                 {
                     NSArray *dataArray = [responseObject objectForKey:@"upcomingleavesDetails"];
                     [leaveTitle removeAllObjects];
                     [leaveDate removeAllObjects];
                     [leaveReson removeAllObjects];
                     [leaveDays removeAllObjects];
                     [leaveImages removeAllObjects];
                     for (int i = 0; i < [dataArray count];i++)
                     {
                         NSArray *Data = [dataArray objectAtIndex:i];
                         NSString *strLeaveTitle = [Data valueForKey:@"title"];
                         NSString *strStart  = [Data valueForKey:@"START"];
                         NSString *strdescrption = [Data valueForKey:@"description"];
                         NSString *strDay = [Data valueForKey:@"day"];
                         
                         if (strDay.length == 0)
                         {
                             strDay = @"";
                         }
                         if (strStart.length == 0)
                         {
                             strStart = @"";
                         }
                         
                         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                         [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                         NSDate *date  = [dateFormatter dateFromString:strStart];
                         [dateFormatter setDateFormat:@"MM-dd-yyyy"];
                         NSString *newDate = [dateFormatter stringFromDate:date];
                         
                         NSString *Daydate = [NSString stringWithFormat:@"%@ (%@)",strDay,newDate];
                         
                         [leaveTitle addObject:strLeaveTitle];
                         [leaveDate addObject:Daydate];
                         [leaveReson addObject:strdescrption];
                     }
                     self.tableView.hidden = NO;
                     [self.tableView reloadData];
                 }
                 else
                 {
                     self.tableView.hidden = YES;
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
    }
}
- (IBAction)classBtn:(id)sender
{
    if(dropDown == nil)
    {
        CGFloat f ;
        if(classSection_Name.count < 3)
        {
            f = 300;
        }
        else
        {
            f = 200;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :classSection_Name :nil :@"down"];
        [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void)niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}
-(void)rel
{
    dropDown = nil;
}
@end
