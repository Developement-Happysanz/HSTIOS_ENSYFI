//
//  TeacherApplyLeave.m
//  EducationApp
//
//  Created by HappySanz on 20/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherApplyLeave.h"

@interface TeacherApplyLeave ()
{
    
    AppDelegate *appDel;
    NSMutableArray *LeaveTitle;
    NSMutableArray *frmDate;
    NSMutableArray *toDte;
    NSMutableArray *LeaveStatus;
    
    NSMutableArray *LeaveTitle_view;
    NSMutableArray *leave_id;
    NSMutableArray *leave_type;
}

@end

@implementation TeacherApplyLeave

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([appDel.user_type isEqualToString:@"2"])
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem = nil;
        
    }
    
    LeaveTitle = [[NSMutableArray alloc]init];
    frmDate = [[NSMutableArray alloc]init];
    toDte = [[NSMutableArray alloc]init];
    LeaveStatus = [[NSMutableArray alloc]init];
    
    LeaveTitle_view = [[NSMutableArray alloc]init];
    leave_id = [[NSMutableArray alloc]init];
    leave_type = [[NSMutableArray alloc]init];

    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarBtn setTarget: self.revealViewController];
        [self.sidebarBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    [self serviceCall];
}
-(void)serviceCall
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *Userleaves = @"/apiteacher/disp_Userleaves/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,Userleaves, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         NSArray *leaveDetails = [responseObject objectForKey:@"leaveDetails"];
         
         if ([msg isEqualToString:@"View Leaves"])
         {
             
             [LeaveTitle removeAllObjects];
             [frmDate removeAllObjects];
             [toDte removeAllObjects];
             [LeaveStatus removeAllObjects];
             
             
             for (int i = 0; i < [leaveDetails count]; i++)
             {
                 NSDictionary *onduty = [leaveDetails objectAtIndex:i];
                 
                 NSString *Strleave_title = [onduty objectForKey:@"leave_title"];
                 NSString *strstatus = [onduty objectForKey:@"status"];
                 NSString *Strfrom_leave_date = [onduty objectForKey:@"from_leave_date"];
                 NSString *strto_leave_date = [onduty objectForKey:@"to_leave_date"];
                 
                 [LeaveTitle addObject:Strleave_title];
                 [frmDate addObject:Strfrom_leave_date];
                 [toDte addObject:strto_leave_date];
                 [LeaveStatus addObject:strstatus];
             }
             
             [self.tableView reloadData];
             
         }
         else
         {
             
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self serviceCall];
//
//}
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
    return [LeaveTitle count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherApplyLeaveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherApplyLeaveCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.title.text = [LeaveTitle objectAtIndex:indexPath.row];
    NSString *str = [LeaveStatus objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"Approved"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-03.png"];
        cell.status.text = str;
        cell.status.textColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
    }
    else if ([str isEqualToString:@"Rejected"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-02.png"];
        cell.status.text = str;
        cell.status.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
    }
    else
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-04.png"];
        cell.status.text = str;
        cell.status.textColor = [UIColor colorWithRed:190/255.0f green:192/255.0f blue:49/255.0f alpha:1.0];
        
    }
    
    cell.fromdate.text = [frmDate objectAtIndex:indexPath.row];
    cell.todate.text = [toDte objectAtIndex:indexPath.row];
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
        
    return cell;
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
- (IBAction)plusButton:(id)sender;
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *Leavetype = @"/apiteacher/disp_Leavetype/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,Leavetype, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         NSArray *leaveDetails = [responseObject objectForKey:@"leaveDetails"];
         
         if ([msg isEqualToString:@"View Leave Types"] && [status isEqualToString:@"success"])
         {
             
             [LeaveTitle_view removeAllObjects];
             [leave_id removeAllObjects];
             [leave_type removeAllObjects];
             
             for (int i = 0; i < [leaveDetails count]; i++)
             {
                 NSDictionary *onduty = [leaveDetails objectAtIndex:i];
                 
                 NSString *strleave_id = [onduty objectForKey:@"id"];
                 NSString *Strleave_title = [onduty objectForKey:@"leave_title"];
                 NSString *Strleave_type = [onduty objectForKey:@"leave_type"];
                 
                 [leave_id addObject:strleave_id];
                 [LeaveTitle_view addObject:Strleave_title];
                 [leave_type addObject:Strleave_type];
             }
             
             [[NSUserDefaults standardUserDefaults]setObject:LeaveTitle_view forKey:@"leaveTitle_key"];
             [[NSUserDefaults standardUserDefaults]setObject:leave_id forKey:@"leave_id_key"];

             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
             TeacherApplyLeaveViewController *teacherApplyLeaveViewController = (TeacherApplyLeaveViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherApplyLeaveViewController"];
             [self.navigationController pushViewController:teacherApplyLeaveViewController animated:YES];
         }
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
}
@end
