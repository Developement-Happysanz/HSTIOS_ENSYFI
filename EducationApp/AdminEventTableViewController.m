//
//  AdminEventTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 18/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminEventTableViewController.h"

@interface AdminEventTableViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *event_details;
    NSMutableArray *event_name;
    NSMutableArray *event_date;
    NSMutableArray *event_ID;
}
@end

@implementation AdminEventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    event_details = [[NSMutableArray alloc]init];
    event_name = [[NSMutableArray alloc]init];
    event_date = [[NSMutableArray alloc]init];
    event_ID = [[NSMutableArray alloc]init];
    
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
    [parameters setObject:@"1" forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forEvent = @"/apimain/disp_Events/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSArray *arr_Events = [responseObject objectForKey:@"eventDetails"];
         
         event_details= [arr_Events valueForKey:@"event_details"];
         event_name = [arr_Events valueForKey:@"event_name"];
         event_date = [arr_Events valueForKey:@"event_date"];
         event_ID = [arr_Events valueForKey:@"event_id"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [event_name count];
;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminEventTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AdminEventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.eventName.text = [event_name objectAtIndex:indexPath.row];
    cell.eventdate.text = [event_date objectAtIndex:indexPath.row];
    
    
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
    
    AdminEventTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *eventdate = selectedCell.eventdate.text;
    NSString *eventName = selectedCell.eventName.text;
    NSString *discripition = [event_details objectAtIndex:indexPath.row];
    NSString *event_id = [event_ID objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:eventName forKey:@"event_NameKey"];
    
    [[NSUserDefaults standardUserDefaults]setObject:event_id forKey:@"event_idKey"];
    
    [[NSUserDefaults standardUserDefaults]setObject:eventdate forKey:@"eventDateKey"];
    
    [[NSUserDefaults standardUserDefaults]setObject:discripition forKey:@"descripitionKey"];
    
    [self performSegueWithIdentifier:@"admin_event" sender:self];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
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
