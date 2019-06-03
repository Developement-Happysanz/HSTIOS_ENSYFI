//
//  CommunicationViewController.m
//  EducationApp
//
//  Created by HappySanz on 18/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "CommunicationViewController.h"

@interface CommunicationViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *circular_date;
    NSMutableArray *circular_details;
    NSMutableArray *circular_title;
    NSMutableArray *circular_Type;

}

@end

@implementation CommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    circular_date = [[NSMutableArray alloc]init];
    circular_details = [[NSMutableArray alloc]init];
    circular_title = [[NSMutableArray alloc]init];
    circular_Type = [[NSMutableArray alloc]init];
    
    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([stat_user_type isEqualToString:@"admin"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = backButton;
        
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *disp_Circular = @"/apiadmin/get_all_circular_view/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Circular, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSArray *arr_Circular = [responseObject objectForKey:@"circularDetails"];
             
             
             for (int i = 0; i < [arr_Circular count]; i++)
             {
                 NSDictionary *circularDetails = [arr_Circular objectAtIndex:i];
                 
                 NSString *c_title = [circularDetails objectForKey:@"circular_title"];
                 NSString *c_date = [circularDetails objectForKey:@"circular_date"];
                 NSString *c_details = [circularDetails objectForKey:@"circular_description"];
                 NSString *c_Type = [circularDetails objectForKey:@"circular_type"];
                 
                 
                 [circular_title addObject:c_title];
                 [circular_date addObject:c_date];
                 [circular_details addObject:c_details];
                 [circular_Type addObject:c_Type];
                 
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
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *disp_Circular = @"/apimain/disp_Circular/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Circular, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             
             if ([msg isEqualToString:@"View Circular"])
             {
                 NSArray *arr_Circular = [responseObject objectForKey:@"circularDetails"];
                 
                 
                 for (int i = 0; i < [arr_Circular count]; i++)
                 {
                     NSDictionary *circularDetails = [arr_Circular objectAtIndex:i];
                     
                     NSString *c_title = [circularDetails objectForKey:@"circular_title"];
                     NSString *c_date = [circularDetails objectForKey:@"circular_date"];
                     NSString *c_details = [circularDetails objectForKey:@"circular_description"];
                     NSString *c_Type = [circularDetails objectForKey:@"circular_type"];
                     
                     
                     [circular_title addObject:c_title];
                     [circular_date addObject:c_date];
                     [circular_details addObject:c_details];
                     [circular_Type addObject:c_Type];
                     
                 }
                 
                 [self.tableView reloadData];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Circular not found."
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction
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
    
}
- (IBAction)Back
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
    AdminViewController *adminView = (AdminViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminViewController"];
    [self.navigationController pushViewController:adminView animated:YES];
    
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
    return [circular_title count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunicationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunicationViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.title.text = [circular_title objectAtIndex:indexPath.row];
    cell.date.text = [circular_date objectAtIndex:indexPath.row];
    cell.detailView.text = [circular_details objectAtIndex:indexPath.row];
    
    cell.circularType.text = [circular_Type objectAtIndex:indexPath.row];
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
    NSString *title = [circular_title objectAtIndex:indexPath.row];
    NSString *date = [circular_date objectAtIndex:indexPath.row];
    NSString *details = [circular_details objectAtIndex:indexPath.row];
    NSString *type = [circular_Type objectAtIndex:indexPath.row];

    [[NSUserDefaults standardUserDefaults]setObject:title forKey:@"title_Key"];
    
    [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"date_Key"];
    
    [[NSUserDefaults standardUserDefaults]setObject:details forKey:@"details_Key"];
    
    [[NSUserDefaults standardUserDefaults]setObject:type forKey:@"type_Key"];

    [self performSegueWithIdentifier:@"to_comunication" sender:self];
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
