//
//  AdminFeeStatusTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminFeeStatusTableViewController.h"

@interface AdminFeeStatusTableViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *name;
    NSMutableArray *updatedAt;
    NSMutableArray *quotaName;
    NSMutableArray *status;

}
@end

@implementation AdminFeeStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    name = [[NSMutableArray alloc]init];
    updatedAt = [[NSMutableArray alloc]init];
    quotaName = [[NSMutableArray alloc]init];
    status = [[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *fess_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"fees_id"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.section_id forKey:@"section_id"];
    [parameters setObject:fess_id forKey:@"fees_id"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_fees_status = @"/apiadmin/get_fees_status/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_fees_status, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *data = [responseObject objectForKey:@"data"];
         
         if ([msg isEqualToString:@"success"])
         {
             for (int i = 0;i < [data count] ; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 
                 NSString *strName = [dict objectForKey:@"name"];
                 NSString *strupdated_at = [dict objectForKey:@"updated_at"];
                 NSString *strquota_name = [dict objectForKey:@"quota_name"];
                 NSString *strstatus = [dict objectForKey:@"status"];
                 
                 [name addObject:strName];
                 [updatedAt addObject:strupdated_at];
                 [quotaName addObject:strquota_name];
                 [status addObject:strstatus];

             }
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminFeeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.name.text = [name objectAtIndex:indexPath.row];
    cell.updatedAtLabel.text = [updatedAt objectAtIndex:indexPath.row];
    cell.qoutaName.text = [quotaName objectAtIndex:indexPath.row];
    
    NSString *Strstatus = [status objectAtIndex:indexPath.row];
    
    if ([Strstatus isEqualToString:@"Paid"])
    {
        cell.status.text  = Strstatus;
        cell.status.textColor = [UIColor colorWithRed:37/255.0f green:169/255.0f blue:79/255.0f alpha:1.0];
    }
    else if ([Strstatus isEqualToString:@"Unpaid"])
    {
        cell.status.text  = Strstatus;
        cell.status.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
    }
    
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

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
