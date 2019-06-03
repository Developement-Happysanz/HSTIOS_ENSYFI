//
//  ClassTestViewController.m
//  EducationApp
//
//  Created by HappySanz on 16/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ClassTestViewController.h"

@interface ClassTestViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *subject_name;
    NSMutableArray *title;
    NSMutableArray *date;
    NSMutableArray *hw_id;
    NSMutableArray *hw_type;
    NSMutableArray *hw_details;
    NSMutableArray *mark_status;
    NSString *setValueClasstest;
    NSString *setValueHomeWork;

}
@end

@implementation ClassTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([stat_user_type isEqualToString:@"admin"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = backButton;
        
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
    }
    else
    {
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
    }
    
    CGRect frame= _segmentControl.frame;
    [_segmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 35)];
    
    subject_name = [[NSMutableArray alloc]init];
    title = [[NSMutableArray alloc]init];
    date = [[NSMutableArray alloc]init];
    hw_id = [[NSMutableArray alloc]init];
    hw_type = [[NSMutableArray alloc]init];
    mark_status = [[NSMutableArray alloc]init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    [subject_name addObject:@"bala"];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:@"HT" forKey:@"hw_type"];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forHomeWork = @"/apistudent/disp_Homework/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSArray *array_homeworkDetails = [responseObject objectForKey:@"homeworkDetails"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"View Homework Details"])
         {
             subject_name = [array_homeworkDetails valueForKey:@"subject_name"];
             title = [array_homeworkDetails valueForKey:@"title"];
             date = [array_homeworkDetails valueForKey:@"test_date"];
             hw_id = [array_homeworkDetails valueForKey:@"hw_id"];
             hw_type = [array_homeworkDetails valueForKey:@"hw_type"];
             hw_details = [array_homeworkDetails valueForKey:@"hw_details"];
             mark_status = [array_homeworkDetails valueForKey:@"mark_status"];
             NSLog(@"%@%@%@",subject_name,title,date);
             [[NSUserDefaults standardUserDefaults]setObject:@"ct" forKey:@"key"];

             [self.tableview reloadData];
             [[NSUserDefaults standardUserDefaults]setObject:@"HT" forKey:@"hw_type_Key"];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"ENSYFI"
                                        message:@"ClassTest Not Found"
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
    setValueClasstest = @"0";
    setValueHomeWork = @"0";
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"key"];

}
- (IBAction)Back
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
    AdminStudentProfileView *adminStudentProfileView = (AdminStudentProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentProfileView"];
    [self.navigationController pushViewController:adminStudentProfileView animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subject_name count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ClassTestTableViewCell";
    
    ClassTestTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[ClassTestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }    
    //Configure the cell...
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"key"];
    
    if ([str isEqualToString:@"ct"])
    {
        cell.testDateLabel.text = @"Test Date";

    }
    else
    {
        cell.testDateLabel.text = @"Due Date";

    }
    
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    cell.subjectTitle.text = [title objectAtIndex:indexPath.row];
    [cell.subjectTitle.text uppercaseString];
    cell.dateLabel.text = [date objectAtIndex:indexPath.row];
    
    NSLog(@"%@%@%@",cell.subjectName.text,cell.subjectTitle.text,cell.dateLabel.text);
    cell.cellview.layer.borderWidth = 1.0f;
    cell.cellview.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellview.layer.cornerRadius = 6.0f;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassTestTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *markstatus = [mark_status objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:markstatus forKey:@"mark_status_key"];
    
        NSString *subjectTitle = selectedCell.subjectTitle.text;
        NSString *subjectName = selectedCell.subjectName.text;
        NSString *dateLabel = selectedCell.dateLabel.text;
        NSString *hw_details_Str = [hw_details objectAtIndex:indexPath.row];
        NSString *hw_id_key = [hw_id objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:hw_id_key forKey:@"hw_id_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:subjectTitle forKey:@"subjectTitleKey"];
        [[NSUserDefaults standardUserDefaults]setObject:subjectName forKey:@"subjectNameKey"];
        [[NSUserDefaults standardUserDefaults]setObject:dateLabel forKey:@"dateLabelKey"];
        [[NSUserDefaults standardUserDefaults]setObject:hw_details_Str forKey:@"hw_details_Str_Key"];
        
        [self performSegueWithIdentifier:@"classTestDetail" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
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

- (IBAction)classTestSwtchBtn:(id)sender
{
    if ([setValueClasstest isEqualToString:@"0"])
    {
        [_classTestSwtch setSelected:YES];
        [_homeworkSwtch setSelected:NO];
        setValueClasstest = @"1";
    }
    else
    {
        [_classTestSwtch setSelected:NO];
        setValueClasstest = @"0";
    }
}
- (IBAction)homeworkSwtchBtn:(id)sender
{
    if ([setValueHomeWork isEqualToString:@"0"])
    {
        [_homeworkSwtch setSelected:YES];
        [_classTestSwtch setSelected:NO];
        setValueHomeWork = @"1";
    }
    else
    {
        [_homeworkSwtch setSelected:NO];
        setValueHomeWork = @"0";
    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)segmentcontrolAction:(id)sender
{
    if(_segmentControl.selectedSegmentIndex==0)
    {
        static NSString *simpleTableIdentifier = @"ClassTestTableViewCell";

//        ClassTestTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//        
//        cell.testDateLabel.text = @"Test Date";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //[subject_name addObject:@"bala"];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.class_id forKey:@"class_id"];
        [parameters setObject:@"HT" forKey:@"hw_type"];

        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forHomeWork = @"/apistudent/disp_Homework/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
        NSString *api = [NSString pathWithComponents:components];
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             NSArray *array_homeworkDetails = [responseObject objectForKey:@"homeworkDetails"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Homework Details"])
             {
                 subject_name = [array_homeworkDetails valueForKey:@"subject_name"];
                 title = [array_homeworkDetails valueForKey:@"title"];
                 date = [array_homeworkDetails valueForKey:@"test_date"];
                 hw_id = [array_homeworkDetails valueForKey:@"hw_id"];
                 hw_type = [array_homeworkDetails valueForKey:@"hw_type"];
                 hw_details = [array_homeworkDetails valueForKey:@"hw_details"];
                 mark_status = [array_homeworkDetails valueForKey:@"mark_status"];
                 NSLog(@"%@%@%@",subject_name,title,date);
                 [[NSUserDefaults standardUserDefaults]setObject:@"ct" forKey:@"key"];
                 [self.tableview reloadData];
                 [[NSUserDefaults standardUserDefaults]setObject:@"HT" forKey:@"hw_type_Key"];
                 [[NSUserDefaults standardUserDefaults]setObject:hw_id forKey:@"hw_id_Key"];

                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"HomeWork Not Found"
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [_segmentControl setSelectedSegmentIndex:1];
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
        static NSString *simpleTableIdentifier = @"ClassTestTableViewCell";
        
//        ClassTestTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//        
//        cell.testDateLabel.text = @"Due Date";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //[subject_name addObject:@"bala"];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.class_id forKey:@"class_id"];
        [parameters setObject:@"HW" forKey:@"hw_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        /*concordanate with baseurl */
        NSString *forHomeWork = @"/apistudent/disp_Homework/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
        NSString *api = [NSString pathWithComponents:components];
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             
             NSArray *array_homeworkDetails = [responseObject objectForKey:@"homeworkDetails"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Homework Details"])
             {
                 subject_name = [array_homeworkDetails valueForKey:@"subject_name"];
                 title = [array_homeworkDetails valueForKey:@"title"];
                 date = [array_homeworkDetails valueForKey:@"due_date"];
                 hw_id = [array_homeworkDetails valueForKey:@"hw_id"];
                 hw_type = [array_homeworkDetails valueForKey:@"hw_type"];
                 hw_details = [array_homeworkDetails valueForKey:@"hw_details"];
                 mark_status = [array_homeworkDetails valueForKey:@"mark_status"];
                 NSLog(@"%@%@%@",subject_name,title,date);
                 [[NSUserDefaults standardUserDefaults]setObject:@"hw" forKey:@"key"];
                 [self.tableview reloadData];
                 [[NSUserDefaults standardUserDefaults]setObject:@"HW" forKey:@"hw_type_Key"];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"HomeWork Not Found"
                                            preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [_segmentControl setSelectedSegmentIndex:0];
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
