//
//  TeacherTimeTableNotes.m
//  EducationApp
//
//  Created by HappySanz on 13/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherTimeTableNotes.h"

@interface TeacherTimeTableNotes ()
{
    AppDelegate *appDel;
    
    NSMutableArray *class_section_name;
    NSMutableArray *subject_name;
    NSMutableArray *day;
    NSMutableArray *date_time;

    NSMutableArray *comments;
    NSMutableArray *remarks;

}
@end

@implementation TeacherTimeTableNotes

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    class_section_name = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    day = [[NSMutableArray alloc]init];
    date_time = [[NSMutableArray alloc]init];

    comments = [[NSMutableArray alloc]init];
    remarks = [[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *str_teacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"strteacher_id_key"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:str_teacher_id forKey:@"teacher_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forEvent = @"/apiteacher/disp_Timetablereview/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *reviewDetails = [responseObject objectForKey:@"reviewDetails"];
         
         if ([msg isEqualToString:@"View Reviews"])
         {
             [class_section_name removeAllObjects];
             [subject_name removeAllObjects];
             [day removeAllObjects];
             [date_time removeAllObjects];
             [comments removeAllObjects];
             [remarks removeAllObjects];
             
             for (int i = 0; i < [reviewDetails count]; i++)
             {
                 NSDictionary *dict = [reviewDetails objectAtIndex:i];
                 NSString *strclass_id = [dict objectForKey:@"class_id"];
                 NSLog(@"%@",strclass_id);
                 NSString *strclass_name = [dict objectForKey:@"class_name"];
                 NSString *strsec_name = [dict objectForKey:@"sec_name"];
                 NSString *strday = [dict objectForKey:@"day"];
                 NSString *strsubject_name = [dict objectForKey:@"subject_name"];
                 NSString *strtime_date = [dict objectForKey:@"time_date"];
                 NSString *strcomments = [dict objectForKey:@"comments"];
                 NSString *strremarks = [dict objectForKey:@"remarks"];
                 NSString *strstatus = [dict objectForKey:@"status"];
                 NSLog(@"%@",strstatus);

                 NSString *strclass_sec_name = [NSString stringWithFormat:@"%@ -%@",strclass_name,strsec_name];
                 
                 [class_section_name addObject:strclass_sec_name];
                 [subject_name addObject:strsubject_name];
                 [day addObject:strday];
                 [date_time addObject:strtime_date];
                 
                 [comments addObject:strcomments];
                 [remarks addObject:strremarks];

             }
             [self.tableview reloadData];
             
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
    return [class_section_name count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    TeacherTimeTableNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.className.text = [class_section_name objectAtIndex:indexPath.row];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    cell.dayLabel.text = [day objectAtIndex:indexPath.row];
    cell.dateLabel.text = [date_time objectAtIndex:indexPath.row];

    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
        return cell;
        
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    TeacherTimeTableNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *class_name = [class_section_name objectAtIndex:indexPath.row];;
    NSString *subjec_name = [subject_name objectAtIndex:indexPath.row];
    NSString *strday = [day objectAtIndex:indexPath.row];
    NSString *strdate = [date_time objectAtIndex:indexPath.row];
    NSString *period = [NSString stringWithFormat:@"%@  %@",strday,strdate];
    NSString *details = [comments objectAtIndex:indexPath.row];
    NSString *remarks_obj = [remarks objectAtIndex:indexPath.row];

    [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"class_section_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_name_key"];
    [[NSUserDefaults standardUserDefaults]setObject:details forKey:@"details_key"];
    [[NSUserDefaults standardUserDefaults]setObject:remarks_obj forKey:@"remarks_key"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherTimeTableNotesView *teacherTimeTableNotesView = (TeacherTimeTableNotesView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableNotesView"];
    [self.navigationController pushViewController:teacherTimeTableNotesView animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
