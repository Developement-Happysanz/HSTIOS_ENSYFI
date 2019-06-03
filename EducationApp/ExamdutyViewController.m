//
//  ExamdutyViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 26/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ExamdutyViewController.h"

@interface ExamdutyViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *class_section_Array;
    NSMutableArray *exam_date_Array;
    NSMutableArray *exam_name_Array;
    NSMutableArray *subject_name_Array;
    NSMutableArray *exam_time_Array;
}
@end

@implementation ExamdutyViewController

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
    
    class_section_Array = [[NSMutableArray alloc]init];
    exam_date_Array = [[NSMutableArray alloc]init];
    exam_time_Array = [[NSMutableArray alloc]init];
    exam_name_Array = [[NSMutableArray alloc]init];
    subject_name_Array = [[NSMutableArray alloc]init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"2" forKey:@"teacher_id"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *Examduty = @"/apiteacher/view_Examduty/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,Examduty, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"View Exam Duty"])
         {
             NSArray *dataArray = [responseObject objectForKey:@"examdutyDetails"];
             [class_section_Array removeAllObjects];
             [exam_date_Array removeAllObjects];
             [exam_name_Array removeAllObjects];
             [subject_name_Array removeAllObjects];
             
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *Data = [dataArray objectAtIndex:i];
                 NSString *strclass_section = [Data valueForKey:@"class_section"];
                 NSString *strexam_datetime = [Data valueForKey:@"exam_datetime"];
                 NSString *strexam_name = [Data valueForKey:@"exam_name"];
                 NSString *strsubject_name = [Data valueForKey:@"subject_name"];
                 
                 NSString *subjectName = [NSString stringWithFormat:@"%@",strsubject_name];
                 NSString *class_section = [NSString stringWithFormat:@"%@ %@",@"Venue :",strclass_section];
                 NSString *exam_name  = [NSString stringWithFormat:@"%@",strexam_name];
                 NSString *exam_datetime = [NSString stringWithFormat:@"%@",strexam_datetime];

                 [class_section_Array addObject:class_section];
                 [exam_date_Array addObject:exam_datetime];
                 [exam_name_Array addObject:exam_name];
                 [subject_name_Array addObject:subjectName];
             }
             [self.tableView reloadData];
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
    return [subject_name_Array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"cell";
    ExamDutyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[ExamDutyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.subjectName.text = [class_section_Array objectAtIndex:indexPath.row];
    cell.classSection.text = [subject_name_Array objectAtIndex:indexPath.row];
    cell.dateTime.text = [exam_date_Array objectAtIndex:indexPath.row];
    cell.examName.text = [exam_name_Array objectAtIndex:indexPath.row];

    cell.cellView.layer.cornerRadius = 5.0;
    cell.cellView.clipsToBounds = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}
@end
