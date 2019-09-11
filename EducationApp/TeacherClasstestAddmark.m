 //
//  TeacherClasstestAddmark.m
//  EducationApp
//
//  Created by HappySanz on 09/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//
#import "TeacherClasstestAddmark.h"
@interface TeacherClasstestAddmark ()
{
    AppDelegate *appDel;
    NSMutableArray *name;
    NSMutableArray *marks;
    NSMutableArray *enroll_id;
    NSInteger lastInserted_id;
    NSString *lastID;
    NSArray *stat;
}
@end
@implementation TeacherClasstestAddmark
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.topicLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTestTopic_key"];
    self.testDateLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTest_date_key"];
    name = [[NSMutableArray alloc]init];
    marks = [[NSMutableArray alloc]init];
    enroll_id = [[NSMutableArray alloc]init];
    stat = @[@"1"];
    NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *rs = [database executeQuery:@"Select distinct name,enroll_id from table_create_teacher_student_details where class_id = ? order by name asc",class_id];
    [name insertObject:@"select" atIndex:0];
    [enroll_id insertObject:@"select" atIndex:0];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"name :%@",[rs stringForColumn:@"name"]);
            NSString *str_name = [rs stringForColumn:@"name"];
            NSString *str_enroll_id = [rs stringForColumn:@"enroll_id"];
            [name addObject:str_name];
            [enroll_id addObject:str_enroll_id];
        }
        [self.tableView reloadData];
    }
    [database close];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"textfld_key"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    if(indexPath.row == 0)
    {
        TeacherClasstestAddMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        return cell;
    }
    else
    {
        TeacherClasstestAddMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        cell.markTextfld.delegate = self;
        cell.markTextfld.tag = 1;
        cell.slNum.text = [NSString stringWithFormat:@"%li", indexPath.row +0];
        cell.studentName.text = [name objectAtIndex:indexPath.row];
        return cell;
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
- (IBAction)saveBtn:(id)sender
{
    TeacherClasstestAddMarkCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"dynamic"];
    cell.markTextfld.tag = 1;
    [[self view] endEditing:YES];
    if ([name count] == [marks count])
    {
        [name removeObjectAtIndex:0];
        [marks removeObjectAtIndex:0];
        [enroll_id removeObjectAtIndex:0];
        
        if (![marks containsObject:@"0"])
        {
            for (int i = 0;i < [enroll_id count]; i++)
            {
                NSString *strmarks = [marks objectAtIndex:i];
                NSString *strenroll_id = [enroll_id objectAtIndex:i];
                
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDate *today = [NSDate date];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSString *dateString = [dateFormat stringFromDate:today];
                NSLog(@"date: %@", dateString);
                NSString *str_hw_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"localid_key"];
                NSString *server_hw_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"server_hw_id_key"];
                NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDir = [docPaths objectAtIndex:0];
                NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
                [database open];
                BOOL isInserted = [database executeUpdate:@"INSERT INTO table_create_class_test_mark (student_id,local_hw_id,server_hw_id,marks,remarks,status,created_by,created_at,updated_by,updated_at,sync_status) VALUES (?,?,?,?,?,?,?,?,?,?,?)",strenroll_id,str_hw_id,server_hw_id,strmarks,@"Active",@"1",appDel.user_id,dateString,appDel.user_id,dateString,@"NS"];
                lastInserted_id = [database lastInsertRowId];
                lastID = [NSString stringWithFormat:@"%ld",lastInserted_id];
                NSLog(@"%ld",(long)lastInserted_id);
                if(isInserted)
                {
                    NSLog(@"Inserted Successfully in table_create_class_test_mark");
                    [self UpdateMarkStatus];
                    UIAlertController *alert= [UIAlertController
                                               alertControllerWithTitle:@"ENSIFY"
                                               message:@"marks added succesfully"
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
                    NSLog(@"Error occured while");
                }
                [database close];
            }
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSIFY"
                                       message:@"Enter marks for All students"
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
}
-(void)UpdateMarkStatus
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL isInserted = [database executeUpdate:@"UPDATE table_create_homework_class_test SET mark_status = ? WHERE id = ?",@"1",lastID];
    if(isInserted)
    {
        NSLog(@"Update Successfully in table_create_homework_class_test");
    }
    else
    {
        NSLog(@"Error occured while");
    }
    [database close];
}
- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField.tag == 1)
    {
        [theTextField resignFirstResponder];
    }
    
    if ([theTextField.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        TeacherClasstestAddMarkCell *cell = (TeacherClasstestAddMarkCell*)theTextField.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
    
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGPoint pointInTable = [textField.superview convertPoint:textField.frame.origin toView:self.tableView];
    CGPoint contentOffset = self.tableView.contentOffset;
    contentOffset.y = (pointInTable.y - textField.inputAccessoryView.frame.size.height);
    NSLog(@"contentOffset is: %@", NSStringFromCGPoint(contentOffset));
    [self.tableView setContentOffset:contentOffset animated:YES];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSString *str = [textField text];
    
    if (marks.count == 0)
    {
        for (int i = 0; i < [name count]; i++)
        {
            [marks addObject:@"0"];
        }
    }
    if (textField.tag == 1)
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:str];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (valid)
        {
            NSInteger integer = [str intValue];
            if (integer > 100)
            {
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"ENSIFY"
                                           message:@"Enter valid marks for students 0 to 100"
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
                TeacherClasstestAddMarkCell *cell = (TeacherClasstestAddMarkCell*)textField.superview.superview;
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                NSInteger row = indexPath.row;
                [marks removeObjectAtIndex:row];
                [marks insertObject:[NSString stringWithFormat:@"%ld",(long)integer] atIndex:row];
            }
        }
        else
        {
            if ([str isEqualToString:@"AB"])
            {
                TeacherClasstestAddMarkCell *cell = (TeacherClasstestAddMarkCell*)textField.superview.superview;
                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                NSInteger row = indexPath.row;
                [marks removeObjectAtIndex:row];
                [marks insertObject:[NSString stringWithFormat:@"%@",str] atIndex:row];
            }
            else
            {
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"ENSIFY"
                                           message:@"Enter valid character as 'AB' for students"
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
       
    }
      return YES;
}
@end
