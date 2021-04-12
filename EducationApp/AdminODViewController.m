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
    NSMutableArray *_id;
    NSArray *categoeryArray;
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
    _id = [[NSMutableArray alloc]init];
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    

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
    
//    CGRect frame= _segmentControl.frame;
//    [_segmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,42)];
//    [_segmentControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
//
//    _categoeryOutlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
//    _categoeryOutlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
//    _categoeryOutlet.layer.borderWidth = 1.0f;
//    [_categoeryOutlet.layer setCornerRadius:10.0f];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];

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
             [self->odTitle removeAllObjects];
             [self->frmDate removeAllObjects];
             [self->toDte removeAllObjects];
             [self->odStatus removeAllObjects];
             [self->name removeAllObjects];
             [self->_id removeAllObjects];

             for (int i = 0; i < [ondutyDetails count]; i++)
             {
                 NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                 NSString *od_for = [onduty objectForKey:@"od_for"];
                 NSString *fromDate = [onduty objectForKey:@"from_date"];
                 NSString *toDate = [onduty objectForKey:@"to_date"];
                 NSString *status = [onduty objectForKey:@"status"];
                 NSString *strname = [onduty objectForKey:@"name"];
                 NSString *str_id = [onduty objectForKey:@"id"];

                 [self->odTitle addObject:od_for];
                 [self->frmDate addObject:fromDate];
                 [self->toDte addObject:toDate];
                 [self->odStatus addObject:status];
                 [self->name addObject:strname];
                 [self->_id addObject:str_id];

             }
             [self.tableView reloadData];
         }

         [MBProgressHUD hideHUDForView:self.view animated:YES];

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    categoeryArray = [NSArray arrayWithObjects:@"Applied",@"Applied for", nil];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
}

-(void)viewDidLayoutSubviews
{
    CGRect frame= _segmentControl.frame;
    [_segmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 45)];
    
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
  //  NSString *strCategoery = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
    if(_segmentControl.selectedSegmentIndex==0)
    {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_id forKey:@"user_id"];
    
    
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
                     [self->odTitle removeAllObjects];
                     [self->frmDate removeAllObjects];
                     [self->toDte removeAllObjects];
                     [self->odStatus removeAllObjects];
                     [self->name removeAllObjects];
                     [self->_id removeAllObjects];

                     for (int i = 0; i < [ondutyDetails count]; i++)
                     {
                         NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                         
                         NSString *od_for = [onduty objectForKey:@"od_for"];
                         NSString *fromDate = [onduty objectForKey:@"from_date"];
                         NSString *toDate = [onduty objectForKey:@"to_date"];
                         NSString *status = [onduty objectForKey:@"status"];
                         NSString *strname = [onduty objectForKey:@"name"];
                         NSString *str_id = [onduty objectForKey:@"id"];

                         [self->odTitle addObject:od_for];
                         [self->frmDate addObject:fromDate];
                         [self->toDte addObject:toDate];
                         [self->odStatus addObject:status];
                         [self->name addObject:strname];
                         [self->_id addObject:str_id];
                     }
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
                     
                     [self->odTitle removeAllObjects];
                     [self->frmDate removeAllObjects];
                     [self->toDte removeAllObjects];
                     [self->odStatus removeAllObjects];
                     [self->name removeAllObjects];
                     [self->_id removeAllObjects];
                     
                     for (int i = 0; i < [ondutyDetails count]; i++)
                     {
                         NSDictionary *onduty = [ondutyDetails objectAtIndex:i];
                         NSString *od_for = [onduty objectForKey:@"od_for"];
                         NSString *fromDate = [onduty objectForKey:@"from_date"];
                         NSString *toDate = [onduty objectForKey:@"to_date"];
                         NSString *status = [onduty objectForKey:@"status"];
                         NSString *strname = [onduty objectForKey:@"name"];
                         NSString *str_id = [onduty objectForKey:@"id"];

                         [self->odTitle addObject:od_for];
                         [self->frmDate addObject:fromDate];
                         [self->toDte addObject:toDate];
                         [self->odStatus addObject:status];
                         [self->name addObject:strname];
                         [self->_id addObject:str_id];

                     }
                     [self.tableView reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminODTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = [odTitle objectAtIndex:indexPath.row];
    cell.nameLabel.text = [name objectAtIndex:indexPath.row];
    
    NSString *str = [odStatus objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"Approved"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-03.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
        cell.statusView.backgroundColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
    }
    else if ([str isEqualToString:@"Rejected"])
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-02.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
        cell.statusView.backgroundColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];

    }
    else
    {
        cell.statusImg.image = [UIImage imageNamed:@"ensyfi od screen icons-04.png"];
        cell.statusLabel.text = str;
        cell.statusLabel.textColor = [UIColor colorWithRed:190/255.0f green:192/255.0f blue:49/255.0f alpha:1.0];
        cell.statusView.backgroundColor = [UIColor colorWithRed:190/255.0f green:192/255.0f blue:49/255.0f alpha:1.0];

    }
    cell.fromdate.text = [NSString stringWithFormat:@"%@ - %@",[frmDate objectAtIndex:indexPath.row],[toDte objectAtIndex:indexPath.row]];
   // cell.toDate.text = ;
    
    cell.cellView.layer.cornerRadius = 8.0f;
    cell.cellView.clipsToBounds = YES;
    
    cell.cellView.layer.shadowRadius  = 5.5f;
    cell.cellView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.cellView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.cellView.layer.shadowOpacity = 0.6f;
    cell.cellView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.cellView.bounds, shadowInsets)];
    cell.cellView.layer.shadowPath    = shadowPath.CGPath;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [odStatus objectAtIndex:indexPath.row];
    if([str isEqualToString:@"Approved"])
    {
        NSString *strname = [name objectAtIndex:indexPath.row];
        NSString *date  = [NSString stringWithFormat:@"%@ - %@",[frmDate objectAtIndex:indexPath.row],[toDte objectAtIndex:indexPath.row]];
        NSString *strStatus = [odTitle objectAtIndex:indexPath.row];
        NSString *strID  = [_id objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"OD_id"];
        [[NSUserDefaults standardUserDefaults]setObject:strname forKey:@"odName"];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"oddate"];
        [[NSUserDefaults standardUserDefaults]setObject:strStatus forKey:@"odStatus"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        ODPermisionViewController *oDPermision = (ODPermisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ODPermisionViewController"];
        [self.navigationController pushViewController:oDPermision animated:YES];
    }
    else if ([str isEqualToString:@"Rejected"])
    {
        NSString *strname = [name objectAtIndex:indexPath.row];
        NSString *date  = [NSString stringWithFormat:@"%@ - %@",[frmDate objectAtIndex:indexPath.row],[toDte objectAtIndex:indexPath.row]];
        NSString *strStatus = [odTitle objectAtIndex:indexPath.row];
        NSString *strID  = [_id objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"OD_id"];
        [[NSUserDefaults standardUserDefaults]setObject:strname forKey:@"odName"];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"oddate"];
        [[NSUserDefaults standardUserDefaults]setObject:strStatus forKey:@"odStatus"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        ODPermisionViewController *oDPermision = (ODPermisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ODPermisionViewController"];
        [self.navigationController pushViewController:oDPermision animated:YES];
    }
    else if ([str isEqualToString:@"Pending"])
    {
        NSString *strname = [name objectAtIndex:indexPath.row];
        NSString *date  = [NSString stringWithFormat:@"%@ - %@",[frmDate objectAtIndex:indexPath.row],[toDte objectAtIndex:indexPath.row]];
        NSString *strStatus = [odTitle objectAtIndex:indexPath.row];
        NSString *strID  = [_id objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"OD_id"];
        [[NSUserDefaults standardUserDefaults]setObject:strname forKey:@"odName"];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"oddate"];
        [[NSUserDefaults standardUserDefaults]setObject:strStatus forKey:@"odStatus"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        ODPermisionViewController *oDPermision = (ODPermisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ODPermisionViewController"];
        [self.navigationController pushViewController:oDPermision animated:YES];
    }
}
//- (IBAction)categoertBtn:(id)sender
//{
////    if(dropDown == nil)
////    {
////        CGFloat f = 200;
////        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :categoeryArray :nil :@"down"];
////        [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];
////        dropDown.delegate = self;
////    }
////    else
////    {
////        [dropDown hideDropDown:sender];
////        [self rel];
////    }
//}
//- (void)niDropDownDelegateMethod: (NIDropDown *) sender
//{
//    [self rel];
//}
//-(void)rel
//{
//    dropDown = nil;
//}
@end
