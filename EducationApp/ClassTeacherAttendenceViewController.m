//
//  ClassTeacherAttendenceViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 19/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTeacherAttendenceViewController.h"

@interface ClassTeacherAttendenceViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *class_total;
    NSMutableArray *no_of_present;
    NSMutableArray *no_of_absent;
    NSMutableArray *created_at;
    NSMutableArray *sent_status;
    NSMutableArray *name;
    NSMutableArray *at_id;
}
@end

@implementation ClassTeacherAttendenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    class_total = [[NSMutableArray alloc]init];
    no_of_present = [[NSMutableArray alloc]init];
    no_of_absent = [[NSMutableArray alloc]init];
    created_at = [[NSMutableArray alloc]init];
    sent_status = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    at_id = [[NSMutableArray alloc]init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.classTeacher_id forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *disp_Attendence_classteacher = @"/apiteacher/disp_Attendence_classteacher";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Attendence_classteacher, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *ct_attendance_history = [responseObject valueForKey:@"ct_attendance_history"];
         [class_total removeAllObjects];
         [no_of_present removeAllObjects];
         [no_of_absent removeAllObjects];
         [created_at removeAllObjects];
         [sent_status removeAllObjects];
         [name removeAllObjects];
         [at_id removeAllObjects];
         if ([msg isEqualToString:@"Class Teacher Attendance History"])
         {
             for (int i = 0;i < [ct_attendance_history count]; i++)
             {
                 NSDictionary *dict = [ct_attendance_history objectAtIndex:i];
                 NSString *strcreated_at = [dict objectForKey:@"created_at"];
                 NSString *strclass_total = [dict objectForKey:@"class_total"];
                 NSString *strno_of_present = [dict objectForKey:@"no_of_present"];
                 NSString *strno_of_absent = [dict objectForKey:@"no_of_absent"];
                 NSString *strsent_status = [dict objectForKey:@"sent_status"];
                 NSString *strName = [dict objectForKey:@"name"];
                 NSString *strat_id = [dict objectForKey:@"at_id"];

                 [class_total addObject:strclass_total];
                 [created_at addObject:strcreated_at];
                 [no_of_present addObject:strno_of_present];
                 [no_of_absent addObject:strno_of_absent];
                 [sent_status addObject:strsent_status];
                 [sent_status addObject:strsent_status];
                 [name addObject:strName];
                 [at_id addObject:strat_id];

             }
         }
                [self.tableView reloadData];
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
    return [class_total count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTeachetAttendenceTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *dateList = [created_at objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH.mm.ss"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateList];
    // converting into our required date format
    [dateFormatter setDateFormat:@"MMMM dd yyyy"];
    cell.msgDate.text = [dateFormatter stringFromDate:date];
    cell.presentlabel.text = [NSString stringWithFormat:@"%@%@",@"No. of present : ",[no_of_present objectAtIndex:indexPath.row]];
    cell.absentLabel.text = [NSString stringWithFormat:@"%@%@",@"No. of Absent : ",[no_of_absent objectAtIndex:indexPath.row]];
    cell.totalStudentsLabel.text = [NSString stringWithFormat:@"%@%@",@"Total Students : ", [class_total objectAtIndex:indexPath.row]];
    cell.sentLabel.text = [sent_status objectAtIndex:indexPath.row];
    if ([cell.sentLabel.text isEqualToString:@"1"])
    {
        cell.sentLabel.hidden = NO;
        cell.sentLabel.text = @"Sent";
        cell.sentImage.hidden = NO;
    }
    else
    {
        cell.sentLabel.hidden = YES;
        cell.sentLabel.text = @"";
        cell.sentImage.hidden = YES;
    }
    cell.cellView.layer.cornerRadius = 5.0;
    cell.cellView.clipsToBounds = YES;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassTeachetAttendenceTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *strDate = cell.msgDate.text;
    NSString *present = cell.presentlabel.text;
    NSString *absent = cell.absentLabel.text;
    NSString *totalStudents = cell.totalStudentsLabel.text;
    NSString *strname = [name objectAtIndex:indexPath.row];
    NSString *strstatus = [sent_status objectAtIndex:indexPath.row];
    NSString *strat_id = [at_id objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:strDate forKey:@"ctView_date"];
    [[NSUserDefaults standardUserDefaults]setObject:present forKey:@"ctView_present"];
    [[NSUserDefaults standardUserDefaults]setObject:absent forKey:@"ctView_absent"];
    [[NSUserDefaults standardUserDefaults]setObject:totalStudents forKey:@"ctView_totalStudents"];
    [[NSUserDefaults standardUserDefaults]setObject:strname forKey:@"ctView_name"];
    [[NSUserDefaults standardUserDefaults]setObject:strstatus forKey:@"ctView_status"];
    [[NSUserDefaults standardUserDefaults]setObject:strat_id forKey:@"ctView_attendId"];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
