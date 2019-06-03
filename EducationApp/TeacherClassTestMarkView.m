//
//  TeacherClassTestMarkView.m
//  EducationApp
//
//  Created by HappySanz on 07/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherClassTestMarkView.h"

@interface TeacherClassTestMarkView ()
{
    AppDelegate *appDel;
    
    NSMutableArray *classNameArr;
    NSMutableArray *subjectNameArr;
    NSString *class_id;
    NSString *hw_type_res;
    NSString *dateString;
    NSInteger lastInserted_id;

}

@end

@implementation TeacherClassTestMarkView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    classNameArr = [[NSMutableArray alloc]init];
    subjectNameArr = [[NSMutableArray alloc]init];
    
    _classSectionOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classSectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classSectionOtlet.layer.borderWidth = 1.0f;
    [_classSectionOtlet.layer setCornerRadius:10.0f];
    
    _subjectOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _subjectOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _subjectOtlet.layer.borderWidth = 1.0f;
    [_subjectOtlet.layer setCornerRadius:10.0f];
    
    _submitOtlet.layer.borderWidth = 1.0f;
    [_submitOtlet.layer setCornerRadius:10.0f];
    
    _topicTxtView.delegate = self;
    _detailtextView.delegate = self;
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    self.dateTextfld.text = dateString;
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.dateTextfld setInputView:datePicker];
    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(ShowsCancelButton)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:cancelBtn,space,doneBtn, nil]];
    [self.dateTextfld setInputAccessoryView:toolBar];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *rs = [database executeQuery:@"SELECT DISTINCT (class_section) From table_create_teacher_student_details"];
        
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"Class_Section :%@",[rs stringForColumn:@"class_section"]);
            NSString *class_section = [rs stringForColumn:@"class_section"];
            [classNameArr addObject:class_section];
        }
    }
    [database close];
    hw_type_res = @"HT";
    self.subjectNameLabel.text = @"Subject";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_resultKey"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"subject_name_resultKey"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_resultKey"];

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
}
//-(void)dismissKeyboard
//{
//    [_topicTxtView resignFirstResponder];
//    [_detailtextView resignFirstResponder];
//}
-(void)ShowSelectedDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.dateTextfld.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.dateTextfld resignFirstResponder];
}
-(void)ShowsCancelButton
{
    [datePicker removeFromSuperview];
    [self.dateTextfld resignFirstResponder];
    [toolBar removeFromSuperview];
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,610);
    [self.topicTxtView setContentOffset:CGPointZero animated:NO];
    [self.detailtextView setContentOffset:CGPointZero animated:NO];
}
- (void)didReceiveMemoryWarning
{
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

- (IBAction)classSectionBtn:(id)sender
{
    if(dropDown == nil)
    {
        CGFloat f = 100;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :classNameArr :nil :@"down"];
        [_subjectOtlet setTitle:@"Subject" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]setObject:@"teacher_attendance" forKey:@"teacher_attendanceKey"];
        [[NSUserDefaults standardUserDefaults]setObject:@"class_section" forKey:@"categoery_key"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}
-(void)rel
{
    dropDown = nil;
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_btn_key"];
    if ([str isEqualToString:@"subject_btn"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"subject_btn_key"];
        if ((![subjectNameArr count]) == 0)
        {
            NSString *subject_name_res = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_resultKey"];
            self.subjectNameLabel.text = subject_name_res;
        }
   }
}
- (IBAction)subjectBtn:(id)sender
{
    NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
    if (![db_class_name isEqualToString:@""])
    {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        FMResultSet *rs = [database executeQuery:@"Select distinct class_id from table_create_teacher_student_details where class_section = ?",db_class_name];
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"Class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id = [rs stringForColumn:@"class_id"];
            }
        }
        [database close];
        NSArray *subjectNamedocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *subjectNamedocumentsDir = [subjectNamedocPaths objectAtIndex:0];
        NSString *subjectNamedbPath = [subjectNamedocumentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *subjectNamedatabase = [FMDatabase databaseWithPath:subjectNamedbPath];
        [subjectNamedatabase open];
        FMResultSet *subjectNamers = [subjectNamedatabase executeQuery:@"Select distinct subject_name from table_create_teacher_handling_subjects where class_master_id = ? ",class_id];
        [subjectNameArr removeAllObjects];
        
        if(subjectNamers)
        {
            while ([subjectNamers next])
            {
                NSLog(@"subject_name :%@",[subjectNamers stringForColumn:@"subject_name"]);
                NSString *strSubject_name = [subjectNamers stringForColumn:@"subject_name"];
                [subjectNameArr addObject:strSubject_name];
            }
        }
        
        [subjectNamedatabase close];
        
        if ((![subjectNameArr count]) == 0)
        {
            if(dropDown == nil)
            {
                CGFloat f = 100;
                dropDown = [[NIDropDown alloc]showDropDown:sender :&f :subjectNameArr :nil :@"down"];
                [[NSUserDefaults standardUserDefaults]setObject:@"subject_name" forKey:@"subject_name_key"];
                [[NSUserDefaults standardUserDefaults]setObject:@"subject_btn" forKey:@"subject_btn_key"];
                dropDown.delegate = self;
            }
            else
            {
                [dropDown hideDropDown:sender];
                [self rel];
            }
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Subject not found"
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
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please select the Class"
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
- (IBAction)segmentBtn:(id)sender
{
    if (_segmentOtlet.selectedSegmentIndex == 0)
    {
        self.typeLabel.text = @"Test Date :";
        hw_type_res = @"HT";
    }
    else
    {
        self.typeLabel.text = @"Homework Submission Date :";
        hw_type_res = @"HW";
    }
}
- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitBtn:(id)sender
{
    NSString *sub_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_resultKey"];
    
    NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];


    if ([self.topicTxtView.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Enter Valid details"
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
    else if([self.detailtextView.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Enter Valid details"
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
    else if([db_class_name isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"please select the class"
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
    else if([sub_name isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"please select the subject"
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
    else
    {
        if ([hw_type_res isEqualToString:@"HT"])
        {
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormat stringFromDate:today];
            NSLog(@"date: %@", dateString);
            NSString *strsubject_id;
            NSArray *subjectNamedocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *subjectNamedocumentsDir = [subjectNamedocPaths objectAtIndex:0];
            NSString *subjectNamedbPath = [subjectNamedocumentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            FMDatabase *subjectNamedatabase = [FMDatabase databaseWithPath:subjectNamedbPath];
            [subjectNamedatabase open];
            FMResultSet *subjectNamers = [subjectNamedatabase executeQuery:@"Select distinct subject_id from table_create_teacher_handling_subjects where subject_name = ? ",sub_name];
            [subjectNameArr removeAllObjects];
            if(subjectNamers)
            {
                while ([subjectNamers next])
                {
                    NSLog(@"subject_id :%@",[subjectNamers stringForColumn:@"subject_id"]);
                    strsubject_id = [subjectNamers stringForColumn:@"subject_id"];
                }
            }
            [subjectNamedatabase close];

            NSString *yearId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Year_Id_key"];
            NSString *strteacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"strteacher_id_key"];
            NSString *hw_type = hw_type_res;
            NSString *subject_id = strsubject_id;
            
            appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [docPaths objectAtIndex:0];
            NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            
            BOOL isInserted=[database executeUpdate:@"INSERT INTO table_create_homework_class_test (server_hw_id,year_id,class_id,teacher_id,hw_type,subject_id,subject_name,title,test_date,due_date,hw_details,status,mark_status,created_by,created_at,updated_by,updated_at,sync_status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",@"",yearId,class_id,strteacher_id,hw_type,subject_id,sub_name,self.topicTxtView.text,self.dateTextfld.text,@"",self.detailtextView.text,@"",@"",appDel.user_id,dateString,appDel.user_id,dateString,@"NS"];
            lastInserted_id = [database lastInsertRowId];
            NSLog(@"%ld",(long)lastInserted_id);
            NSString *str_lastInserted_id = [NSString stringWithFormat:@"%d",(int)lastInserted_id];
            [[NSUserDefaults standardUserDefaults]setObject:str_lastInserted_id forKey:@"lastId_classTest"];
            [database close];
            
            if(isInserted)
            {
                NSLog(@"Inserted Successfully in table_create_homework_class_test ");
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                TeacherClasstestHomeWorkView *teacherClasstestHomeWorkView = (TeacherClasstestHomeWorkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestHomeWorkView"];
                [self.navigationController pushViewController:teacherClasstestHomeWorkView animated:YES];
                
            }
            else
            {
                NSLog(@"Error occured while inserting");
            }
        }
        else
        {
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormat stringFromDate:today];
            NSLog(@"date: %@", dateString);
            
            NSString *strsubject_id;
            NSString *sub_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_resultKey"];
            NSArray *subjectNamedocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *subjectNamedocumentsDir = [subjectNamedocPaths objectAtIndex:0];
            NSString *subjectNamedbPath = [subjectNamedocumentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            
            FMDatabase *subjectNamedatabase = [FMDatabase databaseWithPath:subjectNamedbPath];
            [subjectNamedatabase open];
            FMResultSet *subjectNamers = [subjectNamedatabase executeQuery:@"Select distinct subject_id from table_create_teacher_handling_subjects where subject_name = ? ",sub_name];
            [subjectNameArr removeAllObjects];
            if(subjectNamers)
            {
                while ([subjectNamers next])
                {
                    NSLog(@"subject_id :%@",[subjectNamers stringForColumn:@"subject_id"]);
                    strsubject_id = [subjectNamers stringForColumn:@"subject_id"];
                }
            }
            [subjectNamedatabase close];
            
            NSString *yearId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Year_Id_key"];
            NSString *strteacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"strteacher_id_key"];
            NSString *hw_type = hw_type_res;
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [docPaths objectAtIndex:0];
            NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            
            BOOL isInserted=[database executeUpdate:@"INSERT INTO table_create_homework_class_test (server_hw_id,year_id,class_id,teacher_id,hw_type,subject_id,subject_name,title,test_date,due_date,hw_details,status,mark_status,created_by,created_at,updated_by,updated_at,sync_status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",@"",yearId,class_id,strteacher_id,hw_type,strsubject_id,sub_name,self.topicTxtView.text,@"",self.dateTextfld.text,self.detailtextView.text,@"",@"0",appDel.user_id,dateString,appDel.user_id,dateString,@"NS"];
            lastInserted_id = [database lastInsertRowId];
            NSLog(@"%ld",(long)lastInserted_id);
            NSString *str_lastInserted_id = [NSString stringWithFormat:@"%d",(int)lastInserted_id];
            [[NSUserDefaults standardUserDefaults]setObject:str_lastInserted_id forKey:@"lastId_classTest"];
            [database close];
            
            if(isInserted)
            {
                NSLog(@"Inserted Successfully in table_create_exams_of_the_class ");
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                TeacherClasstestHomeWorkView *teacherClasstestHomeWorkView = (TeacherClasstestHomeWorkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestHomeWorkView"];
                [self.navigationController pushViewController:teacherClasstestHomeWorkView animated:YES];
            }
            else
            {
                NSLog(@"Error occured while inserting");
            }
        }
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _scrollView.frame = CGRectMake(_scrollView.frame.origin.x,0,_scrollView.frame.size.width,_scrollView.frame.size.height);
        [UIView commitAnimations];
        return NO;
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _scrollView.frame = CGRectMake(_scrollView.frame.origin.x,-160,_scrollView.frame.size.width,_scrollView.frame.size.height);
    [UIView commitAnimations];
}
@end
