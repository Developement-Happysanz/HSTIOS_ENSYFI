//
//  ClassTeacherStudentListView.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 20/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTeacherStudentListView.h"

@interface ClassTeacherStudentListView ()
{
    AppDelegate *appDel;
    NSMutableArray *enroll_id;
    NSMutableArray *name;
    NSMutableArray *a_status;
    NSArray *stat;

}
@end

@implementation ClassTeacherStudentListView

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    enroll_id = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    a_status = [[NSMutableArray alloc]init];
    stat = @[@"1"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *atten_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_attendId"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.classTeacher_id forKey:@"class_id"];
    [parameters setObject:atten_id forKey:@"attend_id"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *list_Studentattend_classteacher = @"apiteacher/list_Studentattend_classteacher";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,list_Studentattend_classteacher, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *ct_attendance_history = [responseObject valueForKey:@"ct_student_history"];

         if ([msg isEqualToString:@"Class Teacher Student Attendance History"])
         {
             for (int i = 0;i < [ct_attendance_history count]; i++)
             {
                 NSDictionary *dict = [ct_attendance_history objectAtIndex:i];
                 NSString *strenroll_id = [dict objectForKey:@"enroll_id"];
                 NSString *strname = [dict objectForKey:@"name"];
                 NSString *stra_status = [dict objectForKey:@"a_status"];
                
                 [enroll_id addObject:strenroll_id];
                 [name addObject:strname];
                 [a_status addObject:stra_status];

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
    return [a_status count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        
        ClassTeacherStudentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        return cell;
        
    }
    else
    {
        
        ClassTeacherStudentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];        
        cell.nameLabel.text = [name objectAtIndex:indexPath.row];
        cell.statusLabel.text = [a_status objectAtIndex:indexPath.row];

        return cell;
        
    }
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
