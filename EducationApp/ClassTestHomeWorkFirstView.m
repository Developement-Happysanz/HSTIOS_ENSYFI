//
//  ClassTestHomeWorkFirstView.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTestHomeWorkFirstView.h"

@interface ClassTestHomeWorkFirstView ()
{
    AppDelegate *appDel;
    NSMutableArray *hw_id;
    NSMutableArray *hw_type;
    NSMutableArray *title;
    NSMutableArray *created_at;
    NSMutableArray *test_date;
    NSMutableArray *due_date;
    NSMutableArray *hw_details;
    NSMutableArray *send_option_status;
    NSMutableArray *subject_id;
    NSMutableArray *subject_name;
    NSMutableArray *name;
}
@end

@implementation ClassTestHomeWorkFirstView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    hw_id = [[NSMutableArray alloc]init];
    hw_type = [[NSMutableArray alloc]init];
    title = [[NSMutableArray alloc]init];
    created_at = [[NSMutableArray alloc]init];
    test_date = [[NSMutableArray alloc]init];
    due_date = [[NSMutableArray alloc]init];
    hw_details = [[NSMutableArray alloc]init];
    send_option_status = [[NSMutableArray alloc]init];
    subject_id = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.classTeacher_id forKey:@"class_id"];
    [parameters setObject:appDel.classTeacherHomeworkDate forKey:@"hw_date"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *disp_Attendence_classteacher = @"apiteacher/daywisect_allhomework";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Attendence_classteacher, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *hwDates = [responseObject valueForKey:@"hwdayDetails"];
         
         if ([msg isEqualToString:@"View All Homework - Day"])
         {
             for (int i = 0;i < [hwDates count]; i++)
             {
                 NSDictionary *dict = [hwDates objectAtIndex:i];
                 NSString *strhw_id = [dict objectForKey:@"hw_id"];
                 NSString *strhw_type = [dict objectForKey:@"hw_type"];
                 NSString *strtitle = [dict objectForKey:@"title"];
                 NSString *strcreated_at = [dict objectForKey:@"created_at"];
                 NSString *strtest_date = [dict objectForKey:@"test_date"];
                 NSString *strdue_date = [dict objectForKey:@"due_date"];
                 NSString *strhw_details = [dict objectForKey:@"hw_details"];
                 NSString *strsend_option_status = [dict objectForKey:@"send_option_status"];
                 NSString *strsubject_id = [dict objectForKey:@"subject_id"];
                 NSString *strsubject_name = [dict objectForKey:@"subject_name"];
                 NSString *strname = [dict objectForKey:@"name"];
                 
                 [hw_id addObject:strhw_id];
                 [hw_type addObject:strhw_type];
                 [title addObject:strtitle];
                 [created_at addObject:strcreated_at];
                 [test_date addObject:strtest_date];
                 [due_date addObject:strdue_date];
                 [hw_details addObject:strhw_details];
                 [send_option_status addObject:strsend_option_status];
                 [subject_id addObject:strsubject_id];
                 [subject_name addObject:strsubject_name];
                 [name addObject:strname];

             }
         }
                 [self.tableView reloadData];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];

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
    return [hw_type count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTestHomeWorkFirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.teacherName.text = [name objectAtIndex:indexPath.row];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    cell.homeWorkType.text = [hw_type objectAtIndex:indexPath.row];
    if ([cell.homeWorkType.text isEqualToString:@"HT"])
    {
        cell.homeWorkType.text = @"Class Test";
    }
    else
    {
        cell.homeWorkType.text = @"HomeWork";
    }
    NSString *status = [send_option_status objectAtIndex:indexPath.row];
    if ([status isEqualToString:@"0"])
    {
        cell.statusImage.hidden = YES;
        cell.statusLabel.hidden = YES;
    }
    else
    {
        cell.statusImage.hidden = NO;
        cell.statusLabel.hidden = NO;
        cell.statusLabel.text = @"Sent";
    }
        cell.cellView.layer.cornerRadius = 5.0;
        cell.cellView.clipsToBounds = YES;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strTitle = [title objectAtIndex:indexPath.row];
    NSString *strhw_type = [hw_type objectAtIndex:indexPath.row];
    NSString *strsubject_name = [subject_name objectAtIndex:indexPath.row];
    NSString *strname = [name objectAtIndex:indexPath.row];
    NSString *strhw_details = [hw_details objectAtIndex:indexPath.row];
    NSString *strid = [hw_id objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:strTitle forKey:@"title_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strhw_type forKey:@"hw_type_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strsubject_name forKey:@"subject_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strname forKey:@"name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strhw_details forKey:@"hw_details_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strid forKey:@"ctView_attendId"];

    [self performSegueWithIdentifier:@"to_detail" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
