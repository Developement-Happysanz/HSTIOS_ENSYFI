//
//  TeacherExamViewController.m
//  EducationApp
//
//  Created by HappySanz on 10/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherExamViewController.h"

@interface TeacherExamViewController ()
{
    NSMutableArray *classNameArr;
    NSMutableArray *subjectNameArr;
    NSMutableArray *subject_id_Arr;

    NSMutableArray *exam_id;
    NSMutableArray *exam_name;
    NSMutableArray *fromdate;
    NSMutableArray *todate;
    NSMutableArray *markstatus;
    NSMutableArray *isinternal;
    
    NSArray *docPaths;
    NSString *documentsDir;
    NSString *dbPath;
    FMDatabase *database;
    FMResultSet *rs;
}
@end

@implementation TeacherExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    classNameArr = [[NSMutableArray alloc]init];
    subjectNameArr = [[NSMutableArray alloc]init];    
    subject_id_Arr = [[NSMutableArray alloc]init];
    exam_id = [[NSMutableArray alloc]init];
    exam_name = [[NSMutableArray alloc]init];
    fromdate = [[NSMutableArray alloc]init];
    todate = [[NSMutableArray alloc]init];
    markstatus = [[NSMutableArray alloc]init];
    isinternal = [[NSMutableArray alloc]init];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebar setTarget: self.revealViewController];
        [self.sidebar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _classSectionOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classSectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classSectionOtlet.layer.borderWidth = 1.0f;
    [_classSectionOtlet.layer setCornerRadius:10.0f];
    
    _subjectOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _subjectOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _subjectOtlet.layer.borderWidth = 1.0f;
    [_subjectOtlet.layer setCornerRadius:10.0f];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT DISTINCT (class_section) From table_create_teacher_student_details"];
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
    self.tableView.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_resultKey"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exam_name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherExamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.title.text = [exam_name objectAtIndex:indexPath.row];
    NSString *strdate = [NSString stringWithFormat:@"%@  -  %@",[fromdate objectAtIndex:indexPath.row],[todate objectAtIndex:indexPath.row]];
    cell.fromdate.text = strdate;

    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *strexam_id;
    NSString *endDate;
    NSString *strmark_status;
    NSString *strisinternal;
    NSString *strsubject_id;
    NSString *str_exam_name;
    NSString *str_from_date;
    NSString *str_end_date;

    NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
    NSString *subject_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_resultKey"];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    rs = [database executeQuery:@"Select distinct subject_id from table_create_teacher_handling_subjects where class_master_id = ? and subject_name =? ",class_id,subject_name];
    
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"subject_id :%@",[rs stringForColumn:@"subject_id"]);
            strsubject_id = [rs stringForColumn:@"subject_id"];
        }
    }
    [database close];
    
    strexam_id = [exam_id objectAtIndex:indexPath.row];
    endDate = [todate objectAtIndex:indexPath.row];
    str_exam_name = [exam_name objectAtIndex:indexPath.row];
    str_from_date = [fromdate objectAtIndex:indexPath.row];
    str_end_date = [todate objectAtIndex:indexPath.row];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select distinct MarkStatus from table_create_exams_of_the_class where classmaster_id = ? and exam_id = ?",class_id,strexam_id];
    if(rs)
    {
        while ([rs next])
        {
            strmark_status = [rs stringForColumn:@"MarkStatus"];
        }
    }
    [database close];

    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select distinct is_internal_external from table_create_exams_details where classmaster_id = ? and exam_name = ?",class_id,str_exam_name];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"is_internal_external :%@",[rs stringForColumn:@"is_internal_external"]);
            strisinternal = [rs stringForColumn:@"is_internal_external"];
        }
    }    
    [database close];
    
    [[NSUserDefaults standardUserDefaults]setObject:strexam_id forKey:@"exam_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strmark_status forKey:@"mark_status_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strisinternal forKey:@"isinternal_key"];
    [[NSUserDefaults standardUserDefaults]setObject:strsubject_id forKey:@"exam_subject_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:str_exam_name forKey:@"exam_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:str_from_date forKey:@"from_date_key"];
    [[NSUserDefaults standardUserDefaults]setObject:str_end_date forKey:@"end_date_key"];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherExamDetailTableController *teacherExamDetailTableController = (TeacherExamDetailTableController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamDetailTableController"];
    [self.navigationController pushViewController:teacherExamDetailTableController animated:YES];
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

- (IBAction)classSectionBtn:(id)sender
{
    CGFloat f;
    [[NSUserDefaults standardUserDefaults]setObject:@"class" forKey:@"Button_title_key"];

    if(dropDown == nil)
    {
        if (classNameArr.count > 2)
        {
            f = 200;
        }
        else
        {
           f = 100;
        }
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :classNameArr :nil :@"down"];
        [[NSUserDefaults standardUserDefaults]setObject:@"teacher_attendance" forKey:@"teacher_attendanceKey"];
        [[NSUserDefaults standardUserDefaults]setObject:@"class_section" forKey:@"categoery_key"];
        [_subjectOtlet setTitle:@"Subject" forState:UIControlStateNormal];
        self.tableView.hidden = YES;
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
    NSString *strsubject_id;
    dropDown = nil;
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"categoery_key"];
    if ([str isEqualToString:@"class_section"])
    {
        NSString *class_id;
        NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select distinct class_id from table_create_teacher_student_details where class_section= ? ",db_class_name];
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"Class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id = [rs stringForColumn:@"class_id"];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
        [database close];
    }
    else
    {
        NSString *check_key = [[NSUserDefaults standardUserDefaults]objectForKey:@"check_key"];
        NSString *subject_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_resultKey"];
        if (![check_key isEqualToString:@"NO"])
        {
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir  stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select distinct subject_id from table_create_teacher_handling_subjects where subject_name = ?",subject_name];
            if(rs)
            {
                while ([rs next])
                {
                    strsubject_id = [rs stringForColumn:@"subject_id"];
                }
                
            }
            [[NSUserDefaults standardUserDefaults]setObject:strsubject_id forKey:@"subject_id_exam_marks"];
            [database close];
            
            [exam_id removeAllObjects];
            [exam_name removeAllObjects];
            [fromdate removeAllObjects];
            [todate removeAllObjects];
            [markstatus removeAllObjects];
            [isinternal removeAllObjects];
            
            NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select distinct exam_id,exam_name,Fromdate,Todate,MarkStatus,is_internal_external from table_create_exams_of_the_class where classmaster_id = ? ",class_id];
            if(rs)
            {
                while ([rs next])
                {
                    NSLog(@"exam_name :%@",[rs stringForColumn:@"exam_name"]);
                    NSString *strexam_id = [rs stringForColumn:@"exam_id"];
                    NSString *strexam_name = [rs stringForColumn:@"exam_name"];
                    NSString *strFromdate = [rs stringForColumn:@"Fromdate"];
                    NSString *strTodate = [rs stringForColumn:@"Todate"];
                    NSString *strMarkstatus = [rs stringForColumn:@"Markstatus"];
                    NSString *stris_internal_external = [rs stringForColumn:@"is_internal_external"];
                    
                    [exam_id addObject:strexam_id];
                    [exam_name addObject:strexam_name];
                    [fromdate addObject:strFromdate];
                    [todate addObject:strTodate];
                    [markstatus addObject:strMarkstatus];
                    [isinternal addObject:stris_internal_external];
                    
                }
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            }
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];;
            [database close];
        }
        else
        {
            self.tableView.hidden = YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"check_key"];
        }
    }
}
- (IBAction)subjectBtn:(id)sender
{
    CGFloat f;
     NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
    if (![str isEqualToString:@""])
    {
        if(dropDown == nil)
        {
            NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir  stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select distinct subject_name,subject_id from table_create_teacher_handling_subjects where class_master_id = ? ",class_id];
            if(rs)
            {
                [subjectNameArr removeAllObjects];
                [subject_id_Arr removeAllObjects];
                while ([rs next])
                {
                    NSString *strSubject_name = [rs stringForColumn:@"subject_name"];
                    NSString *strsubject_id = [rs stringForColumn:@"subject_id"];
                    [subjectNameArr addObject:strSubject_name];
                    [subject_id_Arr addObject:strsubject_id];
                }
            }
            [database close];
            if (subjectNameArr.count > 2)
            {
               f = 200;
            }
            else
            {
                f = 100;
            }
            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :subjectNameArr :nil :@"down"];
            [[NSUserDefaults standardUserDefaults]setObject:@"subject_name" forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:@"subject" forKey:@"categoery_key"];
            dropDown.delegate = self;
        }
        else
        {
            [dropDown hideDropDown:sender];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"check_key"];
            [self rel];
        }
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select the class"
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
@end
