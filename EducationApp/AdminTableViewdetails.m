//
//  AdminTableViewdetails.m
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminTableViewdetails.h"

@interface AdminTableViewdetails ()
{
    AppDelegate *appDel;
    NSMutableArray *due_date_from;
    NSMutableArray *due_date_to;
    NSMutableArray *from_year;
    NSMutableArray *to_year;
    NSMutableArray *term_name;
    NSMutableArray *fees_id;

}
@end

@implementation AdminTableViewdetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    due_date_from = [[NSMutableArray alloc]init];
    due_date_to = [[NSMutableArray alloc]init];
    from_year = [[NSMutableArray alloc]init];
    to_year = [[NSMutableArray alloc]init];
    term_name = [[NSMutableArray alloc]init];
    fees_id = [[NSMutableArray alloc]init];

        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.class_id forKey:@"class_id"];
        [parameters setObject:appDel.section_id forKey:@"section_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *adminget_fees_master_class = @"/apiadmin/get_fees_master_class";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,adminget_fees_master_class, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSArray *data = [responseObject objectForKey:@"data"];
             
             for (int i = 0; i < [data count]; i++)
             {
                 
                 NSDictionary *feesDict = [data objectAtIndex:i];
                 NSString *str_due_date_from = [feesDict valueForKey:@"due_date_from"];
                 NSString *str_due_date_to = [feesDict valueForKey:@"due_date_to"];
                 NSString *str_fees_id = [feesDict valueForKey:@"fees_id"];
                 NSString *str_from_year = [feesDict valueForKey:@"from_year"];
                 NSString *str_to_year = [feesDict valueForKey:@"to_year"];
                 NSString *str_term_name = [feesDict valueForKey:@"term_name"];

                 [due_date_from addObject:str_due_date_from];
                 [due_date_to addObject:str_due_date_to];
                 [fees_id addObject:str_fees_id];
                 [from_year addObject:str_from_year];
                 [to_year addObject:str_to_year];
                 [term_name addObject:str_term_name];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [term_name count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminTableViewDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdminTableViewDetailCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.termName.text = [term_name objectAtIndex:indexPath.row];
    cell.fromDate.text = [due_date_from objectAtIndex:indexPath.row];
    cell.toDate.text =  [due_date_to objectAtIndex:indexPath.row];
    cell.fromYear.text = [from_year objectAtIndex:indexPath.row];
    cell.toYear.text = [to_year objectAtIndex:indexPath.row];
    cell.fessId.text = [fees_id objectAtIndex:indexPath.row];

    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AdminTableViewDetailCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *fessId = selectedCell.fessId.text;
    [[NSUserDefaults standardUserDefaults]setObject:fessId forKey:@"admin_Fessid"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FessTableViewController *fessTableView = (FessTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FessTableViewController"];
    [self.navigationController pushViewController:fessTableView animated:YES];
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
