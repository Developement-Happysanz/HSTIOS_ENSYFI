
//
//  ExamsViewController.m
//  EducationApp
//
//  Created by HappySanz on 15/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ExamsViewController.h"

@interface ExamsViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *examID;
    NSMutableArray *examDetails;
    NSMutableArray *internal_external;

    NSMutableArray *MarkStatus;
    NSMutableArray *Fromdate;
    NSMutableArray *Todate;

}
@end

@implementation ExamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    
    if ([stat_user_type isEqualToString:@"admin"])
    {
        
//     [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
        
//        self.navigationItem.title = @"EXAM";
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
        imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = backButton;
        
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

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
    }
    examID = [[NSMutableArray alloc]init];
    examDetails = [[NSMutableArray alloc]init];
    internal_external = [[NSMutableArray alloc]init];

    Fromdate = [[NSMutableArray alloc]init];
    Todate = [[NSMutableArray alloc]init];
    MarkStatus = [[NSMutableArray alloc]init];


    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forExam = @"/apistudent/disp_Exams/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forExam, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSArray *arr_Exams = [responseObject objectForKey:@"Exams"];
         
         for (int i = 0; i < [arr_Exams count]; i++)
         {
             examID = [arr_Exams valueForKey:@"exam_id"];
             examDetails = [arr_Exams valueForKey:@"exam_name"];
             MarkStatus = [arr_Exams valueForKey:@"MarkStatus"];
             
             
             Fromdate = [arr_Exams valueForKey:@"Fromdate"];
             Todate = [arr_Exams valueForKey:@"Todate"];
             internal_external = [arr_Exams valueForKey:@"is_internal_external"];
             
//             [examID addObject:str_examID];
//             [examDetails addObject:str_examDetails];
//             [MarkStatus addObject:str_MarkStatus];
//             [Fromdate addObject:str_Fromdate];
//             [Todate addObject:str_Todate];
//             [internal_external addObject:str_internal_external];

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
- (IBAction)Back
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
    AdminStudentProfileView *adminStudentProfileView = (AdminStudentProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentProfileView"];
    [self.navigationController pushViewController:adminStudentProfileView animated:YES];
 // ios 6
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [examID count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExamViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExamViewTableViewCell" forIndexPath:indexPath];
    
     //Configure the cell...
    
    cell.examTitleLabel.text = [examDetails objectAtIndex:indexPath.row];
    cell.examid.text = [examID objectAtIndex:indexPath.row];
    
    cell.datelabel.text = [Fromdate objectAtIndex:indexPath.item];
    
    NSLog(@"%@",cell.datelabel.text);
    
    cell.toDateLabel.text = [Todate objectAtIndex:indexPath.item];
    
    NSLog(@"%@",cell.toDateLabel.text);

    
    if ([cell.datelabel.text isEqualToString:@""])
    {
        cell.CalenderImage.hidden = YES;
        cell.seperateLabel.hidden = YES;
    }
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ExamViewTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *MarkStatusStr = [MarkStatus objectAtIndex:indexPath.row];
    NSString *examTitle = selectedCell.examTitleLabel.text;
    NSString *examIDValue = selectedCell.examid.text;
    appDel.exam_id = examIDValue;
    NSUInteger index = [examDetails indexOfObject:examTitle];
    NSString *str = internal_external[index];
    
    [[NSUserDefaults standardUserDefaults]setObject:examTitle forKey:@"examTitleKey"];
    [[NSUserDefaults standardUserDefaults]setObject:examIDValue forKey:@"examIDValueKey"];
    
    if ([MarkStatusStr isEqualToString:@"0"])
    {
        [self performSegueWithIdentifier:@"toExamDetailView" sender:self];
    }
    else if([str isEqualToString:@"0"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamTestMarkView *examTestMarkView = (ExamTestMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"ExamTestMarkView"];
        [self.navigationController pushViewController:examTestMarkView animated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"toExamDetailMarkView" sender:self];
    }
    NSLog(@"%@%@",examTitle,examIDValue);
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
