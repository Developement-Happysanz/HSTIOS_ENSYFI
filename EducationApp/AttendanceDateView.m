//
//  AttendanceDateView.m
//  EducationApp
//
//  Created by HappySanz on 04/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AttendanceDateView.h"

@interface AttendanceDateView ()
{
    AppDelegate *appDel;
    NSArray *stat;
    
    NSMutableArray *a_status;
    NSMutableArray *attend_period;
    NSMutableArray *leaves;
    NSMutableArray *abs_date;
    
    NSMutableArray *ab_date;
    
    
}
@end

@implementation AttendanceDateView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    stat = @[@"1"];
    
    self.tableview.hidden = NO;
    
    a_status = [[NSMutableArray alloc]init];
    attend_period = [[NSMutableArray alloc]init];
    leaves = [[NSMutableArray alloc]init];
    abs_date = [[NSMutableArray alloc]init];

    ab_date = [[NSMutableArray alloc]init];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *classidKey = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
    NSString *month_year = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
    NSString *studentID = [[NSUserDefaults standardUserDefaults]objectForKey:@"studentId_key"];
    
    appDel.class_id = classidKey;
    appDel.student_id = studentID;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:classidKey forKey:@"class_id"];
    [parameters setObject:studentID forKey:@"student_id"];
    [parameters setObject:month_year forKey:@"month_year"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *disp_Attendence = @"/apiteacher/disp_Monthview/";
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
             
             [abs_date insertObject:@"name" atIndex:0];
             [a_status insertObject:@"name" atIndex:0];
             [leaves insertObject:@"name" atIndex:0];

             for (int i =0; i < [attendenceDetails count]; i++)
             {
                
                 NSDictionary *dict = [attendenceDetails objectAtIndex:i];
                 NSString *str_a_status = [dict objectForKey:@"a_status"];
                 NSString *str_attend_period = [dict objectForKey:@"attend_period"];
                 NSString *str_leaves = [dict objectForKey:@"leaves"];
                 NSString *str_abs_date = [dict objectForKey:@"abs_date"];
                 
                 NSString *str = str_abs_date; /// here this is your date with format yyyy-MM-dd
                 
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
                 
                 NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"dd-MM-yyyy"];// here set format which you want...
                 
                 NSString *convertedString = [dateFormatter stringFromDate:date]; //h
                 
                 [a_status addObject:str_a_status];
                 [attend_period addObject:str_attend_period];
                 [leaves addObject:str_leaves];
                                  
                 [abs_date addObject:convertedString];
             }
             
             [self.tableview reloadData];
             
             
             
         }
         else
         {
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
    
    _viewattendanceOtlet.layer.cornerRadius = 20; // this value vary as per your desire
    _viewattendanceOtlet.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [a_status count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        
        AttendanceDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        return cell;
        
    }
    else
    {
        
        AttendanceDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
                
        cell.dateLabel.text = [abs_date objectAtIndex:indexPath.row];
        
        NSString *str = [leaves objectAtIndex:indexPath.row];
        
        if ([str isEqualToString:@"1"])
        {
            NSString *str_status = [a_status objectAtIndex:indexPath.row];
            
            if ([str_status isEqualToString:@"L"])
            {
                cell.durationLabel.text = @"Full day Leave";

            }
            else if([str_status isEqualToString:@"A"])
            {
                cell.durationLabel.text = @"Full day Absent";

            }
            else if ([str_status isEqualToString:@"OD"])
            {
                cell.durationLabel.text = @"Full day OD";

            }
        }
        else
        {
            NSString *str_status = [a_status objectAtIndex:indexPath.row];
            
            if ([str_status isEqualToString:@"L"])
            {
                cell.durationLabel.text = @"Full day Leave";
                
            }
            else if([str_status isEqualToString:@"A"])
            {
                cell.durationLabel.text = @"Full day Absent";
                
            }
            else if ([str_status isEqualToString:@"OD"])
            {
                cell.durationLabel.text = @"Full day OD";
            }
        }
        
        return cell;
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
//    TeacherAttendanceView *myNewVC = (TeacherAttendanceView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherAttendanceView"];
//    [self.navigationController pushViewController:myNewVC animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)viewAttendanceBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
    [[NSUserDefaults standardUserDefaults]setObject:@"teachers_attendance" forKey:@"teacher_attendance_key"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AttendanceViewController *myNewVC = (AttendanceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
@end
