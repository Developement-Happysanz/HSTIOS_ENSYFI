//
//  AdminStudentInfo.m
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminStudentInfo.h"

@interface AdminStudentInfo ()
{
    AppDelegate *appDel;
    
    NSMutableArray *name;
    NSMutableArray *registered_id;
    NSMutableArray *admission_no;
    NSMutableArray *class_id;

}
@end

@implementation AdminStudentInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    name = [[NSMutableArray alloc]init];
    registered_id = [[NSMutableArray alloc]init];
    admission_no = [[NSMutableArray alloc]init];
    class_id = [[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.parentId forKey:@"parent_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_student_details = @"/apiadmin/get_parent_student_list/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_student_details, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *studentData = [responseObject valueForKey:@"data"];
         
         if ([msg isEqualToString:@"studentdetailsfound"])
         {
             
             for (int i = 0; i < [studentData count]; i++)
             {
                 NSDictionary *dict = [studentData objectAtIndex:i];
                 
                 NSString *strname = [dict objectForKey:@"name"];
                 NSString *strregistered_id = [dict objectForKey:@"enroll_id"];
                 NSString *stradmission_no = [dict objectForKey:@"admisn_no"];
                 NSString *straclass_id = [dict objectForKey:@"class_id"];

                 [name addObject:strname];
                 [registered_id addObject:strregistered_id];
                 [admission_no addObject:stradmission_no];
                 [class_id addObject:straclass_id];

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    AdminStudentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.rollNumber.text = [NSString stringWithFormat:@"%li",indexPath.row + 1];
    //[registered_id objectAtIndex:indexPath.row];
    cell.studentName.text = [name objectAtIndex:indexPath.row];
    cell.admissionNumber.text = [admission_no objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminStudentInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger index = [name indexOfObject:cell.studentName.text];
    
    appDel.student_id = registered_id [index];
    
    NSUInteger index_classid = [name indexOfObject:cell.studentName.text];

    appDel.class_id = class_id[index_classid];
    
    [self performSegueWithIdentifier:@"to_adminStudentProfile" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 49;
        
    }
    else
    {
        return 49;
    }
}
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
