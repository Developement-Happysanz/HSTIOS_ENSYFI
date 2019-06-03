//
//  AdminStudentProfileView.m
//  EducationApp
//
//  Created by HappySanz on 19/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminStudentProfileView.h"

@interface AdminStudentProfileView ()
{
    AppDelegate *appDel;
    NSMutableArray *abs_date;
}
@end

@implementation AdminStudentProfileView

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    abs_date = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.student_id forKey:@"student_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forAdminstudent = @"/apiadmin/get_student_details/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forAdminstudent, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
//         [MBProgressHUD showHUDAddedTo:self.view animated:YES];

         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *parents_details = [responseObject objectForKey:@"parents_details"];
         NSDictionary *fatherProfile = [parents_details valueForKey:@"fatherProfile"];
         NSDictionary *guardianProfile = [parents_details valueForKey:@"guardianProfile"];
         NSDictionary *motherProfile = [parents_details valueForKey:@"motherProfile"];
         NSArray *studentData = [responseObject valueForKey:@"studentData"];


         NSLog(@"%@%@%@",fatherProfile,guardianProfile,motherProfile);
         if ([msg isEqualToString:@"userdetailfound"])
         {
             for (int i = 0; i < [studentData count]; i++)
             {
                 NSDictionary *dict = [studentData objectAtIndex:i];
                 
                 self.admision_id.text = [dict objectForKey:@"admission_id"];
                 self.comunity.text = [dict objectForKey:@"community"];
                 self.comunity_class.text = [dict objectForKey:@"community_class"];
                 self.dob.text = [dict objectForKey:@"dob"];
                 self.email.text = [dict objectForKey:@"email"];
                 self.language.text = [dict objectForKey:@"language"];
                 self.mobile.text = [dict objectForKey:@"mobile"];
                 self.name.text = [dict objectForKey:@"name"];
                 self.nationality.text = [dict objectForKey:@"nationality"];
                 self.parents_status.text = [dict objectForKey:@"parents_status"];
                 self.religion.text = [dict objectForKey:@"religion"];
                 self.gender.text = [dict objectForKey:@"sex"];
                 
                 
                 self.admisionNumber.text = [dict objectForKey:@"admisn_no"];
                 self.admisionYear.text = [dict objectForKey:@"admisn_year"];
                 self.emsiNumber.text = [dict objectForKey:@"emsi_num"];
                 self.admisionDate.text = [dict objectForKey:@"admisn_date"];
                 self.age.text = [dict objectForKey:@"age"];
                 self.parentRguardian.text = [dict objectForKey:@"parnt_guardn"];
                 self.parentRguardianId.text = [dict objectForKey:@"parnt_guardn_id"];
                 self.motherLanguage.text = [dict objectForKey:@"mother_tongue"];
                 self.secondaryMobile.text = [dict objectForKey:@"sec_mobile"];
                 self.secondaryEmail.text = [dict objectForKey:@"sec_email"];
                 self.previousSchool.text = [dict objectForKey:@"last_studied"];
                 self.promotionStatus.text = [dict objectForKey:@"qualified_promotion"];
                 self.previousSchool.text = [dict objectForKey:@"last_sch_name"];
                 self.recordSheet.text = [dict objectForKey:@"record_sheet"];
                 self.status.text = [dict objectForKey:@"status"];
                 self.parents_status.text = [dict objectForKey:@"parents_status"];
                 self.registered.text = [dict objectForKey:@"enrollment"];
             }
             
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

- (IBAction)atendanceBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.student_id forKey:@"stud_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forAttendance = @"/apistudent/disp_Attendence/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forAttendance, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSArray *arr_Attendance = [responseObject objectForKey:@"attendenceDetails"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"View Attendence"])
         {
             
             NSArray *attendenceHistory = [responseObject objectForKey:@"attendenceHistory"];
             NSString *absent_days = [attendenceHistory valueForKey:@"absent_days"];
             NSString *leave_days = [attendenceHistory valueForKey:@"leave_days"];
             NSString *od_days = [attendenceHistory valueForKey:@"od_days"];
             NSString *present_days = [attendenceHistory valueForKey:@"present_days"];
             NSString *total_working_days = [attendenceHistory valueForKey:@"total_working_days"];
             
             
             for (int i = 0; i < [arr_Attendance count]; i++)
             {
                 NSDictionary *dict = [arr_Attendance objectAtIndex:i];
                 NSString *str_abs_date = [dict valueForKey:@"abs_date"];
                 
                 [abs_date addObject:str_abs_date];
             }
             
             
             [[NSUserDefaults standardUserDefaults] setObject:abs_date forKey:@"abs_date_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:absent_days forKey:@"absent_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:leave_days forKey:@"leave_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:od_days forKey:@"od_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:present_days forKey:@"present_days_Key"];
             [[NSUserDefaults standardUserDefaults] setObject:total_working_days forKey:@"total_working_days_Key"];
             
             
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             AttendanceViewController *attendance = (AttendanceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
             [self.navigationController pushViewController:attendance animated:YES];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else
         {
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             AttendanceViewController *attendance = (AttendanceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
             [self.navigationController pushViewController:attendance animated:YES];
         }
         
         [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"msg_attendance_Key"];

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}

- (IBAction)examBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"adminResult_Key"];

    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"adminExamKey"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExamsViewController *exam = (ExamsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamsViewController"];
    [self.navigationController pushViewController:exam animated:YES];
}

- (IBAction)clasTestBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ClassTestViewController *classTest = (ClassTestViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ClassTestViewController"];
    [self.navigationController pushViewController:classTest animated:YES];
}

- (IBAction)feesBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FessTableViewController *fessTableView = (FessTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FessTableViewController"];
    [self.navigationController pushViewController:fessTableView animated:YES];
}

- (IBAction)backBtn:(id)sender
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassView"];
    
    if ([str isEqualToString:@"classes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"ClassView"];
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
            AdminClassesViewController *adminClassesViewController = (AdminClassesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminClassesViewController"];
            [self.navigationController pushViewController:adminClassesViewController animated:YES];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
