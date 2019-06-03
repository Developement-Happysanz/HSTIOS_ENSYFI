//
//  AdminResultStudentListView.m
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminResultStudentListView.h"

@interface AdminResultStudentListView ()
{
    AppDelegate *appDel;
    
    NSMutableArray *admisn_no;
    NSMutableArray *admisn_year;
    NSMutableArray *class_id;
    NSMutableArray *enroll_id;
    NSMutableArray *name;
    NSMutableArray *sex;

}
@end

@implementation AdminResultStudentListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    admisn_no = [[NSMutableArray alloc]init];
    admisn_year = [[NSMutableArray alloc]init];
    class_id = [[NSMutableArray alloc]init];
    enroll_id = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    sex = [[NSMutableArray alloc]init];

    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.section_id forKey:@"section_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_exam_details_class = @"/apiadmin/get_all_students_in_classes/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_exam_details_class, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *data = [responseObject objectForKey:@"data"];
         
         
         if ([msg isEqualToString:@"success"])
         {
             for (int i = 0;i < [data count] ; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *stradmisn_no = [dict objectForKey:@"admisn_no"];
                 NSString *stradmisn_year = [dict objectForKey:@"admisn_year"];
                 NSString *strclass_id = [dict objectForKey:@"class_id"];
                 NSString *strenroll_id = [dict objectForKey:@"enroll_id"];
                 NSString *strname = [dict objectForKey:@"name"];
                 NSString *strsex = [dict objectForKey:@"sex"];
                 
                 [admisn_no addObject:stradmisn_no];
                 [admisn_year addObject:stradmisn_year];
                 [class_id addObject:strclass_id];
                 [enroll_id addObject:strenroll_id];
                 [name addObject:strname];
                 [sex addObject:strsex];
                 
             }
             
             self.tableView.hidden = NO;
             
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
    AdminResultStudentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.idLabel.text = [NSString stringWithFormat:@"%li",indexPath.row + 1];
    //[enroll_id objectAtIndex:indexPath.row];
    cell.studentName.text = [name objectAtIndex:indexPath.row];
    cell.admisonNumber.text = [admisn_no objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    AdminResultStudentListCell *adminResultStudentListCell = [tableView cellForRowAtIndexPath:indexPath];
    
    [[NSUserDefaults standardUserDefaults]setObject:adminResultStudentListCell.idLabel.text forKey:@"examIDValueKey"];
    
    NSUInteger index = [name indexOfObject:adminResultStudentListCell.studentName.text];
    
    appDel.student_id = enroll_id[index];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    
    NSString *statusstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"is_internal_external_key"];
    
    if ([statusstr isEqualToString:@"0"])
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"adminResult" forKey:@"adminResult_Key"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamTestMarkView *examTestMarkView = (ExamTestMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"ExamTestMarkView"];
        [self.navigationController pushViewController:examTestMarkView animated:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"adminResult" forKey:@"adminResult_Key"];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamMarkViewController *examMarkViewController = (ExamMarkViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamMarkViewController"];
        [self.navigationController pushViewController:examMarkViewController animated:YES];
    }
    
    
    
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
