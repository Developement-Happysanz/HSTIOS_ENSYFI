//
//  TeacherClassTestDetailView.m
//  EducationApp
//
//  Created by HappySanz on 06/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherClassTestDetailView.h"

@interface TeacherClassTestDetailView ()
{
}
@end

@implementation TeacherClassTestDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
 //   NSString *mark_status = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTestMark_status_key"];
    NSString *strMark_status;
    NSString *class_test_result = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_resultKey"];
    NSString *lastinserted_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"server_hw_id_key"];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *rs = [database executeQuery:@"Select mark_status from table_create_homework_class_test where server_hw_id = ? ",lastinserted_id];
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"mark_status :%@",[rs stringForColumn:@"mark_status"]);
            strMark_status = [rs stringForColumn:@"mark_status"];
        }
    }
    [database close];
    
    if ([class_test_result isEqualToString:@"Class Test"])
    {
        if ([strMark_status isEqualToString:@"0"])
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
            
            UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"view icon -android-01.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(showmark)];
            
            self.navigationItem.rightBarButtonItem=_btn;
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
            
        }
    }
    else
    {
        if ([strMark_status isEqualToString:@"0"])
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
            
            UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"view icon -android-01.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(showmark)];
            
            self.navigationItem.rightBarButtonItem=_btn;
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
            
        }
    }
    NSString *strType = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_test_resultKey"];
    if ([strType isEqualToString:@"Class Test"])
    {
        self.navigationItem.title = @"CLASS TEST";
        NSString *title =[[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTest_key"];
        NSString *topic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTestTopic_key"];
        NSString *classTestdate = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTest_date_key"];
        NSArray *arr = [classTestdate componentsSeparatedByString:@":"];
        NSString *str = [arr objectAtIndex:1];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"ClassTest_date_key"];
        NSString *detail = [[NSUserDefaults standardUserDefaults]objectForKey:@"ClassTest_descp_key"];
        
        self.subjectTitle.text = title;
        self.topicLabel.text = topic;
        self.dateLabel.text = str;
        self.detailsLabel.text = detail;
        
        
    }
    else
    {
        self.navigationItem.title = @"HOME WORK";

        NSString *title =[[NSUserDefaults standardUserDefaults]objectForKey:@"homeWork_key"];
        NSString *topic = [[NSUserDefaults standardUserDefaults]objectForKey:@"homeWorktopic_key"];
        NSString *Homeworkdate = [[NSUserDefaults standardUserDefaults]objectForKey:@"homeWork_date_key"];
        NSArray *arr = [Homeworkdate componentsSeparatedByString:@":"];
        NSString *str = [arr objectAtIndex:1];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"homeWork_date_key"];
        NSString *detail = [[NSUserDefaults standardUserDefaults]objectForKey:@"homeWork_descp_key"];
        
        self.subjectTitle.text = title;
        self.topicLabel.text = topic;
        self.dateLabel.text = str;
        self.detailsLabel.text = detail;
    }
}
-(void)addMarkView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherClasstestAddmark *teacherClasstestAddmark = (TeacherClasstestAddmark *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestAddmark"];
    [self.navigationController pushViewController:teacherClasstestAddmark animated:YES];
}
-(void)showmark
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherClasstestViewMark *teacherClasstestViewMark = (TeacherClasstestViewMark *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestViewMark"];
    [self.navigationController pushViewController:teacherClasstestViewMark animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews
{
    [self.detailsLabel setContentOffset:CGPointZero animated:NO];

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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
