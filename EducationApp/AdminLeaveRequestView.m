//
//  AdminLeaveRequestView.m
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminLeaveRequestView.h"

@interface AdminLeaveRequestView ()
{
    AppDelegate *appDel;
    NSMutableArray *name;
    NSMutableArray *from_leave_date;
    NSMutableArray *to_leave_date;
    NSMutableArray *frm_time;
    NSMutableArray *to_time;
    NSMutableArray *status;
    NSMutableArray *leave_title;


}
@end

@implementation AdminLeaveRequestView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    name = [[NSMutableArray alloc]init];
    leave_title = [[NSMutableArray alloc]init];
    from_leave_date = [[NSMutableArray alloc]init];
    to_leave_date = [[NSMutableArray alloc]init];
    frm_time = [[NSMutableArray alloc]init];
    to_time = [[NSMutableArray alloc]init];
    status = [[NSMutableArray alloc]init];

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_teachers_leaves = @"/apiadmin/get_teachers_leaves/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_teachers_leaves, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *leaveDetails = [responseObject objectForKey:@"leaveDetails"];
         
         if ([msg isEqualToString:@"leavesfound"])
         {
            
             
             for (int i = 0; i < [leaveDetails count]; i++)
             {
                 NSDictionary *leave = [leaveDetails objectAtIndex:i];
                 
                 NSString *strleave_title = [leave objectForKey:@"leave_title"];
                 NSString *strname = [leave objectForKey:@"name"];
                 NSString *strfrm_time = [leave objectForKey:@"frm_time"];
                 NSString *strto_time = [leave objectForKey:@"to_time"];
                 NSString *strfrom_leave_date = [leave objectForKey:@"from_leave_date"];
                 NSString *strto_leave_date = [leave objectForKey:@"to_leave_date"];
                 NSString *strstatus = [leave objectForKey:@"status"];

                 [name addObject:strname];
                 [from_leave_date addObject:strfrom_leave_date];
                 [to_leave_date addObject:strto_leave_date];
                 [frm_time addObject:strfrm_time];
                 [to_time addObject:strto_time];
                 [status addObject:strstatus];
                 [leave_title addObject:strleave_title];

             }
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
         [self.tableView reloadData];
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminLeaveRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.name.text = [name objectAtIndex:indexPath.row];
    cell.fromDate.text = [from_leave_date objectAtIndex:indexPath.row];
    cell.toDate.text = [to_leave_date objectAtIndex:indexPath.row];
    cell.fromTime.text = [frm_time objectAtIndex:indexPath.row];
    cell.toTime.text = [to_time objectAtIndex:indexPath.row];
    cell.statusLabel.text = [status objectAtIndex:indexPath.row];
    cell.reson.text = [leave_title objectAtIndex:indexPath.row];
    
    NSString *str = [status objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"Approved"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-03.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
    }
    else if ([str isEqualToString:@"Rejected"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-02.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
    }
    else
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-04.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:190/255.0f green:192/255.0f blue:49/255.0f alpha:1.0];
    }
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
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
