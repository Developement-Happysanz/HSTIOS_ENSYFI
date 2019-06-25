//
//  SyncViewController.m
//  EducationApp
//
//  Created by HappySanz on 23/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SyncViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SyncViewController ()
{
    AppDelegate *appDel;
    NSArray *docPaths;
    NSString *documentsDir;
    NSString *dbPath;
    FMDatabase *database;
    FMResultSet *rs;
    NSString *attendance_lastInserted_id;
    NSString *attendanceHistrory_lastInserted_id;
    NSString *classtest_Homework_lastInserted_id;
    NSString *strcount;
    NSString *strsync_status;
    
    NSMutableArray *classid;
    NSMutableArray *due_date;
    NSMutableArray *hw_details;
    NSMutableArray *hw_id;
    NSMutableArray *hw_type;
    NSMutableArray *mark_status;
    NSMutableArray *subject_id;
    NSMutableArray *subject_name;
    NSMutableArray *test_date;
    NSMutableArray *title;
    
    NSMutableArray *server_at_id;
    NSMutableArray *_id;
    NSMutableArray *ac_year;
    NSMutableArray *class_total;
    NSMutableArray *no_of_present;
    NSMutableArray *no_of_absent;
    NSMutableArray *attendance_period;
    NSMutableArray *created_by;
    NSMutableArray *created_at;
    NSMutableArray *status;
    NSMutableArray *server_attend_id;
    NSMutableArray *attend_id;
    NSMutableArray *student_id;
    NSMutableArray *abs_date;
    NSMutableArray *a_status;
    NSMutableArray *attend_period;
    NSMutableArray *a_val;
    NSMutableArray *a_taken_by;
    NSMutableArray *updated_by;
    NSMutableArray *updated_at;
    NSMutableArray *server_hw_id;
    NSMutableArray *marks;
    NSMutableArray *remarks;
    NSMutableArray *sync_status;
    
    NSMutableArray *exam_id;
    NSMutableArray *internalMark;
    NSMutableArray *internalGrade;
    NSMutableArray *externalMark;
    NSMutableArray *externalGrade;
    NSMutableArray *totalMarks;
    NSMutableArray *totalGrade;
    NSMutableArray *techer_id;
    NSMutableArray *is_internals_externals;
}
@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    classid = [[NSMutableArray alloc]init];
    due_date = [[NSMutableArray alloc]init];
    hw_details = [[NSMutableArray alloc]init];
    hw_id = [[NSMutableArray alloc]init];
    hw_type = [[NSMutableArray alloc]init];
    mark_status = [[NSMutableArray alloc]init];
    subject_id = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    test_date = [[NSMutableArray alloc]init];
    title = [[NSMutableArray alloc]init];
    
    
    server_at_id = [[NSMutableArray alloc]init];
    _id = [[NSMutableArray alloc]init];
    ac_year = [[NSMutableArray alloc]init];
    class_total = [[NSMutableArray alloc]init];
    no_of_present = [[NSMutableArray alloc]init];
    no_of_absent = [[NSMutableArray alloc]init];
    attendance_period = [[NSMutableArray alloc]init];
    created_by = [[NSMutableArray alloc]init];
    created_at = [[NSMutableArray alloc]init];
    status = [[NSMutableArray alloc]init];
    server_attend_id = [[NSMutableArray alloc]init];
    attend_id = [[NSMutableArray alloc]init];
    student_id = [[NSMutableArray alloc]init];
    a_status = [[NSMutableArray alloc]init];
    attend_period = [[NSMutableArray alloc]init];
    a_val = [[NSMutableArray alloc]init];
    a_taken_by = [[NSMutableArray alloc]init];
    updated_by = [[NSMutableArray alloc]init];
    updated_at = [[NSMutableArray alloc]init];
    server_hw_id = [[NSMutableArray alloc]init];
    marks = [[NSMutableArray alloc]init];
    remarks = [[NSMutableArray alloc]init];
    sync_status = [[NSMutableArray alloc]init];
    abs_date = [[NSMutableArray alloc]init];

    exam_id = [[NSMutableArray alloc]init];
    techer_id = [[NSMutableArray alloc]init];
    internalMark = [[NSMutableArray alloc]init];
    internalGrade = [[NSMutableArray alloc]init];
    externalMark = [[NSMutableArray alloc]init];
    externalGrade = [[NSMutableArray alloc]init];
    totalMarks = [[NSMutableArray alloc]init];
    totalGrade = [[NSMutableArray alloc]init];
    is_internals_externals = [[NSMutableArray alloc]init];


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
    
//    self.attendanceView.layer.cornerRadius = 8.0f;
//    self.attendanceView.clipsToBounds = YES;
    
    _attendanceView.layer.shadowRadius  = 5.5f;
    _attendanceView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _attendanceView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _attendanceView.layer.shadowOpacity = 0.6f;
    _attendanceView.layer.masksToBounds = NO;
    
//    self.classtestHomeworkView.layer.cornerRadius = 8.0f;
//    self.classtestHomeworkView.clipsToBounds = YES;
    
    _classtestHomeworkView.layer.shadowRadius  = 5.5f;
    _classtestHomeworkView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _classtestHomeworkView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _classtestHomeworkView.layer.shadowOpacity = 0.6f;
    _classtestHomeworkView.layer.masksToBounds = NO;
    
//    self.classtestMarksView.layer.cornerRadius = 8.0f;
//    self.classtestMarksView.clipsToBounds = YES;
    
    _classtestMarksView.layer.shadowRadius  = 5.5f;
    _classtestMarksView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _classtestMarksView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _classtestMarksView.layer.shadowOpacity = 0.6f;
    _classtestMarksView.layer.masksToBounds = NO;
    
//    self.examMarks.layer.cornerRadius = 8.0f;
//    self.examMarks.clipsToBounds = YES;
    
    _examMarks.layer.shadowRadius  = 5.5f;
    _examMarks.layer.shadowColor   = UIColor.grayColor.CGColor;
    _examMarks.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _examMarks.layer.shadowOpacity = 0.6f;
    _examMarks.layer.masksToBounds = NO;
    
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath;
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_attendanceView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_classtestHomeworkView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_classtestMarksView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_examMarks.bounds, shadowInsets)];
    _attendanceView.layer.shadowPath    = shadowPath.CGPath;
    _classtestHomeworkView.layer.shadowPath    = shadowPath.CGPath;
    _classtestMarksView.layer.shadowPath    = shadowPath.CGPath;
    _examMarks.layer.shadowPath    = shadowPath.CGPath;

//    _attendanceSync.layer.cornerRadius = 5; // this value vary as per your desire
//    _attendanceSync.clipsToBounds = YES;
//    _classtestSync.layer.cornerRadius = 5; // this value vary as per your desire
//    _classtestSync.clipsToBounds = YES;
//    
//    _refreshsync.layer.cornerRadius = 5; // this value vary as per your desire
//    _refreshsync.clipsToBounds = YES;
//    _refreshsync.layer.borderWidth = 1.0f;
//    _refreshsync.layer.borderColor = [UIColor blackColor].CGColor;
//
//    _classTestMarkSync.layer.cornerRadius = 5; // this value vary as per your desire
//    _classTestMarkSync.clipsToBounds = YES;
//    _examSync.layer.cornerRadius = 5; // this value vary as per your desire
//    _examSync.clipsToBounds = YES;

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

- (IBAction)attendanceSyncBtn:(id)sender
{
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT COUNT(*) as count FROM table_create_attendence"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"count :%d",[rs intForColumn:@"count"]);
            strcount = [rs stringForColumn:@"count"];
        }
    }
    [database close];
    
    if(![strcount isEqualToString:@"0"])
    {
                docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                documentsDir = [docPaths objectAtIndex:0];
                dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                database = [FMDatabase databaseWithPath:dbPath];
                [database open];
                rs = [database executeQuery:@"Select _id,server_at_id,ac_year,class_id,class_total,no_of_present,no_of_absent,attendance_period,created_by,created_at,status,sync_status from table_create_attendence where sync_status = ?",@"NS"];
        
                [sync_status removeAllObjects];
                [server_at_id removeAllObjects];
                [ac_year removeAllObjects];
                [classid removeAllObjects];
                [no_of_present removeAllObjects];
                [no_of_absent removeAllObjects];
                [attendance_period removeAllObjects];
                [created_by removeAllObjects];
                [created_at removeAllObjects];
                [status removeAllObjects];
                [class_total removeAllObjects];
                [_id removeAllObjects];
                
                if(rs)
                {
                    while ([rs next])
                    {
                        NSString *strSync = [rs stringForColumn:@"sync_status"];
                        NSString *strserver_at_id = [rs stringForColumn:@"server_at_id"];
                        NSLog(@"%2@",server_at_id);
                        NSString *strac_year = [rs stringForColumn:@"ac_year"];
                        NSString *strclass_id = [rs stringForColumn:@"class_id"];
                        NSString *strclass_total = [rs stringForColumn:@"class_total"];
                        NSString *strno_of_present = [rs stringForColumn:@"no_of_present"];
                        NSString *strno_of_absent = [rs stringForColumn:@"no_of_absent"];
                        NSString *strattendance_period = [rs stringForColumn:@"attendance_period"];
                        NSString *strcreated_by = [rs stringForColumn:@"created_by"];
                        NSString *strcreated_at = [rs stringForColumn:@"created_at"];
                        NSString *strstatus = [rs stringForColumn:@"status"];
                        NSString *strID = [rs stringForColumn:@"_id"];
                        
                        [sync_status addObject:strSync];
                        [server_at_id addObject:strserver_at_id];
                        [ac_year addObject:strac_year];
                        [classid addObject:strclass_id];
                        [class_total addObject:strclass_total];
                        [no_of_present addObject:strno_of_present];
                        [no_of_absent addObject:strno_of_absent];
                        [attendance_period addObject:strattendance_period];
                        [created_by addObject:strcreated_by];
                        [created_at addObject:strcreated_at];
                        [status addObject:strstatus];
                        [_id addObject:strID];
                    }
                }
                [database close];
        
        if (sync_status.count != 0)
        {
            for (int i =0;i < [sync_status count]; i++)
            {
                NSString *str_ac_year = [ac_year objectAtIndex:i];
                NSString *str_classid = [classid objectAtIndex:i];
                NSString *str_no_of_present = [no_of_present objectAtIndex:i];
                NSString *str_no_of_absent = [no_of_absent objectAtIndex:i];
                NSString *str_attendance_period = [attendance_period objectAtIndex:i];
                NSString *str_created_by = [created_by objectAtIndex:i];
                NSString *str_created_at = [created_at objectAtIndex:i];
                NSString *str_status = [status objectAtIndex:i];
                NSString *str_class_total = [class_total objectAtIndex:i];
                attendance_lastInserted_id = [_id objectAtIndex:i];
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:str_ac_year forKey:@"ac_year"];
                [parameters setObject:str_classid forKey:@"class_id"];
                [parameters setObject:str_class_total forKey:@"class_total"];
                [parameters setObject:str_no_of_present forKey:@"no_of_present"];
                [parameters setObject:str_no_of_absent forKey:@"no_of_absent"];
                [parameters setObject:str_attendance_period forKey:@"attendance_period"];
                [parameters setObject:str_created_by forKey:@"created_by"];
                [parameters setObject:str_created_at forKey:@"created_at"];
                [parameters setObject:str_status forKey:@"status"];
                
                AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                /*concordanate with baseurl*/
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSString *sync_Attendance = @"/apiteacher/sync_Attendance/";
                NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,sync_Attendance, nil];
                NSString *api = [NSString pathWithComponents:components];
                
                [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     NSLog(@"%@",responseObject);
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     NSString *msg = [responseObject objectForKey:@"msg"];
                     NSString *status =[responseObject objectForKey:@"status"];
                     NSString *strattendance_id = [responseObject objectForKey:@"last_attendance_id"];
                     appDel.attendance_id = strattendance_id;
                     NSLog(@"%@%@%@",msg,status,appDel.attendance_id);
                     appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     documentsDir = [docPaths objectAtIndex:0];
                     dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                     database = [FMDatabase databaseWithPath:dbPath];
                     [database open];
                     NSLog(@"%@",appDel.attendance_id);
                     BOOL isUpdated = [database executeUpdate:@"UPDATE table_create_attendence SET server_at_id = ?,sync_status = ? where _id = ?",appDel.attendance_id,@"S",attendance_lastInserted_id];
                     
                     if(isUpdated)
                     {
                         NSLog(@"Updated Successfully in table_create_attendence");
                     }
                     else
                     {
                         NSLog(@"Error occured while Updating");
                     }
                     [database close];
                     
                     /*update AttendanceHistory with server*/
                     
                     docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     documentsDir = [docPaths objectAtIndex:0];
                     dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                     database = [FMDatabase databaseWithPath:dbPath];
                     [database open];
                     NSLog(@"%@",appDel.attendance_id);
                     NSString *attedncetable_LastinsertedID = [[NSUserDefaults standardUserDefaults]objectForKey:@"create_attendance_table_lastInsertedKey"];
                     
                     BOOL Updated = [database executeUpdate:@"UPDATE table_create_attendence_history SET server_attend_id = ? where attend_id = ?",appDel.attendance_id,attedncetable_LastinsertedID];
                     
                     if(Updated)
                     {
                         NSLog(@"Updated Successfully in table_create_attendence_history");
                     }
                     else
                     {
                         NSLog(@"Error occured while Updating");
                     }
                     [database close];
                     [self updateCreateAttendenceTable];
                 }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                 {
                     NSLog(@"error: %@", error);
                 }];
                
            }
            
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"No data to Sync"
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
                                   message:@"No data to Sync"
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
-(void)updateCreateAttendenceTable
{
    NSString *count;
    /*Get count From Attendence History */
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT COUNT(*) as count FROM table_create_attendence_history"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"count :%d",[rs intForColumn:@"count"]);
            count = [rs stringForColumn:@"count"];
        }
    }
    [database close];

    /*Select Values From Attendence History */
    //NSString *attedncetable_LastinsertedID = [[NSUserDefaults standardUserDefaults]objectForKey:@"create_attendance_table_lastInsertedKey"];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select _id,attend_id,server_attend_id,class_id,student_id,abs_date,a_status,attend_period,a_val,a_taken_by,created_at,updated_by,updated_at, status,sync_status from table_create_attendence_history where sync_status = ?",@"NS"];
    
    [sync_status removeAllObjects];
    [server_attend_id removeAllObjects];
    [classid removeAllObjects];
    [student_id removeAllObjects];
    [abs_date removeAllObjects];
    [attend_period removeAllObjects];
    [a_status removeAllObjects];
    [a_val removeAllObjects];
    [a_taken_by removeAllObjects];
    [created_at removeAllObjects];
    [status removeAllObjects];
    [_id removeAllObjects];
    
    if(rs)
    {
        while ([rs next])
        {
            NSString *strSyncStatus = [rs stringForColumn:@"sync_status"];
            NSString *strserver_attend_id = [rs stringForColumn:@"server_attend_id"];
            NSString *strclass_id = [rs stringForColumn:@"class_id"];
            NSString *strstudent_id = [rs stringForColumn:@"student_id"];
            NSString *strabs_date = [rs stringForColumn:@"abs_date"];
            NSString *stra_status = [rs stringForColumn:@"a_status"];
            NSString *strattend_period = [rs stringForColumn:@"attend_period"];
            NSString *stra_val = [rs stringForColumn:@"a_val"];
            NSString *stra_taken_by = [rs stringForColumn:@"a_taken_by"];
            NSString *strcreated_at = [rs stringForColumn:@"created_at"];
            NSString *strstatus = [rs stringForColumn:@"status"];
            NSString *ID = [rs stringForColumn:@"_id"];
            
            if (strserver_attend_id.length == 0)
            {
                strserver_attend_id = @"";
            }
            if (strclass_id.length == 0)
            {
                strclass_id = @"";
            }
            if (strstudent_id.length == 0)
            {
                strstudent_id = @"";
            }
            if (strabs_date.length == 0)
            {
                strabs_date = @"";
            }
            if (stra_status.length == 0)
            {
                stra_status = @"";
            }
            if (stra_val.length == 0)
            {
                stra_val = @"";
            }
            if (stra_taken_by.length == 0)
            {
                stra_taken_by = @"";
            }
            if (strcreated_at.length == 0)
            {
                strcreated_at = @"";
            }
            if (strstatus.length == 0)
            {
                strstatus = @"";
            }

            [sync_status addObject:strSyncStatus];
            [server_attend_id addObject:strserver_attend_id];
            [classid addObject:strclass_id];
            [student_id addObject:strstudent_id];
            [abs_date addObject:strabs_date];
            [attend_period addObject:strattend_period];
            [a_status addObject:stra_status];
            [a_val addObject:stra_val];
            [a_taken_by addObject:stra_taken_by];
            [created_at addObject:strcreated_at];
            [status addObject:strstatus];
            [_id addObject:ID];
        }
    }
    [database close];
    for (int i = 0;i < [created_at count];i++)
    {
        if ([a_status containsObject:@"P"])
        {
            NSUInteger index = [a_status indexOfObject:@"P"];
            NSString *str = student_id[index];
            [a_status removeObject:@"P"];
            [student_id removeObject:str];

        }
    }
        if (sync_status.count != 0)
        {
            for (int i = 0;i < [sync_status count];i++)
            {
                NSString *strserver_attend_id = [server_attend_id objectAtIndex:i];
                NSString *strclass_id = [classid objectAtIndex:i];
                NSString *strstudent_id = [student_id objectAtIndex:i];
                NSString *strabs_date = [abs_date objectAtIndex:i];
                NSString *stra_status = [a_status objectAtIndex:i];
                NSString *strattend_period = [attend_period objectAtIndex:i];
                NSString *stra_val = [a_val objectAtIndex:i];
                NSString *stra_taken_by = [a_taken_by objectAtIndex:i];
                NSString *strcreated_at = [created_at objectAtIndex:i];
                NSString *strstatus = [status objectAtIndex:i];
                NSString *strID = [_id objectAtIndex:i];
                attendanceHistrory_lastInserted_id = strID;
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:strserver_attend_id forKey:@"attend_id"];
                [parameters setObject:strclass_id forKey:@"class_id"];
                [parameters setObject:strstudent_id forKey:@"student_id"];
                [parameters setObject:strabs_date forKey:@"abs_date"];
                [parameters setObject:stra_status forKey:@"a_status"];
                [parameters setObject:strattend_period forKey:@"attend_period"];
                [parameters setObject:stra_val forKey:@"a_val"];
                [parameters setObject:stra_taken_by forKey:@"a_taken_by"];
                [parameters setObject:strcreated_at forKey:@"created_at"];
                [parameters setObject:strstatus forKey:@"status"];
                
                AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                /*concordanate with baseurl*/
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSString *sync_Attendance = @"/apiteacher/sync_Attendancehistory/";
                NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,sync_Attendance, nil];
                NSString *api = [NSString pathWithComponents:components];
                
                [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     NSLog(@"%@",responseObject);
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     NSString *msg = [responseObject objectForKey:@"msg"];
                     NSString *status =[responseObject objectForKey:@"status"];
                     NSString *strlast_attendance_history_id = [responseObject objectForKey:@"last_attendance_history_id"];
                     NSLog(@"%@%@",msg,status);
                     appDel.last_attendance_history_id = strlast_attendance_history_id;
                     [self updateCreateAttendenceHistoryTable];
                 }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                 {
                     NSLog(@"error: %@", error);
                 }];
                
            }
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"No data to sync"
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
-(void)updateCreateAttendenceHistoryTable
{
    /*Update values from Attendence History */
    NSLog(@"%@",appDel.last_attendance_id);
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL isUpdated = [database executeUpdate:@"UPDATE table_create_attendence_history SET sync_status = ? where _id = ?",@"S",attendanceHistrory_lastInserted_id];
    if(isUpdated)
    {
        NSLog(@"Updated Successfully in table_create_attendence_history");
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Data Sync Successfully"
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
        NSLog(@"Error occured while Updating");
    }
    [database close];
}
- (IBAction)classTestSyncBtn:(id)sender
{
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select id,class_id,teacher_id,hw_type,subject_id,title,test_date,due_date,hw_details,created_by,created_at,sync_status from table_create_homework_class_test where sync_status = ?",@"NS"];

        [sync_status removeAllObjects];
        [classid removeAllObjects];
        [techer_id removeAllObjects];
        [hw_type removeAllObjects];
        [subject_id removeAllObjects];
        [title removeAllObjects];
        [test_date removeAllObjects];
        [due_date removeAllObjects];
        [hw_details removeAllObjects];
        [created_by removeAllObjects];
        [created_at removeAllObjects];
        [sync_status removeAllObjects];
        [_id removeAllObjects];

        if(rs)
        {
            while ([rs next])
            {
                NSString *strSyncStatus =[rs stringForColumn:@"sync_status"];
                NSString *strclass_id = [rs stringForColumn:@"class_id"];
                NSString *strteacher_id = [rs stringForColumn:@"teacher_id"];
                NSString *strhw_type = [rs stringForColumn:@"hw_type"];
                NSString *strsubject_id = [rs stringForColumn:@"subject_id"];
                NSString *strtitle = [rs stringForColumn:@"title"];
                NSString *strtest_date = [rs stringForColumn:@"test_date"];
                NSString *strdue_date = [rs stringForColumn:@"due_date"];
                NSString *strhw_details = [rs stringForColumn:@"hw_details"];
                NSString *strcreated_by = [rs stringForColumn:@"created_by"];
                NSString *strcreated_at = [rs stringForColumn:@"created_at"];
                NSString *ID = [rs stringForColumn:@"id"];
                
                if (strclass_id.length == 0)
                {
                    strclass_id = @"";
                }
                if (strteacher_id.length == 0)
                {
                    strteacher_id = @"";
                }
                if (strhw_type.length == 0)
                {
                    strhw_type = @"";
                }
                if (strsubject_id.length == 0)
                {
                    strsubject_id = @"";
                }
                if (strtitle.length == 0)
                {
                    strtitle = @"";
                }
                if (strtest_date.length == 0)
                {
                    strtest_date = @"";
                }
                if (strdue_date.length == 0)
                {
                    strdue_date = @"";
                }
                if (strhw_details.length == 0)
                {
                    strhw_details = @"";
                }
                if (strcreated_by.length == 0)
                {
                    strcreated_by = @"";
                }
                if (strcreated_at.length == 0)
                {
                    strcreated_at = @"";
                }
                [classid addObject:strclass_id];
                [techer_id addObject:strteacher_id];
                [hw_type addObject:strhw_type];
                [subject_id addObject:strsubject_id];
                [title addObject:strtitle];
                [test_date addObject:strtest_date];
                [due_date addObject:strdue_date];
                [hw_details addObject:strhw_details];
                [created_by addObject:strcreated_by];
                [created_at addObject:strcreated_at];
                [sync_status addObject:strSyncStatus];
                [_id addObject:ID];
            }
        }
        [database close];
    if (sync_status.count != 0)
    {
        for (int i = 0;i < [sync_status count];i++)
        {
            NSString *strclass_id = [classid  objectAtIndex:i];
            NSString *strteacher_id = [techer_id  objectAtIndex:i];
            NSString *strhw_type = [hw_type  objectAtIndex:i];
            NSString *strsubject_id = [subject_id  objectAtIndex:i];
            NSString *strtitle = [title  objectAtIndex:i];
            NSString *strtest_date = [test_date  objectAtIndex:i];
            NSString *strdue_date = [due_date  objectAtIndex:i];
            NSString *strhw_details = [hw_details  objectAtIndex:i];
            NSString *strcreated_by = [created_by  objectAtIndex:i];
            NSString *strcreated_at = [created_at objectAtIndex:i];
            NSString *ID = [_id objectAtIndex:i];
            classtest_Homework_lastInserted_id = ID;
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:strclass_id forKey:@"class_id"];
            [parameters setObject:strteacher_id forKey:@"teacher_id"];
            [parameters setObject:strhw_type forKey:@"homeWork_type"];
            [parameters setObject:strsubject_id forKey:@"subject_id"];
            [parameters setObject:strtitle forKey:@"title"];
            [parameters setObject:strtest_date forKey:@"test_date"];
            [parameters setObject:strdue_date forKey:@"due_date"];
            [parameters setObject:strhw_details forKey:@"homework_details"];
            [parameters setObject:strcreated_by forKey:@"created_by"];
            [parameters setObject:strcreated_at forKey:@"created_at"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSString *add_Homework = @"/apiteacher/add_Homework/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_Homework, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                 NSLog(@"%@",responseObject);
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 if ([msg isEqualToString:@"Homework Added"] && [status isEqualToString:@"success"])
                 {
                     NSString *last_id = [responseObject objectForKey:@"last_id"];
                     // classtest_Homework_lastInserted_id = last_id;
                     appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     documentsDir = [docPaths objectAtIndex:0];
                     dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                     database = [FMDatabase databaseWithPath:dbPath];
                     [database open];
                     BOOL isUpdated = [database executeUpdate:@"UPDATE table_create_homework_class_test SET sync_status = ?,server_hw_id = ? where id = ?", @"S",(int)last_id,classtest_Homework_lastInserted_id];
                     
                     if(isUpdated)
                     {
                         NSLog(@"Updated Successfully in table_create_attendence_history");
                         
                         UIAlertController *alert= [UIAlertController
                                                    alertControllerWithTitle:@"ENSYFI"
                                                    message:@"Data Sync Successfully"
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
                         NSLog(@"Error occured while Updating");
                     }
                     [database close];
                 }
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
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
}
- (IBAction)resfreshSyncBtn:(id)sender
{
    NSString *strsync_status;
    NSMutableArray *sync_status = [[NSMutableArray alloc]init];
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select sync_status from table_create_homework_class_test"];
    [sync_status removeAllObjects];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"sync_status :%@",[rs stringForColumn:@"sync_status"]);
            strsync_status = [rs stringForColumn:@"sync_status"];
            [sync_status addObject:strsync_status];
        }
    }
    [database close];
    
    if (![sync_status containsObject:@"NS"])
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *teacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"strteacher_id_key"];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:teacher_id forKey:@"teacher_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *add_Homework = @"/apiteacher/reloadHomework/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_Homework, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             NSString *count = [responseObject objectForKey:@"count"];
             NSLog(@"%@",count);
             if ([msg isEqualToString:@"View Homework Details"] && [status isEqualToString:@"success"])
             {
                 NSArray *homeworkDetails = [responseObject objectForKey:@"homeworkDetails"];
                 for (int i = 0; i < [homeworkDetails count]; i++)
                 {
                     NSDictionary *dict = [homeworkDetails objectAtIndex:i];
                     NSString *strclass_id = [dict objectForKey:@"class_id"];
                     NSString *strdue_date = [dict objectForKey:@"due_date"];
                     NSString *strhw_details = [dict objectForKey:@"hw_details"];
                     NSString *strhw_id = [dict objectForKey:@"hw_id"];
                     NSString *strhw_type = [dict objectForKey:@"hw_type"];
                     NSString *strmark_status = [dict objectForKey:@"mark_status"];
                     NSString *strsubject_id = [dict objectForKey:@"subject_id"];
                     NSString *strsubject_name = [dict objectForKey:@"subject_name"];
                     NSString *strtest_date = [dict objectForKey:@"test_date"];
                     NSString *strtitle = [dict objectForKey:@"title"];
                     
                     [classid addObject:strclass_id];
                     [due_date addObject:strdue_date];
                     [hw_details addObject:strhw_details];
                     [hw_id addObject:strhw_id];
                     [hw_type addObject:strhw_type];
                     [mark_status addObject:strmark_status];
                     [subject_id addObject:strsubject_id];
                     [subject_name addObject:strsubject_name];
                     [test_date addObject:strtest_date];
                     [title addObject:strtitle];

                 }
                 [self refresh_UpdateValue];
             }
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"cannot refresh"
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
-(void)refresh_UpdateValue
{
    for (int i  =0;i <  [hw_id count]; i++)
    {
        NSString *strclassid = [classid objectAtIndex:i];
        NSString *strdue_date = [due_date objectAtIndex:i];
        NSString *strhw_details = [hw_details objectAtIndex:i];
        NSString *strhw_id = [hw_id objectAtIndex:i];
        NSString *strhw_type = [hw_type objectAtIndex:i];
        NSString *strmark_status = [mark_status objectAtIndex:i];
        NSString *strsubject_id = [subject_id objectAtIndex:i];
        NSString *strsubject_name = [subject_name objectAtIndex:i];
        NSString *strtest_date = [test_date objectAtIndex:i];
        NSString *strtitle = [title objectAtIndex:i];
        
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select server_hw_id from table_create_homework_class_test"];
        if(rs)
        {
            while ([rs next])
            {
                NSString *server_hw_id = [rs stringForColumn:@"server_hw_id"];
                
                if ([server_hw_id isEqualToString:@""])
                {
                    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    documentsDir = [docPaths objectAtIndex:0];
                    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                    database = [FMDatabase databaseWithPath:dbPath];
                    [database open];
                    NSLog(@"%@",appDel.attendance_id);
                    BOOL isInserted = [database executeUpdate:@"INSERT INTO table_create_homework_class_test (server_at_id,class_id,hw_type,subject_id,subject_name,title,test_date,due_date,hw_details,status,mark_status,created_by,created_at,updated_by,updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",strhw_id,strclassid,strhw_type,strsubject_id,strsubject_name,strtitle,strtest_date,strdue_date,strhw_details,@"",strmark_status];
                    
                    if(isInserted)
                    {
                        NSLog(@"Updated Successfully in table_create_homework_class_test");
                    }
                    else
                    {
                        NSLog(@"Error occured while Updating");
                    }
                }
            }
        }
    }
    [database close];

}
- (IBAction)classTestMarkSyncBtn:(id)sender
{
    NSString *strcount;
    [server_hw_id removeAllObjects];
    [student_id removeAllObjects];
    [marks removeAllObjects];
    [remarks removeAllObjects];
    [created_by removeAllObjects];
    [created_at removeAllObjects];
    [_id  removeAllObjects];
    [sync_status removeAllObjects];

    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"SELECT COUNT(*) as count FROM table_create_class_test_mark"];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"count :%d",[rs intForColumn:@"count"]);
            strcount = [rs stringForColumn:@"count"];
        }
    }
    [database close];
    
    if(![strcount isEqualToString:@"0"])
    {
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select _id,server_hw_id,student_id,marks,remarks,created_by,created_at,sync_status from table_create_class_test_mark where sync_status = ?",@"NS"];
        if(rs)
        {
          while ([rs next])
            {
              NSString *strserver_hw_id = [rs stringForColumn:@"server_hw_id"];
              NSString *strstudent_id = [rs stringForColumn:@"student_id"];
              NSString *strmarks = [rs stringForColumn:@"marks"];
              NSString *strremarks = [rs stringForColumn:@"remarks"];
              NSString *strcreated_by = [rs stringForColumn:@"created_by"];
              NSString *strcreated_at = [rs stringForColumn:@"created_at"];
              NSString *strID = [rs stringForColumn:@"_id"];
              NSString *strsyncstatus = [rs stringForColumn:@"sync_status"];

              [server_hw_id addObject:strserver_hw_id];
              [student_id addObject:strstudent_id];
              [marks addObject:strmarks];
              [remarks addObject:strremarks];
              [created_by addObject:strcreated_by];
              [created_at addObject:strcreated_at];
              [_id  addObject:strID];
              [sync_status addObject:strsyncstatus];
                
            }
        }
          [database close];

        for (int i = 0;i < [sync_status count];i++)
        {
            NSString *str_server_hw_id = [server_hw_id objectAtIndex:i];
            NSString *str_student_id = [student_id objectAtIndex:i];
            NSString *str_marks = [marks objectAtIndex:i];
            NSString *str_remarks = [remarks objectAtIndex:i];
            NSString *str_created_by = [created_by objectAtIndex:i];
            NSString *str_created_at = [created_at objectAtIndex:i];
            NSString *str_sync_status = [created_at objectAtIndex:i];

            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:str_server_hw_id forKey:@"hw_masterid"];
            [parameters setObject:str_student_id forKey:@"student_id"];
            [parameters setObject:str_marks forKey:@"marks"];
            [parameters setObject:str_remarks forKey:@"remarks"];
            [parameters setObject:str_created_by forKey:@"created_by"];
            [parameters setObject:str_created_at forKey:@"created_at"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSString *add_Homework = @"/apiteacher/add_HWmarks/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_Homework, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                 NSLog(@"%@",responseObject);
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 NSLog(@"%@%@",msg,status);
                 NSString *mark_id = [responseObject objectForKey:@"mark_id"];
                 
                 appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                 docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 documentsDir = [docPaths objectAtIndex:0];
                 dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                 database = [FMDatabase databaseWithPath:dbPath];
                 [database open];
                 BOOL isUpdated = [database executeUpdate:@"UPDATE table_create_class_test_mark SET sync_status = ?,server_hw_id = ? where _id = ?",@"S",mark_id,str_sync_status];
                 if(isUpdated)
                 {
                     NSLog(@"Updated Successfully in table_create_class_test_mark");
                     
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:@"Data Sync Successfully"
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
                     NSLog(@"Error occured while Updating");
                 }
                 [database close];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
    }
}
- (IBAction)examSyncBtn:(id)sender
{
    NSString *last_str_id;
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    rs = [database executeQuery:@"Select _id,exam_id,teacher_id,subject_id,stu_id,classmaster_id,internal_mark,internal_grade,external_mark,external_grade,total_marks,total_grade,created_by,created_at,updated_by,updated_at,sync_status from table_create_academic_exam_marks where sync_status = ?",@"NS"];
    
    [sync_status removeAllObjects];
    [exam_id removeAllObjects];
    [techer_id removeAllObjects];
    [subject_id removeAllObjects];
    [student_id removeAllObjects];
    [classid removeAllObjects];
    [internalMark removeAllObjects];
    [internalGrade removeAllObjects];
    [externalMark removeAllObjects];
    [externalGrade removeAllObjects];
    [totalMarks removeAllObjects];
    [totalGrade removeAllObjects];
    [_id removeAllObjects];

    if(rs)
    {
        while ([rs next])
        {
            strsync_status = [rs stringForColumn:@"sync_status"];
            NSString *str_exam_id = [rs stringForColumn:@"exam_id"];
            NSString *str_teacher_id = [rs stringForColumn:@"teacher_id"];
            NSString *str_subject_id = [rs stringForColumn:@"subject_id"];
            NSString *str_stu_id = [rs stringForColumn:@"stu_id"];
            NSString *str_classmaster_id = [rs stringForColumn:@"classmaster_id"];
            NSString *str_internal_mark = [rs stringForColumn:@"internal_mark"];
            NSString *str_internal_grade = [rs stringForColumn:@"internal_grade"];
            NSString *str_external_mark = [rs stringForColumn:@"external_mark"];
            NSString *str_external_grade = [rs stringForColumn:@"external_grade"];
            NSString *str_total_marks = [rs stringForColumn:@"total_marks"];
            NSString *str_total_grade = [rs stringForColumn:@"total_grade"];
            NSString *str_created_by = [rs stringForColumn:@"created_by"];
            NSString *str_id = [rs stringForColumn:@"_id"];
            
            [sync_status addObject:strsync_status];
            [exam_id addObject:str_exam_id];
            [techer_id addObject:str_teacher_id];
            [subject_id addObject:str_subject_id];
            [student_id addObject:str_stu_id];
            [classid addObject:str_classmaster_id];
            [internalMark addObject:str_internal_mark];
            [internalGrade addObject:str_internal_grade];
            [externalMark addObject:str_external_mark];
            [externalGrade addObject:str_external_grade];
            [totalMarks addObject:str_total_marks];
            [totalGrade addObject:str_total_grade];
            [created_by addObject:str_created_by];
            [_id addObject:str_id];

        }
    }
    [database close];
    if ([sync_status containsObject:@"NS"])
    {
        [is_internals_externals removeAllObjects];
        for (int i = 0;i < [created_by count];i++)
        {
            NSString *str_clas = [classid objectAtIndex:i];
            NSString *str_exam = [exam_id objectAtIndex:i];
            docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDir = [docPaths objectAtIndex:0];
            dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
            database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            rs = [database executeQuery:@"Select is_internal_external from table_create_exams_details where classmaster_id = ? and exam_id = ?",str_clas,str_exam];
            
            if(rs)
            {
                while ([rs next])
                {
                    NSString *str_is_internals_externals = [rs stringForColumn:@"is_internal_external"];
                    [is_internals_externals addObject:str_is_internals_externals];
                }
            }
        }
        [database close];

            for (int i = 0;i < [created_by count];i++)
            {
                NSString *str_exam_id = [exam_id objectAtIndex:i];
                NSString *str_techer_id = [techer_id objectAtIndex:i];
                NSString *str_subject_id = [subject_id objectAtIndex:i];
                NSString *str_student_id = [student_id objectAtIndex:i];
                NSString *str_classid = [classid objectAtIndex:i];
                NSString *str_internalMark = [internalMark objectAtIndex:i];
                NSString *str_externalMark = [externalMark objectAtIndex:i];
                NSString *str_totalMarks = [totalMarks objectAtIndex:i];
                NSString *str_createdby = [created_by objectAtIndex:i];
                NSString *str_isInt_Ext = [is_internals_externals objectAtIndex:i];
                last_str_id = [_id objectAtIndex:i];
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:str_exam_id forKey:@"exam_id"];
                [parameters setObject:str_techer_id forKey:@"teacher_id"];
                [parameters setObject:str_subject_id forKey:@"subject_id"];
                [parameters setObject:str_student_id forKey:@"stu_id"];
                [parameters setObject:str_classid forKey:@"classmaster_id"];
                [parameters setObject:str_internalMark forKey:@"internal_mark"];
                [parameters setObject:str_externalMark forKey:@"external_mark"];
                [parameters setObject:str_totalMarks forKey:@"marks"];
                [parameters setObject:str_isInt_Ext forKey:@"is_internal_external"];
                [parameters setObject:str_createdby forKey:@"created_by"];
                
                AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSString *add_Exammarks = @"/apiteacher/add_Exammarks/";
                NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_Exammarks, nil];
                NSString *api = [NSString pathWithComponents:components];
                
                [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     NSLog(@"%@",responseObject);
                     NSString *msg = [responseObject objectForKey:@"msg"];
                     NSString *status = [responseObject objectForKey:@"status"];
                     NSString *last_id = [responseObject objectForKey:@"last_id"];
                     NSLog(@"%@%@",msg,last_id);
                     if ([status isEqualToString:@"success"] || [status isEqualToString:@"AlreadyAdded"])
                     {
                         docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                         documentsDir = [docPaths objectAtIndex:0];
                         dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
                         database = [FMDatabase databaseWithPath:dbPath];
                         [database open];
                         BOOL isUpdated = [database executeUpdate:@"UPDATE table_create_academic_exam_marks SET sync_status = ? where _id = ?",@"S",last_str_id];
                         
                         if(isUpdated)
                         {
                             NSLog(@"Updated Successfully in table_create_class_test_mark");
                             
                             UIAlertController *alert= [UIAlertController
                                                        alertControllerWithTitle:@"ENSYFI"
                                                        message:@"Data Sync Successfully"
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
                             NSLog(@"Error occured while Updating");
                         }
                         
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                     }
                 }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                 {
                     NSLog(@"error: %@", error);
                 }];
            }
        }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"No data to Sync"
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
