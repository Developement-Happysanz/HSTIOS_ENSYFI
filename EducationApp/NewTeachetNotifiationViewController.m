//
//  NewTeachetNotifiationViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 14/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "NewTeachetNotifiationViewController.h"

@interface NewTeachetNotifiationViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *created_at;
    NSMutableArray *created_by;
    NSMutableArray *lead_name;
    NSMutableArray *group_lead_id;
    NSMutableArray *group_title;
    NSMutableArray *_id;
    NSMutableArray *status;
    NSMutableArray *updated_at;
    NSMutableArray *updated_by;
    NSMutableArray *year_id;
}
@end

@implementation NewTeachetNotifiationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    created_at = [[NSMutableArray alloc]init];
    created_by = [[NSMutableArray alloc]init];
    lead_name = [[NSMutableArray alloc]init];
    group_lead_id = [[NSMutableArray alloc]init];
    group_title = [[NSMutableArray alloc]init];
    _id = [[NSMutableArray alloc]init];
    status = [[NSMutableArray alloc]init];
    updated_at = [[NSMutableArray alloc]init];
    updated_by = [[NSMutableArray alloc]init];
    year_id = [[NSMutableArray alloc]init];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"1" forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *list_groupmaster = @"apiadmin/list_groupmaster";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,list_groupmaster, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *dataArray = [responseObject objectForKey:@"groupList"];
         if ([msg isEqualToString:@"Group List"])
         {
             [created_at removeAllObjects];
             [created_by removeAllObjects];
             [group_lead_id removeAllObjects];
             [group_title removeAllObjects];
             [_id removeAllObjects];
             [status removeAllObjects];
             [updated_at removeAllObjects];
             [updated_by removeAllObjects];
             [year_id removeAllObjects];
             [lead_name removeAllObjects];
             
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *data = [dataArray objectAtIndex:i];
                 NSString *strCreated_at = [data valueForKey:@"created_at"];
                 NSString *strCreated_by = [data valueForKey:@"created_by"];
                 NSString *strGroup_lead_id = [data valueForKey:@"group_lead_id"];
                 NSString *strGroup_title = [data valueForKey:@"group_title"];
                 NSString *str_id = [data valueForKey:@"id"];
                 NSString *strStatus = [data valueForKey:@"status"];
                 NSString *strUpdated_at = [data valueForKey:@"updated_at"];
                 NSString *strUpdated_by = [data valueForKey:@"updated_by"];
                 NSString *strYear_id = [data valueForKey:@"year_id"];
                 NSString *strLead_name = [data valueForKey:@"lead_name"];
                 
                 [created_at addObject:strCreated_at];
                 [created_by addObject:strCreated_by];
                 [group_lead_id addObject:strGroup_lead_id];
                 [group_title addObject:strGroup_title];
                 [_id addObject:str_id];
                 [status addObject:strStatus];
                 [updated_at addObject:strUpdated_at];
                 [updated_by addObject:strUpdated_by];
                 [year_id addObject:strYear_id];
                 [lead_name addObject:strLead_name];
             }
                 [self.tableView reloadData];
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
    return [group_title count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [group_title objectAtIndex:indexPath.row];
    cell.Lead.text = [lead_name objectAtIndex:indexPath.row];
    NSString *strSatus = [status objectAtIndex:indexPath.row];
    if ([strSatus isEqualToString:@"Active"])
    {
        cell.statusView.image = [UIImage imageNamed:@"Green"];
    }
    else
    {
        cell.statusView.image = [UIImage imageNamed:@"Red"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *StrGroup_id = [_id objectAtIndex:indexPath.row];
    NSString *StrGroup_title = [group_title objectAtIndex:indexPath.row];
    NSString *StrStatus = [status objectAtIndex:indexPath.row];
    NSString *StrLead_name = [lead_name objectAtIndex:indexPath.row];
    NSString *StrGroup_lead_id = [group_lead_id objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:StrGroup_id forKey:@"GN_StrGroup_id"];
    [[NSUserDefaults standardUserDefaults]setObject:StrGroup_title forKey:@"GN_Group_title"];
    [[NSUserDefaults standardUserDefaults]setObject:StrStatus forKey:@"GN_status"];
    [[NSUserDefaults standardUserDefaults]setObject:StrLead_name forKey:@"GN_lead_name"];
    [[NSUserDefaults standardUserDefaults]setObject:StrGroup_lead_id forKey:@"GN_lead_id"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
    GroupNotificationStatusViewController *groupNotificationStatusViewController = (GroupNotificationStatusViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GroupNotificationStatusViewController"];
    [self.navigationController pushViewController:groupNotificationStatusViewController animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}
@end
