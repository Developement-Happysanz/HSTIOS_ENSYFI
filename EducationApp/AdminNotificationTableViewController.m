    //
//  AdminNotificationTableViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/03/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AdminNotificationTableViewController.h"

@interface AdminNotificationTableViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *group_title;
    NSMutableArray *group_title_id;
    NSMutableArray *notification_type;
    NSMutableArray *notes;
    
    NSMutableArray *name;
    NSMutableArray *created_by;
    NSMutableArray *created_at;
    NSString *group_idFlag;

}
@end

@implementation AdminNotificationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController.navigationBar setHidden:NO];
    
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
    
    group_title = [[NSMutableArray alloc]init];
    group_title_id = [[NSMutableArray alloc]init];
    notification_type = [[NSMutableArray alloc]init];
    notes = [[NSMutableArray alloc]init];
    created_at = [[NSMutableArray alloc]init];

    name = [[NSMutableArray alloc]init];
    created_by = [[NSMutableArray alloc]init];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    group_idFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_type forKey:@"user_type"];
    [parameters setObject:appDel.user_id forKey:@"user_id"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
//    NSString *grp_messsage_history = @"apimain/grp_messsage_history";
    NSString *grp_messsage_history = @"apimain/disp_Groupmessage";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,grp_messsage_history, nil];
    NSString *api = [NSString pathWithComponents:components];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
//         NSArray *groupmsgDetails = [responseObject objectForKey:@"msg_history"];
         NSArray *groupmsgDetails = [responseObject objectForKey:@"groupmsgDetails"];
//         if ([msg isEqualToString:@"History Found"] && [status isEqualToString:@"success"])
//         {
//             [group_title removeAllObjects];
//             [group_title_id removeAllObjects];
//             [notification_type removeAllObjects];
//             [notes removeAllObjects];
//             [created_at removeAllObjects];
//             [created_by removeAllObjects];
//             [name removeAllObjects];
//
//             for (int i = 0; i < [groupmsgDetails count]; i++)
//             {
//
//                 NSDictionary *dict = [groupmsgDetails objectAtIndex:i];
//                 NSString *strgroup_title = [dict objectForKey:@"group_title"];
//                 NSString *strgroup_title_id = [dict objectForKey:@"group_title_id"];
//                 NSString *strNotification_type = [dict objectForKey:@"notification_type"];
//                 NSString *strnotes = [dict objectForKey:@"notes"];
//                 NSString *strCreated_at = [dict objectForKey:@"created_at"];
//                 NSString *strCreated_by = [dict objectForKey:@"created_by"];
//
//                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                 [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                 NSDate *date = [dateFormatter dateFromString:strCreated_at];
//                 dateFormatter = [[NSDateFormatter alloc] init];
//                 [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
//                 NSString *convertedString = [dateFormatter stringFromDate:date];
//
//                 [group_title addObject:strgroup_title];
//                 [group_title_id addObject:strgroup_title_id];
//                 [notification_type addObject:strNotification_type];
//                 [notes addObject:strnotes];
//                 [created_at addObject:convertedString];
//                 [created_by addObject:strCreated_by];
//
//             }
//                [self.tableView reloadData];
//         }
//         else
//         {
//             UIAlertController *alert= [UIAlertController
//                                        alertControllerWithTitle:@"ENSYFI"
//                                        message:msg
//                                        preferredStyle:UIAlertControllerStyleAlert];
//
//             UIAlertAction *ok = [UIAlertAction
//                                  actionWithTitle:@"OK"
//                                  style:UIAlertActionStyleDefault
//                                  handler:^(UIAlertAction * action)
//                                  {
//
//                                  }];
//
//             [alert addAction:ok];
//             [self presentViewController:alert animated:YES completion:nil];
//
//         }
                  if ([msg isEqualToString:@"View Group Messages"])
                  {
                      [group_title removeAllObjects];
                      [group_title_id removeAllObjects];
                      [notification_type removeAllObjects];
                      [notes removeAllObjects];
                      [created_at removeAllObjects];
                      [created_by removeAllObjects];
                      [name removeAllObjects];
         
                      for (int i = 0; i < [groupmsgDetails count]; i++)
                      {
         
                          NSDictionary *dict = [groupmsgDetails objectAtIndex:i];
                          NSString *strgroup_title = [dict objectForKey:@"group_title"];
                          NSString *strgroup_title_id = [dict objectForKey:@"group_title_id"];
//                          NSString *strNotification_type = [dict objectForKey:@"notification_type"];
                          NSString *strnotes = [dict objectForKey:@"notes"];
                          NSString *strCreated_at = [dict objectForKey:@"created_at"];
//                          NSString *strCreated_by = [dict objectForKey:@"created_by"];
         
                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                          NSDate *date = [dateFormatter dateFromString:strCreated_at];
                          dateFormatter = [[NSDateFormatter alloc] init];
                          [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
                          NSString *convertedString = [dateFormatter stringFromDate:date];
         
                          [group_title addObject:strgroup_title];
                          [group_title_id addObject:strgroup_title_id];
//                          [notification_type addObject:strNotification_type];
                          [notes addObject:strnotes];
                          [created_at addObject:convertedString];
//                          [created_by addObject:strCreated_by];
         
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
    return [group_title count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.notesTxtView.delegate = self;
    cell.titleLabel.text = [group_title objectAtIndex:indexPath.row];
    cell.notesTxtView.text = [notes objectAtIndex:indexPath.row];
    cell.dateLabel.text = [created_at objectAtIndex:indexPath.row];

    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
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

- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
