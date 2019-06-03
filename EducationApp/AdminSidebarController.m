//
//  AdminSidebarController.m
//  EducationApp
//
//  Created by HappySanz on 17/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminSidebarController.h"

@interface AdminSidebarController ()
{
    AppDelegate *appDel;
    NSArray *menuItems;
    NSArray *staticMenu;
    
    NSMutableArray *class_id;
    NSMutableArray *class_name;
}
@end

@implementation AdminSidebarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
    class_id = [[NSMutableArray alloc]init];
    class_name = [[NSMutableArray alloc]init];
    
    menuItems = @[@"samp",@"home",@"profile",@"students",@"teachers", @"parents", @"classes", @"exams", @"results", @"events",@"communication",@"fee",@"onduty",@"leave",@"settings",@"signout"];
    
    staticMenu = @[@"username"];
    
    [self.tableView registerClass:[SideTableViewCell class] forCellReuseIdentifier:@"AdminTableViewCell"];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        // static cell
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *CellIdentifier = [staticMenu objectAtIndex:indexPath.row];
        AdminTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        // customization
        NSArray *components = [NSArray arrayWithObjects:baseUrl,[[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"],admin_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
        
        NSString *institute_logo_url = [NSString pathWithComponents:components];
        //NSString *fullpath=[[NSUserDefaults standardUserDefaults]objectForKey:@"institute_logo_url"];
        NSURL *url = [NSURL URLWithString:institute_logo_url];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                cell.userImg.image = [UIImage imageWithData:imageData];
                cell.userImg.layer.cornerRadius = 50.0;
                cell.userImg.clipsToBounds = YES;
                
                if (cell.userImg.image == nil)
                {
                    cell.userImg.image = [UIImage imageNamed:@"profile_pic.png"];
                }
            });
        });
        cell.usernameLabel.text = appDel.name;
        return cell;
    }
    else
    {
        NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
    if ([segue.identifier isEqualToString:@"home"])
    {
        UINavigationController *navController = segue.destinationViewController;
        AdminSidebarController *sidebartableView = [navController childViewControllers].firstObject;
        NSLog(@"%@",sidebartableView);

    }
    else if ([segue.identifier isEqualToString:@"students"])
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        NSLog(@"%@",parameters);
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forEvent = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminStudentViewController *adminStudent = (AdminStudentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentViewController"];
                 [self.navigationController pushViewController:adminStudent animated:YES];
                 
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"teachers"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        UINavigationController *navController = segue.destinationViewController;
        AdminTeacherView *adminTeacherView = [navController childViewControllers].firstObject;
        NSLog(@"%@",adminTeacherView);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"events"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        UINavigationController *navController = segue.destinationViewController;
        AdminEventTableViewController *adminEventView = [navController childViewControllers].firstObject;
        NSLog(@"%@",adminEventView);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"communication"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

        UINavigationController *navController = segue.destinationViewController;
        CommunicationViewController *comunicationView = [navController childViewControllers].firstObject;
        NSLog(@"%@",comunicationView);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"classes"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UINavigationController *navController = segue.destinationViewController;
                 AdminClassesViewController *adminClassView = [navController childViewControllers].firstObject;
                 NSLog(@"%@",adminClassView);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];

        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"Exams"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UINavigationController *navController = segue.destinationViewController;
                 AdminExamViewController *adminExamView = [navController childViewControllers].firstObject;
                 NSLog(@"%@",adminExamView);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if ([segue.identifier isEqualToString:@"results"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 UINavigationController *navController = segue.destinationViewController;
                 AdminResultView *adminResultView = [navController childViewControllers].firstObject;
                 NSLog(@"%@",adminResultView);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }

    else if([segue.identifier isEqualToString:@"parents"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UINavigationController *navController = segue.destinationViewController;
                 AdminParentsViewController *adminParentsView = [navController childViewControllers].firstObject;
                 NSLog(@"%@",adminParentsView);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];

        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"onduty"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        UINavigationController *navController = segue.destinationViewController;
        AdminODViewController *adminOdView = [navController childViewControllers].firstObject;
        NSLog(@"%@",adminOdView);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"leave"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        UINavigationController *navController = segue.destinationViewController;
        AdminLeaveRequestView *adminleaveView = [navController childViewControllers].firstObject;
        NSLog(@"%@",adminleaveView);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([segue.identifier isEqualToString:@"settings"])
    {
        UINavigationController *navController = segue.destinationViewController;
        TeacherSettingsViewController *teacherSettingsViewController = [navController childViewControllers].firstObject;
        NSLog(@"%@",teacherSettingsViewController);
    }
    else if ([segue.identifier isEqualToString:@"fee"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [class_id removeAllObjects];
             [class_name removeAllObjects];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UINavigationController *navController = segue.destinationViewController;
                 AdminFeeViewController *adminFeeView = [navController childViewControllers].firstObject;
                 NSLog(@"%@",adminFeeView);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
                          
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 15)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *viewController = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    
}
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
