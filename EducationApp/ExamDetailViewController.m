//
//  ExamDetailViewController.m
//  EducationApp
//
//  Created by HappySanz on 17/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ExamDetailViewController.h"

@interface ExamDetailViewController ()
{
    AppDelegate *appDel;
    NSString *markstatus;
    NSArray *examNameArray;
    NSArray *exam_Date;
    NSArray *times;
    
    NSMutableArray *staticArray;
}
@end

@implementation ExamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    NSString *classMaster_id_Key = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassMaster_id_Key"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.exam_id forKey:@"exam_id"];

    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forExam = @"/apistudent/disp_Examdetails";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forExam, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSArray *arrray_Objects = [responseObject objectForKey:@"examDetails"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"View Exam Details"])
         {
             markstatus = [responseObject objectForKey:@"markStatus"];
             NSMutableArray *ArraySubject = [NSMutableArray array];
             ;
             
             [ArraySubject insertObject:@"Select" atIndex:0];
             
             NSArray *subject = [arrray_Objects valueForKey:@"subject_name"];
             
             
             examNameArray = [ArraySubject arrayByAddingObjectsFromArray:subject];
             
             NSMutableArray *Arraydate = [NSMutableArray array];
             ;
             
             [Arraydate insertObject:@"Select" atIndex:0];
             
             NSArray *date = [arrray_Objects valueForKey:@"exam_date"];
             
             exam_Date = [Arraydate arrayByAddingObjectsFromArray:date];

             
//             exam_Date = [arrray_Objects valueForKey:@"exam_date"];
             
//             times = [arrray_Objects valueForKey:@"times"];
             
             NSMutableArray *ArrayTime = [NSMutableArray array];
             ;
             
             [ArrayTime insertObject:@"Select" atIndex:0];
             
             NSArray *time = [arrray_Objects valueForKey:@"times"];
             
             times = [ArrayTime arrayByAddingObjectsFromArray:time];
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"ENSYFI"
                                        message:@"Exams Not Found"
                                        preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
//                                      [self dismissViewControllerAnimated:YES completion:nil];
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
   
    return examNameArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row == 0)
    {

        ExamDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        cell.dateLabel.text = [staticArray objectAtIndex:indexPath.row];
        return cell;

    }
    else
    {
        ExamDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        
//         Configure the cell...
        
    
        cell.dateLabel.text = [exam_Date objectAtIndex:indexPath.row];
        cell.time.text = [times objectAtIndex:indexPath.row];
        cell.subjectLabel.text = [examNameArray objectAtIndex:indexPath.row];
        
        return cell;

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 39;

    }
    else
    {
        return 49;
    }
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

- (IBAction)backButton:(id)sender
{
    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    NSString *stradminExam = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminExamKey"];
    
    if ([stat_user_type isEqualToString:@"admin"])
    {
        
        if ([stradminExam isEqualToString:@"adminExam"])
        {
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
//                AdminExamViewController *adminView = (AdminExamViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminExamViewController"];
//            [self.navigationController pushViewController:adminView animated:YES];
            
            [self.navigationController popViewControllerAnimated:YES];

        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:Nil];

        }
//        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:Nil];

    }
    
}
@end
