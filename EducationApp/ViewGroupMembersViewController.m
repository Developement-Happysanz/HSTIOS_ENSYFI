//
//  ViewGroupMembersViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 17/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ViewGroupMembersViewController.h"

@interface ViewGroupMembersViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *name;
    NSMutableArray *user_type_name;
    NSMutableArray *_id;

}
@end

@implementation ViewGroupMembersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    name = [[NSMutableArray alloc]init];
    user_type_name = [[NSMutableArray alloc]init];
    _id = [[NSMutableArray alloc]init];
    
    NSString *g_Id = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:g_Id forKey:@"group_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *list_gn_members = @"apiadmin/list_gn_members";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,list_gn_members, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *dataArray = [responseObject objectForKey:@"memberList"];
         if ([msg isEqualToString:@"Group Member Details"])
         {
             
             [_id removeAllObjects];
             [user_type_name removeAllObjects];
             [name removeAllObjects];
             
             for (int i = 0;i < [dataArray count]; i++)
             {
                 NSArray *Data = [dataArray objectAtIndex:i];
                 NSString *strName = [Data valueForKey:@"name"];
                 NSString *strUser_type_name = [Data valueForKey:@"user_type_name"];
                 NSString *strId = [Data valueForKey:@"id"];

                 [_id addObject:strId];
                 [user_type_name addObject:strUser_type_name];
                 [name addObject:strName];

             }
             
         }
             [self.tableView reloadData];
         }
     
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewGroupMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.memberName.text = [name objectAtIndex:indexPath.row];
    cell.memberType.text = [user_type_name objectAtIndex:indexPath.row];
    return cell;
}
- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
