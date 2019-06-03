//
//  FessTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 12/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "FessTableViewController.h"

@interface FessTableViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *status;
    NSMutableArray *term_name;
    
    NSMutableArray *due_date_from;
    NSMutableArray *due_date_to;

}
@end

@implementation FessTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    due_date_from = [[NSMutableArray alloc]init];
    due_date_to = [[NSMutableArray alloc]init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    status = [[NSMutableArray alloc]init];
    term_name = [[NSMutableArray alloc]init];
    
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.student_id forKey:@"stud_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forFeesDetails = @"/apistudent/disp_Fees/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forFeesDetails, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSArray *feesDetails = [responseObject objectForKey:@"feesDetails"];
             
             for (int i = 0; i < [feesDetails count]; i++)
             {
                 
                 NSDictionary *feesDict = [feesDetails objectAtIndex:i];
                 NSString *Feestatus = [feesDict valueForKey:@"status"];
                 NSString *termname = [feesDict valueForKey:@"term_name"];
                 NSString *str_due_date_from = [feesDict valueForKey:@"due_date_from"];
                 NSString *str_due_date_to = [feesDict valueForKey:@"due_date_to"];

                 [status addObject:Feestatus];
                 [term_name addObject:termname];
                 [due_date_from addObject:str_due_date_from];
                 [due_date_to addObject:str_due_date_to];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [term_name count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FessTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.termName.text = [term_name objectAtIndex:indexPath.row];
    cell.status.text = [status objectAtIndex:indexPath.row];
    
    if ([cell.status.text isEqualToString:@"Paid"])
    {
        cell.status.textColor = [UIColor colorWithRed:8/255.0f green:159/255.0f blue:73/255.0f alpha:1.0];
        
        [cell.status.text uppercaseString];
    }
    else
    {
        cell.status.textColor = [UIColor colorWithRed:216/255.0f green:91/255.0f blue:74/255.0f alpha:1.0];
        
        [cell.status.text uppercaseString];

    }
    
    cell.dueFrom.text = [due_date_from objectAtIndex:indexPath.row];
    cell.dueTo.text = [due_date_to objectAtIndex:indexPath.row];

    cell.mainView.layer.borderWidth = 1.0f;
    cell.mainView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.mainView.layer.cornerRadius = 6.0f;
    
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
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([str isEqualToString:@"admin"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        AdminStudentProfileView *adminStudentProfileView = (AdminStudentProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentProfileView"];
        [self.navigationController pushViewController:adminStudentProfileView animated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:Nil];

    }
}
@end
