//
//  ClassTeacherHomeWorkView.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 21/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTeacherHomeWorkView.h"

@interface ClassTeacherHomeWorkView ()
{
    AppDelegate *appDel;
    NSMutableArray *hw_date;
    NSMutableArray *hw_count;
    NSMutableArray *ht_count;
}
@end

@implementation ClassTeacherHomeWorkView

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    hw_date = [[NSMutableArray alloc]init];
    hw_count = [[NSMutableArray alloc]init];
    ht_count = [[NSMutableArray alloc]init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.classTeacher_id forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *disp_Attendence_classteacher = @"apiteacher/daywisect_homework";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Attendence_classteacher, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *hwDates = [responseObject valueForKey:@"hwDates"];
         [hw_date removeAllObjects];
         [hw_count removeAllObjects];
         [ht_count removeAllObjects];
         if ([msg isEqualToString:@"View All Days for Homework"])
         {
             for (int i = 0;i < [hwDates count]; i++)
             {
                 NSDictionary *dict = [hwDates objectAtIndex:i];
                 NSString *strhw_date = [dict objectForKey:@"hw_date"];
                 NSString *strhw_count = [dict objectForKey:@"hw_count"];
                 NSString *strht_count = [dict objectForKey:@"ht_count"];
                
                 [hw_date addObject:strhw_date];
                 [hw_count addObject:strhw_count];
                 [ht_count addObject:strht_count];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hw_date count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTeacherHomeWorkTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *dateList = [hw_date objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateList];
    // converting into our required date format
    [dateFormatter setDateFormat:@"MMMM dd yyyy"];
    cell.dateLabel.text = [dateFormatter stringFromDate:date];
    cell.classtestLabel.text = [NSString stringWithFormat:@"%@%@",@"Class Test : ",[ht_count objectAtIndex:indexPath.row]];
    cell.homeWorkLabel.text = [NSString stringWithFormat:@"%@%@",@"Home Work : ",[hw_count objectAtIndex:indexPath.row]];
//    cell.totalStudentsLabel.text = [NSString stringWithFormat:@"%@%@",@"Total Students : ", [class_total objectAtIndex:indexPath.row]];
//    cell.sentLabel.text = [sent_status objectAtIndex:indexPath.row];
//    if ([cell.sentLabel.text isEqualToString:@"1"])
//    {
//        cell.sentLabel.hidden = NO;
//        cell.sentLabel.text = @"Sent";
//        cell.sentImage.hidden = NO;
//    }
//    else
//    {
//        cell.sentLabel.hidden = YES;
//        cell.sentLabel.text = @"";
//        cell.sentImage.hidden = YES;
//    }
    cell.classView.layer.cornerRadius = 5.0;
    cell.classView.clipsToBounds = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.classTeacherHomeworkDate = [hw_date objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"classTestFirstView" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
