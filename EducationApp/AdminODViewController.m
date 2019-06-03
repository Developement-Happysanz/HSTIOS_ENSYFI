//
//  AdminODViewController.m
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminODViewController.h"

@interface AdminODViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *odTitle;
    NSMutableArray *frmDate;
    NSMutableArray *toDte;
    NSMutableArray *odStatus;
    NSMutableArray *name;

}
@end

@implementation AdminODViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([appDel.user_type isEqualToString:@"4"])
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem = nil;
    }

    odTitle = [[NSMutableArray alloc]init];
    frmDate = [[NSMutableArray alloc]init];
    toDte = [[NSMutableArray alloc]init];
    odStatus = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];
//    [parameters setObject:appDel.user_type forKey:@"user_type"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forDispOd = @"/apiadmin/get_students_od_view/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
         
         if ([msg isEqualToString:@"odviewfound"])
         {
             [odTitle removeAllObjects];
             [frmDate removeAllObjects];
             [toDte removeAllObjects];
             [odStatus removeAllObjects];
             [name removeAllObjects];
             
             for (int i = 0; i < [ondutyDetails count]; i++)
             {
                 NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                 
                 NSString *od_for = [onduty objectForKey:@"od_for"];
                 NSString *fromDate = [onduty objectForKey:@"from_date"];
                 NSString *toDate = [onduty objectForKey:@"to_date"];
                 NSString *status = [onduty objectForKey:@"status"];
                 NSString *strname = [onduty objectForKey:@"name"];
                 
                 [odTitle addObject:od_for];
                 [frmDate addObject:fromDate];
                 [toDte addObject:toDate];
                 [odStatus addObject:status];
                 [name addObject:strname];
             }
         }
         else
         {
             
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentBtn:(id)sender
{
    if(_segmentControl.selectedSegmentIndex==0)

    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
//        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forDispOd = @"/apiadmin/get_students_od_view/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forDispOd, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"odviewfound"])
             {
                 [odTitle removeAllObjects];
                 [frmDate removeAllObjects];
                 [toDte removeAllObjects];
                 [odStatus removeAllObjects];
                 [name removeAllObjects];

                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     NSString *strname = [onduty objectForKey:@"name"];

                     [odTitle addObject:od_for];
                     [frmDate addObject:fromDate];
                     [toDte addObject:toDate];
                     [odStatus addObject:status];
                     [name addObject:strname];

                 }
             }
             else
             {
                 
             }
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *disp_Leavetype = @"/apiadmin/get_teachers_od_view/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Leavetype, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *ondutyDetails = [responseObject objectForKey:@"ondutyDetails"];
             
             if ([msg isEqualToString:@"odviewfound"])
             {
                 
                 [odTitle removeAllObjects];
                 [frmDate removeAllObjects];
                 [toDte removeAllObjects];
                 [odStatus removeAllObjects];
                 [name removeAllObjects];

                 
                 for (int i = 0; i < [ondutyDetails count]; i++)
                 {
                     NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                     
                     NSString *od_for = [onduty objectForKey:@"od_for"];
                     NSString *fromDate = [onduty objectForKey:@"from_date"];
                     NSString *toDate = [onduty objectForKey:@"to_date"];
                     NSString *status = [onduty objectForKey:@"status"];
                     NSString *strname = [onduty objectForKey:@"name"];

                     [odTitle addObject:od_for];
                     [frmDate addObject:fromDate];
                     [toDte addObject:toDate];
                     [odStatus addObject:status];
                     [name addObject:strname];

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
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [odTitle count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminODTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.titleLabel.text = [odTitle objectAtIndex:indexPath.row];
    cell.nameLabel.text = [name objectAtIndex:indexPath.row];
    
    NSString *str = [odStatus objectAtIndex:indexPath.row];
    
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
    
    cell.fromdate.text = [frmDate objectAtIndex:indexPath.row];
    cell.toDate.text = [toDte objectAtIndex:indexPath.row];
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
@end
