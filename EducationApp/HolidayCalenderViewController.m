//
//  HolidayCalenderViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "HolidayCalenderViewController.h"

@interface HolidayCalenderViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *leaveTitle;
    NSMutableArray *leaveReson;
    NSMutableArray *leaveDate;
    NSMutableArray *leaveDays;
    NSMutableArray *leaveImages;
}
@end

@implementation HolidayCalenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
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
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    leaveTitle = [[NSMutableArray alloc]init];
    leaveReson = [[NSMutableArray alloc]init];
    leaveDate = [[NSMutableArray alloc]init];
    leaveDays = [[NSMutableArray alloc]init];
    leaveImages = [[NSMutableArray alloc]init];
    
    CGRect frame= _segmentcontrol.frame;
    [_segmentcontrol setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,42)];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_type forKey:@"user_type"];
    [parameters setObject:@"" forKey:@"class_id"];
    [parameters setObject:@"" forKey:@"sec_id"];
    [parameters setObject:appDel.class_id forKey:@"class_sec_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *disp_upcomingLeaves = @"/apimain/disp_upcomingLeaves/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_upcomingLeaves, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"View Leaves"])
         {
             [self->leaveTitle removeAllObjects];
             [self->leaveDate removeAllObjects];
             [self->leaveReson removeAllObjects];
             [self->leaveDays removeAllObjects];
             [self->leaveImages removeAllObjects];
             
             NSArray *dataArray = [responseObject objectForKey:@"upcomingleavesDetails"];
             for (int i = 0; i < [dataArray count];i++)
             {
                 NSArray *Data  = [dataArray objectAtIndex:i];
                 NSString *strLeaveTitle = [Data valueForKey:@"title"];
                 NSString *strStart  = [Data valueForKey:@"START"];
                 NSString *strdescrption = [Data valueForKey:@"description"];
                 NSString *strDay = [Data valueForKey:@"day"];
                 
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 NSDate *date  = [dateFormatter dateFromString:strStart];
                 [dateFormatter setDateFormat:@"MM-dd-yyyy"];
                 NSString *newDate = [dateFormatter stringFromDate:date];
                 NSString *Daydate = [NSString stringWithFormat:@"%@ (%@)",strDay,newDate];
                 
                 if (strDay.length == 0)
                 {
                     strDay = @"";
                 }
                 if (strStart.length == 0)
                 {
                     strStart = @"";
                 }
                 
                 [self->leaveTitle addObject:strLeaveTitle];
                 [self->leaveDate addObject:Daydate];
                 [self->leaveReson addObject:strdescrption];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    CGRect frame= _segmentcontrol.frame;
    [_segmentcontrol setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 45)];
    
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
    cell.leaveTitle.text = [leaveTitle objectAtIndex:indexPath.row];
    cell.LeaveDate.text = [leaveDate objectAtIndex:indexPath.row];
    cell.leaveReson.text = [leaveReson objectAtIndex:indexPath.row];
    
    
    cell.cellView.layer.shadowRadius  = 5.5f;
    cell.cellView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.cellView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.cellView.layer.shadowOpacity = 0.6f;
    cell.cellView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.cellView.bounds, shadowInsets)];
    cell.cellView.layer.shadowPath    = shadowPath.CGPath;
    
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        [parameters setObject:@"" forKey:@"class_id"];
        [parameters setObject:@"" forKey:@"sec_id"];
        [parameters setObject:appDel.class_id forKey:@"class_sec_id"];
        
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
                 [self->leaveTitle removeAllObjects];
                 [self->leaveDate removeAllObjects];
                 [self->leaveReson removeAllObjects];
                 [self->leaveDays removeAllObjects];
                 [self->leaveImages removeAllObjects];
                 
                 NSArray *dataArray = [responseObject objectForKey:@"leaveDetails"];
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
                     [self->leaveTitle addObject:strLeaveTitle];
                     [self->leaveDate addObject:Daydate];
                     [self->leaveReson addObject:strdescrption];
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
    else if(_segmentcontrol.selectedSegmentIndex == 0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        [parameters setObject:@"" forKey:@"class_id"];
        [parameters setObject:@"" forKey:@"sec_id"];
        [parameters setObject:appDel.class_id forKey:@"class_sec_id"];

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
                 [self->leaveTitle removeAllObjects];
                 [self->leaveDate removeAllObjects];
                 [self->leaveReson removeAllObjects];
                 [self->leaveDays removeAllObjects];
                 [self->leaveImages removeAllObjects];
                 
                 NSArray *dataArray = [responseObject objectForKey:@"upcomingleavesDetails"];
                 for (int i = 0; i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strLeaveTitle = [Data valueForKey:@"title"];
                     NSString *strStart  = [Data valueForKey:@"Start"];
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
                     [self->leaveTitle addObject:strLeaveTitle];
                     [self->leaveDate addObject:Daydate];
                     [self->leaveReson addObject:strdescrption];
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
@end
