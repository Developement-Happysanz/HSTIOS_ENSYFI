//
//  AdminTeacherView.m
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminTeacherView.h"

@interface AdminTeacherView ()
{
    AppDelegate *appDel;
    NSMutableArray *teacher_id;
    NSMutableArray *subject_name;
    NSMutableArray *name;

}
@end

@implementation AdminTeacherView

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
    
    self.tableview.hidden = YES;
    
    teacher_id = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@" " forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_all_teachers = @"/apiadmin/get_all_teachers";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_teachers, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         
         NSArray *data = [responseObject objectForKey:@"data"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"success"])
         {
             for (int i = 0; i < [data count]; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *str_teacher_id = [dict objectForKey:@"teacher_id"];
                 NSString *str_subject_name = [dict objectForKey:@"subject_name"];
                 NSString *str_name = [dict objectForKey:@"name"];
                 
                 [teacher_id addObject:str_teacher_id];
                 [subject_name addObject:str_subject_name];
                 [name addObject:str_name];
                 
             }
             self.tableview.hidden = NO;
             
             [self.tableview reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else
         {
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"ENSYFI"
                                        message:@"No data"
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminTeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.rollNumber.text = [NSString stringWithFormat:@"%li",indexPath.row + 1];
    //[teacher_id objectAtIndex:indexPath.row];
    cell.teacherName.text = [name objectAtIndex:indexPath.row];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];

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
    
    AdminStudentTableViewCell *adminteacher = [tableView cellForRowAtIndexPath:indexPath];
    
    //NSUInteger index = [subject_name indexOfObject:adminteacher.teacherName.text];
    
    NSString *get_teacher_id = [teacher_id objectAtIndex:indexPath.row];
    //adminstudent.rollNumber.text;
    [[NSUserDefaults standardUserDefaults]setObject:get_teacher_id forKey:@"admin_teacherid"];
    [self performSegueWithIdentifier:@"to_studentProfile" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
