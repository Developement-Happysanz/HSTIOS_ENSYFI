//
//  SideBarTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 12/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SideBarTableViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface SideBarTableViewController ()
{
    NSArray *menuItems;
    NSArray *staticMenu;
    NSMutableArray *abs_date;
    AppDelegate *appDel;
}
@end

@implementation SideBarTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    
    abs_date = [[NSMutableArray alloc]init];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

    menuItems = @[@"samp",@"home",@"profile", @"attendance", @"createtest", @"exam", @"timetable", @"event", @"communication",@"settings",@"studentinfo",@"onduty",@"signout"];
    
    staticMenu = @[@"username"];
    
    [self.tableView registerClass:[SideTableViewCell class] forCellReuseIdentifier:@"SideTableViewCell"];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
}
- (void)didReceiveMemoryWarning
{
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
          SideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if ([appDel.user_type isEqualToString:@"3"])
        {
            
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,student_profile,appDel.user_picture, nil];
            NSString *fullpath= [NSString pathWithComponents:components];
//          [[NSUserDefaults standardUserDefaults]setObject:fullpath forKey:@"stucentImg_fullpath"];
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
            cell.username.text = [NSString stringWithFormat:@"%@, %@",@"Hi",appDel.name];
        }
        else if([appDel.user_type isEqualToString:@"4"])
        {
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            // customization
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,parents_profile,appDel.user_picture, nil];
            NSString *fullpath= [NSString pathWithComponents:components];
//            [[NSUserDefaults standardUserDefaults]setObject:fullpath forKey:@"fatherPic_FullPath"];
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
            cell.username.text = [NSString stringWithFormat:@"%@, %@",@"Hi",appDel.name];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
     //   SideTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"username" forIndexPath:indexPath];

//        UIAlertController* alert = [UIAlertController
//                                    alertControllerWithTitle:nil
//                                    message:nil
//                                    preferredStyle:UIAlertControllerStyleActionSheet];
//
//        UIAlertAction* button0 = [UIAlertAction
//                                  actionWithTitle:@"Cancel"
//                                  style:UIAlertActionStyleCancel
//                                  handler:^(UIAlertAction * action)
//                                  {
//                                  }];
//
//        UIAlertAction* button1 = [UIAlertAction
//                                  actionWithTitle:@"Take photo"
//                                  style:UIAlertActionStyleDefault
//                                  handler:^(UIAlertAction * action)
//                                  {
//                                      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//                                      UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
//                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//                                      imagePickerController.delegate = self;
//                                      alert.popoverPresentationController.sourceView = cell.imageView;
//                                      [self presentViewController:imagePickerController animated:YES completion:^{}];
//                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//                                  }];
//
//        UIAlertAction* button2 = [UIAlertAction
//                                  actionWithTitle:@"Choose From Gallery"
//                                  style:UIAlertActionStyleDefault
//                                  handler:^(UIAlertAction * action)
//                                  {
//                                      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//                                      UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
//                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                                      imagePickerController.delegate = self;
//                                      alert.popoverPresentationController.sourceView = cell.imageView;
//                                      [self presentViewController:imagePickerController animated:YES completion:^{}];
//                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//                                  }];
//
//        [alert addAction:button0];
//        [alert addAction:button1];
//        [alert addAction:button2];
//        alert.popoverPresentationController.sourceView = cell.imageView;
//        [self presentViewController:alert animated:YES completion:nil];
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
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        ProfileViewController *profile = [navController childViewControllers].firstObject;
        NSLog(@"%@",profile);

    }
    else if ([segue.identifier isEqualToString:@"profile"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        ProfileViewController *profileViewController = [navController childViewControllers].firstObject;
        NSLog(@"%@",profileViewController);
        
    }
    else if ([segue.identifier isEqualToString:@"home"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        SideBarTableViewController *sidebartableView = [navController childViewControllers].firstObject;
        NSLog(@"%@",sidebartableView);
        
    }
    else if ([segue.identifier isEqualToString:@"exam"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        ExamsViewController *examsViewController = [navController childViewControllers].firstObject;
        NSLog(@"%@",examsViewController);
        
    }
    else if ([segue.identifier isEqualToString:@"classTest"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        ClassTestViewController *classtest = [navController childViewControllers].firstObject;
        NSLog(@"%@",classtest);
        
    }
    else if ([segue.identifier isEqualToString:@"timetable"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        NewTimeTableViewcontroller *time = [navController childViewControllers].firstObject;
        NSLog(@"%@",time);
        
    }
    else if ([segue.identifier isEqualToString:@"event"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        EventViewController *event = [navController childViewControllers].firstObject;
        NSLog(@"%@",event);
        
    }
    else if ([segue.identifier isEqualToString:@"communication"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        CommunicationViewController *communication = [navController childViewControllers].firstObject;
        NSLog(@"%@",communication);
        
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
                [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
                 UINavigationController *navController = segue.destinationViewController;
                 AttendanceViewController *attendance = [navController childViewControllers].firstObject;
                 NSLog(@"%@",attendance);
        
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//             }
//
//
//
//         }
//              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
//         {
//             NSLog(@"error: %@", error);
//         }];
    }
    else if ([segue.identifier isEqualToString:@"settings"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        SettingsViewController *settings = [navController childViewControllers].firstObject;
        NSLog(@"%@",settings);
        
    }
    else if ([segue.identifier isEqualToString:@"studentinfo"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        UINavigationController *navController = segue.destinationViewController;
        StudentinfoViewController *info = [navController childViewControllers].firstObject;
        NSLog(@"%@",info);
        
    }
    
    else if ([segue.identifier isEqualToString:@"onduty"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"msgKey"];
        UINavigationController *navController = segue.destinationViewController;
        OnDutyTableViewController *onduty = [navController childViewControllers].firstObject;
        NSLog(@"%@",onduty);
        
    }
    else if ([segue.identifier isEqualToString:@"signout"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"sideMenu" forKey:@"view_selection"];
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"msgKey"];
        UINavigationController *navController = segue.destinationViewController;
        ViewController *View = [navController childViewControllers].firstObject;
        NSLog(@"%@",View);
        
    }

}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
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
