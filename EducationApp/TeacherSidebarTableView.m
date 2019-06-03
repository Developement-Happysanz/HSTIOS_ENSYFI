//
//  TeacherSidebarTableView.m
//  EducationApp
//
//  Created by HappySanz on 02/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherSidebarTableView.h"

@interface TeacherSidebarTableView ()
{
    AppDelegate *appDel;
    NSArray *menuItems;
    NSArray *staticMenu;
}
@end

@implementation TeacherSidebarTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    menuItems = @[@"samp",@"home",@"profile", @"attendance", @"classtesthomework", @"examandresult", @"timetable", @"event", @"circular",@"onduty",@"notification",@"applyleave",@"settings",@"sync",@"signout"];
    
    staticMenu = @[@"username"];
    
    [self.tableView registerClass:[TeacherTableViewCell class] forCellReuseIdentifier:@"TeacherTableViewCell"];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDel.user_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_name_key"];
    appDel.user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id_key"];
    appDel.user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_type_key"];
    appDel.user_type_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_type_name_key"];
    
    appDel.user_password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password_status_key"];
    appDel.user_picture = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"];
    appDel.name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"];
    appDel.institute_code = [[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return menuItems.count;
        }
            break;
            
        case 1:
        {
            return staticMenu.count;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        // static cell
        
        NSString *CellIdentifier = [staticMenu objectAtIndex:indexPath.row];
        TeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if ([appDel.user_type isEqualToString:@"2"])
        {
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,teacher_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
            NSLog(@"%@",appDel.user_picture);
            NSString *fullpath= [NSString pathWithComponents:components];
            NSURL *url = [NSURL URLWithString:fullpath];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.user_Image.image = [UIImage imageWithData:imageData];
                    cell.user_Image.layer.cornerRadius = 50.0;
                    cell.user_Image.clipsToBounds = YES;
                    if (cell.user_Image.image == nil)
                    {
                        cell.user_Image.image = [UIImage imageNamed:@"profile_pic.png"];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            });
            cell.username.text = [NSString stringWithFormat:@"%@, %@",@"Hi",[[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"]];
        }
        
        if ([appDel.user_type isEqualToString:@"3"])
        {
            
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,student_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
            NSString *fullpath= [NSString pathWithComponents:components];
            NSURL *url = [NSURL URLWithString:fullpath];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    cell.user_Image.image = [UIImage imageWithData:imageData];
                    cell.user_Image.layer.cornerRadius = 50.0;
                    cell.user_Image.clipsToBounds = YES;
                    if (cell.user_Image.image == nil)
                    {
                        cell.user_Image.image = [UIImage imageNamed:@"profile_pic.png"];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            });
            cell.username.text = [NSString stringWithFormat:@"%@, %@",@"Hi",[[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"]];
        }
        else if([appDel.user_type isEqualToString:@"4"])
        {
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            // customization
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,parents_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
            NSString *fullpath= [NSString pathWithComponents:components];
            NSURL *url = [NSURL URLWithString:fullpath];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    cell.user_Image.image = [UIImage imageWithData:imageData];
                    cell.user_Image.layer.cornerRadius = 50.0;
                    cell.user_Image.clipsToBounds = YES;
                    if (cell.user_Image.image == nil)
                    {
                        cell.user_Image.image = [UIImage imageNamed:@"profile_pic.png"];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            });
            cell.username.text = [NSString stringWithFormat:@"%@, %@",@"Hi",[[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"]];
        }
        
        return cell;
    }
    else
    {
        NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
        UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 156;
    }
    else
    {
        return 49;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    
    if ([segue.identifier isEqualToString:@"profile"])
    {
        UINavigationController *navController = segue.destinationViewController;
        TeacherProfileViewController *profile = [navController childViewControllers].firstObject;
        NSLog(@"%@",profile);
        
    }
    else if ([segue.identifier isEqualToString:@"home"])
    {
        UINavigationController *navController = segue.destinationViewController;
        TeacherSidebarTableView *teachersidebartableView = [navController childViewControllers].firstObject;
        NSLog(@"%@",teachersidebartableView);
        
    }
    else if ([segue.identifier isEqualToString:@"classTest"])
    {
        UINavigationController *navController = segue.destinationViewController;
        TeacherClasstestHomeWorkView *teacherClasstestHomeWorkView = [navController childViewControllers].firstObject;
        NSLog(@"%@",teacherClasstestHomeWorkView);
        
    }
    else if ([segue.identifier isEqualToString:@"circular"])
    {
        UINavigationController *navController = segue.destinationViewController;
        TeacherCirularTableViewController *time = [navController childViewControllers].firstObject;
        NSLog(@"%@",time);
        
    }
    else if ([segue.identifier isEqualToString:@"attendance"])
    {
//        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
//        [parameters setObject:appDel.class_id forKey:@"class_id"];
//        [parameters setObject:appDel.student_id forKey:@"stud_id"];
//        
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        
//        
//        /* concordanate with baseurl */
//        NSString *forAttendance = @"/apistudent/disp_Attendence/";
//        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forAttendance, nil];
//        NSString *api = [NSString pathWithComponents:components];
//        
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//         {
//             
//             NSLog(@"%@",responseObject);
//             
//             NSArray *arr_Attendance = [responseObject objectForKey:@"attendenceDetails"];
//             NSString *msg = [responseObject objectForKey:@"msg"];
//             
//             if ([msg isEqualToString:@"View Attendence"])
//             {
//                 
//                 NSArray *attendenceHistory = [responseObject objectForKey:@"attendenceHistory"];
//                 NSString *absent_days = [attendenceHistory valueForKey:@"absent_days"];
//                 NSString *leave_days = [attendenceHistory valueForKey:@"leave_days"];
//                 NSString *od_days = [attendenceHistory valueForKey:@"od_days"];
//                 NSString *present_days = [attendenceHistory valueForKey:@"present_days"];
//                 NSString *total_working_days = [attendenceHistory valueForKey:@"total_working_days"];
//                 
//                 
//                 for (int i = 0; i < [arr_Attendance count]; i++)
//                 {
//                     NSDictionary *dict = [arr_Attendance objectAtIndex:i];
//                     NSString *leaveDate = [dict valueForKey:@"abs_date"];
//                     
//                     [abs_date addObject:leaveDate];
//                 }
//                 
//                 
//                 [[NSUserDefaults standardUserDefaults] setObject:abs_date forKey:@"abs_date_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:absent_days forKey:@"absent_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:leave_days forKey:@"leave_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:od_days forKey:@"od_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:present_days forKey:@"present_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:total_working_days forKey:@"total_working_days_Key"];
//                 
//                 [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"msg_attendance_Key"];
//                 
//                 
//                 UINavigationController *navController = segue.destinationViewController;
//                 AttendanceViewController *attendance = [navController childViewControllers].firstObject;
//                 NSLog(@"%@",attendance);
//                 
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//             }
             
             
             
//         }
//              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
//         {
//             NSLog(@"error: %@", error);
//         }];
    }
    else if ([segue.identifier isEqualToString:@"exams"])
    {
        
        UINavigationController *navController = segue.destinationViewController;
        TeacherExamViewController *teacherExamViewController = [navController childViewControllers].firstObject;
        NSLog(@"%@",teacherExamViewController);
        
    }
    else if ([segue.identifier isEqualToString:@"notification"])
    {
        
        UINavigationController *navController = segue.destinationViewController;
        TeacherNotificationTableViewController *teacherNotificationTableViewController = [navController childViewControllers].firstObject;
        NSLog(@"%@",teacherNotificationTableViewController);
        
    }
    
    else if ([segue.identifier isEqualToString:@"onduty"])
    {
        
        UINavigationController *navController = segue.destinationViewController;
        TeacherOndutyViewController *onduty = [navController childViewControllers].firstObject;
        NSLog(@"%@",onduty);
        
    }
    else if ([segue.identifier isEqualToString:@"applyLeave"])
    {
        
        UINavigationController *navController = segue.destinationViewController;
        TeacherApplyLeave *teacherApplyLeave = [navController childViewControllers].firstObject;
        NSLog(@"%@",teacherApplyLeave);
        
    }
    else if ([segue.identifier isEqualToString:@"timeTable"])
    {
        
        UINavigationController *navController = segue.destinationViewController;
        TeachersTimeTableView *TeachersTimeTableView = [navController childViewControllers].firstObject;
        NSLog(@"%@",TeachersTimeTableView);
        
    }
    else if ([segue.identifier isEqualToString:@"sync"])
    {

        UINavigationController *navController = segue.destinationViewController;
        SyncViewController *sync = [navController childViewControllers].firstObject;
        NSLog(@"%@",sync);

    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 14)
    {
        
        NSArray *docPathstimetable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirdeltimetable = [docPathstimetable objectAtIndex:0];
        NSString *dbPathdeltimetable = [documentsDirdeltimetable   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *databasedeltimetable = [FMDatabase databaseWithPath:dbPathdeltimetable];
        [databasedeltimetable open];
        
        BOOL isInsertedtimetable=[databasedeltimetable executeUpdate:@"DELETE FROM table_create_academic_months"];
        
        if(isInsertedtimetable)
            NSLog(@"isDeleted Successfully");
        else
            NSLog(@"Error occured while deleting");
        
        [databasedeltimetable close];
        
        ////////////
        
        NSArray *deldocPathsacademic_month = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *deldocumentsDirdelacademic_month = [deldocPathsacademic_month objectAtIndex:0];
        NSString *deldbPathdelacademic_month = [deldocumentsDirdelacademic_month   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *deldatabasedelacademic_month = [FMDatabase databaseWithPath:deldbPathdelacademic_month];
        [deldatabasedelacademic_month open];
        
        BOOL delisInserted=[deldatabasedelacademic_month executeUpdate:@"DELETE FROM table_create_exams_details"];
        
        [deldatabasedelacademic_month close];
        
        if(delisInserted)
            NSLog(@"table_create_exams_details  DELETED Successfully");
        else
            NSLog(@"Error occured while inserting");
        
        if(isInsertedtimetable)
            NSLog(@"Inserted Successfully");
        else
            NSLog(@"Error occured while inserting");
        
        [deldatabasedelacademic_month close];
        ////////////////////////
        
        NSArray *deletedocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *deleteddocumentsDir = [deletedocPaths objectAtIndex:0];
        NSString *deleteddbPath = [deleteddocumentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *deleteddatabase = [FMDatabase databaseWithPath:deleteddbPath];
        [deleteddatabase open];
        
        BOOL isDeleted=[deleteddatabase executeUpdate:@"DELETE FROM table_create_homework_class_test"];
        
        if(isDeleted)
            NSLog(@"table_create_homework_class_test isDeleted Successfully");
        else
            NSLog(@"Error occured while deleting");
        
        [deleteddatabase close];
        
        /////////////////////////
        
        NSArray *docPathsdel = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirdel = [docPathsdel objectAtIndex:0];
        NSString *dbPathdel = [documentsDirdel   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *databasedel = [FMDatabase databaseWithPath:dbPathdel];
        [databasedel open];
        
        BOOL isInserted_student_details = [databasedel executeUpdate:@"DELETE FROM table_create_teacher_student_details"];
        
        [databasedel close];
        
        if(isInserted_student_details)
            NSLog(@"Inserted Successfully");
        else
            NSLog(@"Error occured while inserting");
        
        [databasedel close];
        
        ////
        
        NSArray *docPathsteacher_handling_subjects = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirdelhandling_subjects = [docPathsteacher_handling_subjects objectAtIndex:0];
        NSString *dbPathdelhandling_subjects = [documentsDirdelhandling_subjects   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *databasedelhandling_subjects = [FMDatabase databaseWithPath:dbPathdelhandling_subjects];
        [databasedelhandling_subjects open];
        
        BOOL isInsertedhandling_subjects=[databasedelhandling_subjects executeUpdate:@"DELETE FROM table_create_teacher_handling_subjects"];
        
        [databasedelhandling_subjects close];
        
        if(isInsertedhandling_subjects)
            NSLog(@"Inserted Successfully");
        else
            NSLog(@"Error occured while inserting");
        
        [databasedelhandling_subjects close];
        ////////////////
        
        NSArray *docPathsdelteacher_timetable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirdelteacher_timetable = [docPathsdelteacher_timetable objectAtIndex:0];
        NSString *dbPathdelteacher_timetable = [documentsDirdelteacher_timetable   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *databasedelteacher_timetable = [FMDatabase databaseWithPath:dbPathdelteacher_timetable];
        [databasedelteacher_timetable open];
        
        BOOL isInserted_teacher_timetable = [databasedelteacher_timetable executeUpdate:@"DELETE FROM table_create_teacher_student_details"];
        
        [databasedelteacher_timetable close];
        
        if(isInserted_teacher_timetable)
            NSLog(@"DELETED teacher_timetable Successfully");
        else
            NSLog(@"Error occured while inserting");
        
        //////////////////
        NSArray *docPathsattendence_history = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirattendence_history = [docPathsattendence_history objectAtIndex:0];
        NSString *dbPathattendence_history = [documentsDirattendence_history   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *databaseattendence_history = [FMDatabase databaseWithPath:dbPathattendence_history];
        [databaseattendence_history open];
        
        BOOL isInsertedattendence_history = [databaseattendence_history executeUpdate:@"DELETE FROM table_create_attendence_history"];
        
        [databaseattendence_history close];
        
        if(isInsertedattendence_history)
            NSLog(@"DELETED table_create_attendence_history");
        else
            NSLog(@"Error occured while inserting");
        
        ////////////////////////
        NSArray *docPathstable_create_attendence = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirtable_create_attendence = [docPathstable_create_attendence objectAtIndex:0];
        NSString *dbPathtable_create_attendence = [documentsDirtable_create_attendence   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *databasetable_create_attendence = [FMDatabase databaseWithPath:dbPathtable_create_attendence];
        [databasetable_create_attendence open];
        
        BOOL isInsertedtable_create_attendence = [databasetable_create_attendence executeUpdate:@"DELETE FROM table_create_attendence"];
        
        [databasetable_create_attendence close];
        
        if(isInsertedtable_create_attendence)
            NSLog(@"DELETED table_create_attendence");
        else
            NSLog(@"Error occured while inserting");
        ///////////////////////////////
        
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"admin_teacherid"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"ClassView"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Login_status"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_resultKey"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *viewController = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:viewController animated:self];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
