//
//  AdminHolidayCalenderViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AdminHolidayCalenderViewController.h"

@interface AdminHolidayCalenderViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *leaveTitle;
    NSMutableArray *leaveReson;
    NSMutableArray *leaveDate;
    NSMutableArray *leaveDays;
    NSMutableArray *leaveImages;
    NSString *classSectionFlag;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;
}
@end

@implementation AdminHolidayCalenderViewController

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
    
    leaveTitle = [[NSMutableArray alloc]init];
    leaveReson = [[NSMutableArray alloc]init];
    leaveDate = [[NSMutableArray alloc]init];
    leaveDays = [[NSMutableArray alloc]init];
    leaveImages = [[NSMutableArray alloc]init];
    
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    
    CGRect frame= _segmentcontrol.frame;
    [_segmentcontrol setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,42)];
    
    _classBtnOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classBtnOtlet.layer.borderWidth = 1.0f;
    [_classBtnOtlet.layer setCornerRadius:10.0f];
    
    _sectionOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _sectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionOtlet.layer.borderWidth = 1.0f;
    [_sectionOtlet.layer setCornerRadius:10.0f];
    
    classSectionFlag = @"NA";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Section_Value"];
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
        NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
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
        else if ([selected_Section isEqualToString:@""])
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
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
            NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
            appDel.section_id = sec_id[fooIndex];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:appDel.class_id forKey:@"class_id"];
            [parameters setObject:appDel.section_id forKey:@"sec_id"];
            [parameters setObject:@"" forKey:@"class_sec_id"];
            
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
        NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
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
        else if ([selected_Section isEqualToString:@""])
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
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
            NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
            appDel.section_id = sec_id[fooIndex];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:appDel.class_id forKey:@"class_id"];
            [parameters setObject:appDel.section_id forKey:@"sec_id"];
            [parameters setObject:@"" forKey:@"class_sec_id"];
            
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
    classSectionFlag = @"YES";
    NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
    [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];
    CGFloat f ;
    if(dropDown == nil)
    {
        if(class_name.count < 3)
        {
           f = 200;
        }
        else
        {
            f = 300;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down"];
        [_sectionOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
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
- (IBAction)sectionBtn:(id)sender
{
    NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
    if (![selected_class_name isEqualToString:@""])
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
        NSUInteger fooIndex = [class_name indexOfObject:selected_class_name];
        NSArray *admin_class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_id"];
        appDel.class_id = admin_class_id[fooIndex];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.class_id forKey:@"class_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *forSections = @"/apiadmin/get_all_sections";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forSections, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [sec_id removeAllObjects];
             [sec_name removeAllObjects];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *se_id = [dict objectForKey:@"sec_id"];
                     NSString *se_name = [dict objectForKey:@"sec_name"];
                     
                     [sec_id addObject:se_id];
                     [sec_name addObject:se_name];
                 }
                 [[NSUserDefaults standardUserDefaults]setObject:sec_id forKey:@"admin_sec_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:sec_name forKey:@"admin_sec_name"];
                 if(dropDown == nil)
                 {
                     CGFloat f;
                     if (sec_name.count < 3)
                     {
                         f = 200;
                     }
                     else
                     {
                         f = 300;
                     }
                     dropDown = [[NIDropDown alloc]showDropDown:sender :&f :sec_name :nil :@"down"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"Section" forKey:@"sec_class"];
                     dropDown.delegate = self;
                 }
                 else {
                     [dropDown hideDropDown:sender];
                     [self rel];
                 }
            }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No Data Found."
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
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select the class"
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
@end
