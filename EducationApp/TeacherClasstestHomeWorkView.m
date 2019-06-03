//
//  TeacherClasstestHomeWorkView.m
//  EducationApp
//
//  Created by HappySanz on 06/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherClasstestHomeWorkView.h"

@interface TeacherClasstestHomeWorkView ()
{
    NSMutableArray *classNameArr;
    
    NSMutableArray *classTest_id;
    NSMutableArray *title;
    NSMutableArray *subject_name;
    NSMutableArray *hw_type;
    NSMutableArray *test_date;
    NSMutableArray *due_date;
    NSMutableArray *markstatus;
    NSMutableArray *hw_details;

    NSMutableArray *server_hw_id;;

}
@end

@implementation TeacherClasstestHomeWorkView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    classTest_id = [[NSMutableArray alloc]init];
    title = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    hw_type = [[NSMutableArray alloc]init];
    test_date = [[NSMutableArray alloc]init];
    due_date = [[NSMutableArray alloc]init];
    hw_details = [[NSMutableArray alloc]init];
    markstatus = [[NSMutableArray alloc]init];
    
    server_hw_id = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebar setTarget: self.revealViewController];
        [self.sidebar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    classNameArr = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _classSectionOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classSectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classSectionOtlet.layer.borderWidth = 1.0f;
    [_classSectionOtlet.layer setCornerRadius:10.0f];
    
    _categoeryOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _categoeryOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _categoeryOtlet.layer.borderWidth = 1.0f;
    [_categoeryOtlet.layer setCornerRadius:10.0f];
    
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
    return [subject_name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherClassTestHomeworkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.detailLabel.text = [title objectAtIndex:indexPath.row];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    NSString *str_categorey = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_resultKey"];
    if ([str_categorey isEqualToString:@"Class Test"])
    {
        cell.typeLabel.text =@"Class Test";
        cell.homeworkLabel.text = [NSString stringWithFormat:@"%@ : %@",@"Test Date",[test_date objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.typeLabel.text =@"Home Work";
        cell.homeworkLabel.text = [NSString stringWithFormat:@"%@ : %@",@"Homework Submission Date",[due_date objectAtIndex:indexPath.row]];
    }
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TeacherClassTestHomeworkCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *str_categorey = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_resultKey"];
    
    if ([str_categorey isEqualToString:@"Class Test"])
    {
        NSString *sub_name = Cell.subjectName.text;
        NSString *topic = Cell.detailLabel.text;
        NSString *date = Cell.homeworkLabel.text;
        NSString *descp = [hw_details objectAtIndex:indexPath.row];
        NSString *strclasstest_id = [classTest_id objectAtIndex:indexPath.row];
        NSString *strserver_hw_id = [server_hw_id objectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults]setObject:topic forKey:@"ClassTestTopic_key"];
        [[NSUserDefaults standardUserDefaults]setObject:sub_name forKey:@"ClassTest_key"];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"ClassTest_date_key"];
        [[NSUserDefaults standardUserDefaults]setObject:descp forKey:@"ClassTest_descp_key"];
        [[NSUserDefaults standardUserDefaults]setObject:strclasstest_id forKey:@"localid_key"];
        [[NSUserDefaults standardUserDefaults]setObject:strserver_hw_id forKey:@"server_hw_id_key"];

    }
    else
    {
        NSString *sub_name = Cell.subjectName.text;
        NSString *topic = Cell.detailLabel.text;
        NSString *date = Cell.homeworkLabel.text;
        NSString *descp = [hw_details objectAtIndex:indexPath.row];
        NSString *strclasstest_id = [classTest_id objectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults]setObject:sub_name forKey:@"homeWork_key"];
        [[NSUserDefaults standardUserDefaults]setObject:topic forKey:@"homeWorktopic_key"];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"homeWork_date_key"];
        [[NSUserDefaults standardUserDefaults]setObject:descp forKey:@"homeWork_descp_key"];
        [[NSUserDefaults standardUserDefaults]setObject:strclasstest_id forKey:@"strclasstest_id_key"];

    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherClassTestDetailView *teacherClassTestDetailView = (TeacherClassTestDetailView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClassTestDetailView"];
    [self.navigationController pushViewController:teacherClassTestDetailView animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
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
    if(dropDown == nil)
    {
        if (classNameArr.count > 3)
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
        [_categoeryOtlet setTitle:@"Categoery" forState:UIControlStateNormal];

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
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"categoery_key"];
    
    if ([str isEqualToString:@"categoery"])
    {
        NSString *class_id;
        NSString *db_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"teacher_attendance_resultKey"];
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        FMResultSet *rs = [database executeQuery:@"Select distinct class_id from table_create_teacher_student_details where class_section= ? ",db_class_name];
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"Class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id = [rs stringForColumn:@"class_id"];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];;
        [database close];
        NSString *type = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_resultKey"];
        if ([type isEqualToString:@"Class Test"])
        {
            type = @"HT";
        }
        else
        {
            type = @"HW";
        }
        NSArray *classdocPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *classdocumentsDir = [classdocPaths objectAtIndex:0];
        NSString *classdbPath = [classdocumentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        FMDatabase *classdatabase = [FMDatabase databaseWithPath:classdbPath];
        [classdatabase open];
        FMResultSet *clasrs = [classdatabase executeQuery:@"Select distinct id,title,subject_name,hw_type,test_date,due_date,hw_details,mark_status,server_hw_id from table_create_homework_class_test where class_id = ? and hw_type = ? order by id asc",class_id,type];
        
        [classTest_id removeAllObjects];
        [title removeAllObjects];
        [subject_name removeAllObjects];
        [hw_type removeAllObjects];
        [test_date removeAllObjects];
        [due_date removeAllObjects];
        [hw_details removeAllObjects];
        [markstatus removeAllObjects];
        [server_hw_id removeAllObjects];

        if(clasrs)
        {
            while ([clasrs next])
            {
               NSLog(@"subject_name :%@",[clasrs stringForColumn:@"subject_name"]);
               NSString *strclassTest_id = [clasrs stringForColumn:@"id"];
               NSString *strserver_h_id = [clasrs stringForColumn:@"server_hw_id"];
               NSString *strtitle = [clasrs stringForColumn:@"title"];
               NSString *strsubject_name = [clasrs stringForColumn:@"subject_name"];
               NSString *strhw_type = [clasrs stringForColumn:@"hw_type"];
               NSString *strtest_date = [clasrs stringForColumn:@"test_date"];
               NSString *strdue_date = [clasrs stringForColumn:@"due_date"];
               NSString *strhw_details = [clasrs stringForColumn:@"hw_details"];
               NSString *strmark_status = [clasrs stringForColumn:@"mark_status"];

                [classTest_id addObject:strclassTest_id];
                [title addObject:strtitle];
                [subject_name addObject:strsubject_name];
                [hw_type addObject:strhw_type];
                [test_date addObject:strtest_date];
                [due_date addObject:strdue_date];
                [hw_details addObject:strhw_details];
                [markstatus addObject:strmark_status];
                [server_hw_id addObject:strserver_h_id];

            }
            [self.tableview reloadData];
        }
        //[[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];;
        [classdatabase close];
    }
}
- (IBAction)categoeryBtn:(id)sender
{
    NSArray *arr = @[@"Class Test",@"Home Work"];
    if(dropDown == nil)
    {
        CGFloat f = 100;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        [[NSUserDefaults standardUserDefaults]setObject:@"class_test" forKey:@"class_test_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:@"categoery" forKey:@"categoery_key"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)plusbtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherClassTestMarkView *teacherClassTestMarkView = (TeacherClassTestMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClassTestMarkView"];
    [self.navigationController pushViewController:teacherClassTestMarkView animated:YES];
}
@end
