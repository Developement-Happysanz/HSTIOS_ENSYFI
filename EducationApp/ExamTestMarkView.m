//
//  ExamTestMarkView.m
//  EducationApp
//
//  Created by HappySanz on 21/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ExamTestMarkView.h"

@interface ExamTestMarkView ()
{
    AppDelegate *appDel;
    NSArray *stat;
    NSMutableArray *subject_name;
    NSMutableArray *total_marks;
    NSMutableArray *total_grade;
    NSMutableArray *stud_name;
    NSString *totalMarksStr;
}
@end

@implementation ExamTestMarkView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    subject_name = [[NSMutableArray alloc]init];
    total_grade = [[NSMutableArray alloc]init];
    total_marks = [[NSMutableArray alloc]init];
    stud_name = [[NSMutableArray alloc]init];

    NSString *login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if([login_type isEqualToString:@"teachers"])
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
            self->totalMarksStr = [responseObject objectForKey:@"totalMarks"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Marks Details"])
             {
                 [self->subject_name removeAllObjects];
                 [self->total_marks removeAllObjects];
                 [self->total_grade removeAllObjects];
                 [self->stud_name removeAllObjects];

                 [self->subject_name insertObject:@"name" atIndex:0];
                 [self->total_marks insertObject:@"name" atIndex:0];
                 [self->total_grade insertObject:@"name" atIndex:0];
                 [self->stud_name insertObject:@"name" atIndex:0];

                 NSArray *marksDetails = [responseObject objectForKey:@"marksDetails"];
                 for (int i = 0; i < [marksDetails count]; i++)
                 {
                     
                     NSDictionary *dictionary_Enrollment = [marksDetails objectAtIndex:i];
                     NSString *sub_name = [dictionary_Enrollment valueForKey:@"subject_name"];
                     NSString *strstud_name = [dictionary_Enrollment valueForKey:@"name"];
                     NSString *tot_marks = [dictionary_Enrollment valueForKey:@"total_marks"];
                     NSString *tot_grade = [dictionary_Enrollment valueForKey:@"total_grade"];
                     
                     [self->subject_name addObject:sub_name];
                     [self->stud_name addObject:strstud_name];
                     [self->total_marks addObject:tot_marks];
                     [self->total_grade addObject:tot_grade];
                 }
                 
                    self.subview.hidden = YES;
                    self.TotalStaLabel.hidden = YES;
                    [self.tableView reloadData];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 self.TotalStaLabel.hidden = YES;
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
            self->totalMarksStr = [responseObject objectForKey:@"totalMarks"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Marks Details"])
             {
                 [self->subject_name removeAllObjects];
                 [self->total_marks removeAllObjects];
                 [self->total_grade removeAllObjects];
                 
                 [self->subject_name insertObject:@"name" atIndex:0];
                 [self->total_marks insertObject:@"name" atIndex:0];
                 [self->total_grade insertObject:@"name" atIndex:0];
                 
                 NSArray *marksDetails = [responseObject objectForKey:@"marksDetails"];
                 
                 for (int i = 0; i < [marksDetails count]; i++)
                 {
                     NSDictionary *dictionary_Enrollment = [marksDetails objectAtIndex:i];
                     NSString *sub_name = [dictionary_Enrollment valueForKey:@"subject_name"];
                     NSString *tot_marks = [dictionary_Enrollment valueForKey:@"total_marks"];
                     NSString *tot_grade = [dictionary_Enrollment valueForKey:@"total_grade"];
                     
                     if (sub_name.length == 0)
                     {
                         [self->subject_name addObject:@""];
                     }
                     else
                     {
                         [self->subject_name addObject:sub_name];
                     }
                     if (tot_marks.length == 0)
                     {
                         [self->total_marks addObject:@""];
                     }
                     else
                     {
                         [self->total_marks addObject:tot_marks];
                     }
                     if (tot_grade.length == 0)
                     {
                         [self->total_grade addObject:@""];
                     }
                     else
                     {
                         [self->total_grade addObject:tot_grade];
                     }
                 }
                     self.subview.hidden = NO;
                     [self.tableView reloadData];
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 self.TotalStaLabel.hidden = YES;
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
    return subject_name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        ExamTestMarkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        NSString *login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
        if([login_type isEqualToString:@"teachers"])
        {
            cell.titleSubjectNameLabel.text = @"Subject Name";
        }
        
        return cell;
    }
    else
    {
        ExamTestMarkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        //Configure the cell...
        NSString *login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
        if([login_type isEqualToString:@"teachers"])
        {
            cell.gradeLabel.text = [total_grade objectAtIndex:indexPath.row];
            NSLog(@"%@",cell.gradeLabel.text);
            cell.markLabel.text = [total_marks objectAtIndex:indexPath.row];
            NSLog(@"%@",cell.markLabel.text);
            cell.subjectLabel.text = [stud_name objectAtIndex:indexPath.row];
        }
        else
        {
            cell.gradeLabel.text = [total_grade objectAtIndex:indexPath.row];
            NSLog(@"%@",cell.gradeLabel.text);
            cell.markLabel.text = [total_marks objectAtIndex:indexPath.row];
            NSLog(@"%@",cell.markLabel.text);
            cell.subjectLabel.text = [subject_name objectAtIndex:indexPath.row];
        }
            [self total];
        
            return cell;
    }
}
-(void)total
{
    self.totalMarks.text =[NSString stringWithFormat:@"%@" ,totalMarksStr];
    if ([self.totalMarks.text  isEqual: @"(null)"])
    {
        self.totalMarks.text = @"-";
    }
}
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
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            ExamsViewController *examsViewController = (ExamsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamsViewController"];
//            [self.navigationController pushViewController:examsViewController animated:YES];
              [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
//           [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([str isEqualToString:@"teachers"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"main" forKey:@"stat_user_type"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherExamDetailTableController *teacherExamDetailTableController = (TeacherExamDetailTableController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamDetailTableController"];
        [self.navigationController pushViewController:teacherExamDetailTableController animated:YES];
    }
    else
    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ExamsViewController *examsViewController = (ExamsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamsViewController"];
//        [self.navigationController pushViewController:examsViewController animated:YES];
          [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
