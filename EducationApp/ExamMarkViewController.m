//
//  ExamMarkViewController.m
//  EducationApp
//
//  Created by HappySanz on 25/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ExamMarkViewController.h"

@interface ExamMarkViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *examName;
    NSArray *examNameArray;
    NSArray *exam_Date;
    NSArray *marks;
    NSNumber *totalMarks;
    NSArray *stat;
    
    NSMutableArray *subject_name;
    NSMutableArray *internal_mark;
    NSMutableArray *internal_grade;
    NSMutableArray *external_mark;
    NSMutableArray *external_grade;
    NSMutableArray *total_marks;
    NSMutableArray *total_grade;

}
@end

@implementation ExamMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    stat = @[@"1"];
    examName = [[NSMutableArray alloc]init];
    
    
    subject_name = [[NSMutableArray alloc]init];
    internal_mark = [[NSMutableArray alloc]init];
    internal_grade = [[NSMutableArray alloc]init];
    external_mark = [[NSMutableArray alloc]init];
    external_grade = [[NSMutableArray alloc]init];
    total_marks = [[NSMutableArray alloc]init];
    total_grade = [[NSMutableArray alloc]init];
    
    NSString *login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    if ([login_type isEqualToString:@"teachers"])
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

        NSString *exam_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"exam_id_key"];
        NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
        NSString *subject_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"exam_subject_id_key"];
        NSString *is_internal = [[NSUserDefaults standardUserDefaults]objectForKey:@"isinternal_key"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:exam_id forKey:@"exam_id"];
        [parameters setObject:class_id forKey:@"class_id"];
        [parameters setObject:subject_id forKey:@"subject_id"];
        [parameters setObject:is_internal forKey:@"is_internal_external"];
        
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forExam = @"/apiteacher/disp_Exammarks/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forExam, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             totalMarks = [responseObject objectForKey:@"totalMarks"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Marks Details"])
             {
                 [subject_name insertObject:@"name" atIndex:0];
                 [internal_mark insertObject:@"name" atIndex:0];
                 [internal_grade insertObject:@"name" atIndex:0];
                 [external_mark insertObject:@"name" atIndex:0];
                 [external_grade insertObject:@"name" atIndex:0];
                 [total_marks insertObject:@"name" atIndex:0];
                 [total_grade insertObject:@"name" atIndex:0];
                 
                 NSArray *marksDetails = [responseObject objectForKey:@"marksDetails"];
                 
                 for (int i = 0; i < [marksDetails count]; i++)
                 {
                     
                     NSDictionary *dictionary_Enrollment = [marksDetails objectAtIndex:i];
                     
                     NSString *name = [dictionary_Enrollment valueForKey:@"name"];
                     NSString *inte_mark = [dictionary_Enrollment valueForKey:@"internal_mark"];
                     NSString *inte_grade = [dictionary_Enrollment valueForKey:@"internal_grade"];
                     NSString *exte_mark = [dictionary_Enrollment valueForKey:@"external_mark"];
                     NSString *exte_grade = [dictionary_Enrollment valueForKey:@"external_grade"];
                     NSString *tot_marks = [dictionary_Enrollment valueForKey:@"total_marks"];
                     NSString *tot_grade = [dictionary_Enrollment valueForKey:@"total_grade"];
                     
                     [subject_name addObject:name];
                     [internal_mark addObject:inte_mark];
                     [internal_grade addObject:inte_grade];
                     [external_mark addObject:exte_mark];
                     [external_grade addObject:exte_grade];
                     [total_marks addObject:tot_marks];
                     [total_grade addObject:tot_grade];
                     
                 }
                 
                 //self.totalLabel.text = [NSString stringWithFormat:@"%@",totalMarks];
                 self.subview.hidden = YES;

                 self.TotalstatLabel.hidden = YES;

                 [self.tableView reloadData];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 self.TotalstatLabel.hidden = YES;
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Marks Not Found"
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
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    
}
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.student_id forKey:@"stud_id"];
        [parameters setObject:appDel.exam_id forKey:@"exam_id"];
        
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forExam = @"/apistudent/disp_Exammarks/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forExam, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             totalMarks = [responseObject objectForKey:@"totalMarks"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Marks Details"])
             {
                 [subject_name insertObject:@"name" atIndex:0];
                 [internal_mark insertObject:@"name" atIndex:0];
                 [internal_grade insertObject:@"name" atIndex:0];
                 [external_mark insertObject:@"name" atIndex:0];
                 [external_grade insertObject:@"name" atIndex:0];
                 [total_marks insertObject:@"name" atIndex:0];
                 [total_grade insertObject:@"name" atIndex:0];
                 
                 NSArray *marksDetails = [responseObject objectForKey:@"marksDetails"];
                 
                 for (int i = 0; i < [marksDetails count]; i++)
                 {
                     
                     NSDictionary *dictionary_Enrollment = [marksDetails objectAtIndex:i];
                     NSString *sub_name = [dictionary_Enrollment valueForKey:@"subject_name"];
                     NSString *inte_mark = [dictionary_Enrollment valueForKey:@"internal_mark"];
                     NSString *inte_grade = [dictionary_Enrollment valueForKey:@"internal_grade"];
                     NSString *exte_mark = [dictionary_Enrollment valueForKey:@"external_mark"];
                     NSString *exte_grade = [dictionary_Enrollment valueForKey:@"external_grade"];
                     NSString *tot_marks = [dictionary_Enrollment valueForKey:@"total_marks"];
                     NSString *tot_grade = [dictionary_Enrollment valueForKey:@"total_grade"];
                     
                     if (sub_name.length == 0)
                     {
                         [subject_name addObject:@""];
                     }
                     else
                     {
                         [subject_name addObject:sub_name];
                     }
                     if (inte_mark.length == 0)
                     {
                         [internal_mark addObject:@""];
                     }
                     else
                     {
                         [internal_mark addObject:inte_mark];
                     }
                     if (inte_grade.length == 0)
                     {
                         [internal_grade addObject:@""];
                     }
                     else
                     {
                         [internal_grade addObject:inte_grade];
                     }
                     if (exte_mark.length == 0)
                     {
                         [external_mark addObject:@""];
                     }
                     else
                     {
                         [external_mark addObject:exte_mark];
                     }
                     if (exte_grade.length == 0)
                     {
                         [external_grade addObject:@""];
                     }
                     else
                     {
                         [external_grade addObject:exte_grade];
                     }
                     if (tot_marks.length == 0)
                     {
                         [total_marks addObject:@""];
                     }
                     else
                     {
                         [total_marks addObject:tot_marks];
                     }
                     if (tot_grade.length == 0)
                     {
                         [total_grade addObject:@""];
                     }
                     else
                     {
                         [total_grade addObject:tot_grade];
                     }
                     
                 }
                 
                 //self.totalLabel.text = [NSString stringWithFormat:@"%@",totalMarks];
                 
                 self.subview.hidden = NO;

                 [self.tableView reloadData];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 self.TotalstatLabel.hidden = YES;
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Marks Not Found"
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
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return subject_name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        
        ExamMarkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        
        NSString *login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
        
        if ([login_type isEqualToString:@"teachers"])
        {
            cell.sub_stu_Name.text = @"Student Name";
        }
        else
        {
            cell.sub_stu_Name.text = @"Subject";

        }
        return cell;
        
    }
    else
    {

        ExamMarkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        
        //         Configure the cell...
        
        cell.subjectLabel.text = [subject_name objectAtIndex:indexPath.row];
        cell.intGrade.text = [internal_grade objectAtIndex:indexPath.row];
        cell.intMark.text = [internal_mark objectAtIndex:indexPath.row];
        cell.extGrade.text = [external_grade objectAtIndex:indexPath.row];
        cell.extMark.text = [external_mark objectAtIndex:indexPath.row];
        cell.totalGrade.text = [total_grade objectAtIndex:indexPath.row];
        cell.totalMark.text = [total_marks objectAtIndex:indexPath.row];
        
        [self total];

        return cell;
        
    }
}
-(void)total
{
    self.totalLabel.text =[NSString stringWithFormat:@"%@" ,totalMarks];

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
- (IBAction)backButton:(id)sender
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    
    NSString *adminStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminResult_Key"];
    
    if ([str isEqualToString:@"admin"])
    {
        
        if ([adminStr isEqualToString:@"adminResult"])
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
            AdminResultStudentListView *adminResultStudentListView = (AdminResultStudentListView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminResultStudentListView"];
                    [self.navigationController pushViewController:adminResultStudentListView animated:YES];
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];

        }
    }
    else if ([str isEqualToString:@"teachers"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"main" forKey:@"stat_user_type"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherExamDetailTableController *teacherExamDetailTableController = (TeacherExamDetailTableController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamDetailTableController"];
        [self.navigationController pushViewController:teacherExamDetailTableController animated:YES];
        
//        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}
@end
