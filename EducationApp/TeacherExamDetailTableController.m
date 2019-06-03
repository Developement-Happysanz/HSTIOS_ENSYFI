//
//  TeacherExamDetailTableController.m
//  EducationApp
//
//  Created by HappySanz on 11/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherExamDetailTableController.h"

@interface TeacherExamDetailTableController ()
{
    NSMutableArray *subject_name;
    NSMutableArray *exam_date;
    NSMutableArray *times;

    NSArray *stat;
}
@end

@implementation TeacherExamDetailTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    subject_name = [[NSMutableArray alloc]init];
    exam_date = [[NSMutableArray alloc]init];
    times = [[NSMutableArray alloc]init];
    stat = @[@"1"];
    NSString *mark_status = [[NSUserDefaults standardUserDefaults]objectForKey:@"mark_status_key"];
    if ([mark_status isEqualToString:@"0"])
    {
        UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus icon-01.png"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(addMarkView)];
        
        self.navigationItem.rightBarButtonItem=_btn;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else
    {
        UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"view icon -ios-01.png"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(ViewMark)];
        
        self.navigationItem.rightBarButtonItem=_btn;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    [subject_name removeAllObjects];
    [exam_date removeAllObjects];
    [times removeAllObjects];
    
    NSString *exam_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"exam_id_key"];
    NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    FMResultSet *rs = [database executeQuery:@"Select distinct subject_name,exam_date,times from table_create_exams_details where exam_id = ? and classmaster_id =? ",exam_id,class_id];
    
    [subject_name insertObject:@"select" atIndex:0];
    [exam_date insertObject:@"select" atIndex:0];
    [times insertObject:@"select" atIndex:0];

    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"subject_name :%@",[rs stringForColumn:@"subject_name"]);
            NSString *strsubject_name = [rs stringForColumn:@"subject_name"];
            NSString *strexam_date = [rs stringForColumn:@"exam_date"];
            NSString *strtimes = [rs stringForColumn:@"times"];

            [subject_name addObject:strsubject_name];
            [exam_date addObject:strexam_date];
            [times addObject:strtimes];
            
        }
        [self.tableView reloadData];
    }
    
    [database close];
}
-(void)addMarkView
{
    NSString *is_internal = [[NSUserDefaults standardUserDefaults]objectForKey:@"isinternal_key"];
    if ([is_internal isEqualToString:@"0"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherExamExternalMarkView *teacherExamExternalMarkView = (TeacherExamExternalMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamExternalMarkView"];
        [self.navigationController pushViewController:teacherExamExternalMarkView animated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherExamIntExtView *teacherExamIntExtView = (TeacherExamIntExtView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamIntExtView"];
        [self.navigationController pushViewController:teacherExamIntExtView animated:YES];
    }
}
-(void)ViewMark
{
    NSString *is_internal = [[NSUserDefaults standardUserDefaults]objectForKey:@"isinternal_key"];
    if ([is_internal isEqualToString:@"0"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamTestMarkView *examTestMarkView = (ExamTestMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"ExamTestMarkView"];
        [self.navigationController pushViewController:examTestMarkView animated:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamMarkViewController *examMarkViewController = (ExamMarkViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamMarkViewController"];
        [self.navigationController pushViewController:examMarkViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
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
    return [subject_name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        TeacherExamDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        return cell;
    }
    else
    {
        TeacherExamDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        cell.subjectLabel.text = [subject_name objectAtIndex:indexPath.row];
        cell.dateLabel.text = [exam_date objectAtIndex:indexPath.row];
        cell.timeLabel.text = [times objectAtIndex:indexPath.row];
        return cell;
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
- (IBAction)backBtn:(id)sender
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([str isEqualToString:@"main"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherExamViewController *teacherExamViewController = (TeacherExamViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamViewController"];
        [self.navigationController pushViewController:teacherExamViewController animated:YES];
//       [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
