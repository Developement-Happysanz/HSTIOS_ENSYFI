//
//  TeachersTimeTableView.m
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeachersTimeTableView.h"

@interface TeachersTimeTableView ()
{
    AppDelegate *appDel;
    NSArray *docPaths;
    NSString *documentsDir;
    NSString *dbPath;
    FMDatabase *database;
    FMResultSet *rs;
}
@end

@implementation TeachersTimeTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"class_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"class_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"period_key"];
    
    NSString *strstat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([strstat_user_type isEqualToString:@"admin"])
    {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
        imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        self.navigationItem.leftBarButtonItem = backButton;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *strteacher_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_teacherid"];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:strteacher_id forKey:@"teacher_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_teacher = @"/apiteacher//disp_Timetable/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_teacher, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *teacherTimeTable = [responseObject objectForKey:@"timetableDetails"];
             if ([msg isEqualToString:@"View Timetable"])
             {
                 for (int i = 0;i < [teacherTimeTable count]; i++)
                 {
                     NSArray * arr = [teacherTimeTable objectAtIndex:i];
                     
                     NSString *str_class_id = [arr valueForKey:@"class_id"];
                     NSString *str_class_name = [arr valueForKey:@"class_name"];
                     NSString *str_day = [arr valueForKey:@"day"];
                     NSString *str_name = [arr valueForKey:@"name"];
                     NSLog(@"%@",str_name);
                     NSString *str_period = [arr valueForKey:@"period"];
                     NSString *str_sec_name = [arr valueForKey:@"sec_name"];
                     NSString *str_subject_id = [arr valueForKey:@"subject_id"];
                     NSString *str_subject_name = [arr valueForKey:@"subject_name"];
                     NSString *str_table_id = [arr valueForKey:@"table_id"];
                     NSLog(@"%@",str_table_id);
                     NSString *str_teacher_id = [arr valueForKey:@"teacher_id"];
                     NSLog(@"%@",str_teacher_id);
                     
                     if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayPeriod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         NSString *subject_id = str_subject_id;
                         [[NSUserDefaults standardUserDefaults]setObject: subject_id forKey:@"subject_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                         
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.mondayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tudesdayPeriod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.tuesdayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     
                     
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayPeriod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_id;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.wednesdayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursadayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursadayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.thursdayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.fdayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"1"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod1.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"2"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod2.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"3"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod3.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"4"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod4.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"5"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod5.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"6"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod6.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"7"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod7.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                     else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"8"])
                     {
                         NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                         self.satdayperiod8.text =str;
                         
                         NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                         NSString *class_id  = str_class_id;
                         NSString *subjec_name  = str_subject_name;
                         NSString *period = str_period;
                         
                         [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                         [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                     }
                 }
             }
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else
    {
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
        
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        rs = [database executeQuery:@"Select distinct table_id,class_id,subject_id,subject_name,teacher_id,name,day,period,sec_name,class_name from table_create_teacher_timetable"];
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"table_id :%@",[rs stringForColumn:@"table_id"]);
                NSString *str_table_id = [rs stringForColumn:@"table_id"];
                NSLog(@"%@",str_table_id);
                
                NSString *str_class_id = [rs stringForColumn:@"class_id"];
                NSLog(@"%@",str_class_id);
                
                NSString *str_subject_id = [rs stringForColumn:@"subject_id"];
                NSLog(@"%@",str_subject_id);
                
                NSString *str_subject_name = [rs stringForColumn:@"subject_name"];
                NSLog(@"%@",str_subject_name);
                
                NSString *str_teacher_id = [rs stringForColumn:@"teacher_id"];
                NSLog(@"%@",str_teacher_id);
                
                NSString *str_name = [rs stringForColumn:@"name"];
                NSLog(@"%@",str_name);
                
                NSString *str_day = [rs stringForColumn:@"day"];
                NSLog(@"%@",str_day);
                
                NSString *str_period = [rs stringForColumn:@"period"];
                NSLog(@"%@",str_period);
                
                NSString *str_sec_name = [rs stringForColumn:@"sec_name"];
                
                NSString *str_class_name = [rs stringForColumn:@"class_name"];
                NSLog(@"%@",str_class_name);
                
                if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayPeriod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    NSString *subject_id = str_subject_id;
                    [[NSUserDefaults standardUserDefaults]setObject: subject_id forKey:@"subject_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                    
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"1"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.mondayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tudesdayPeriod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"2"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.tuesdayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
                
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayPeriod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_id;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"3"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.wednesdayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursadayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursadayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"4"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.thursdayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"5"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.fdayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"1"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod1.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"2"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod2.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"3"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod3.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"4"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod4.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"5"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod5.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"6"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod6.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"7"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod7.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                else if ([str_day isEqualToString:@"6"] && [str_period isEqualToString:@"8"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@ %@ \n%@",str_class_name,str_sec_name,str_subject_name];
                    self.satdayperiod8.text =str;
                    
                    NSString *strclasName = [NSString stringWithFormat:@"%@ %@",str_class_name,str_sec_name];
                    NSString *class_id  = str_class_id;
                    NSString *subjec_name  = str_subject_name;
                    NSString *period = str_period;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:strclasName forKey:@"clasName_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:subjec_name forKey:@"subject_name_key"];
                    [[NSUserDefaults standardUserDefaults]setObject:period forKey:@"period_key"];
                }
                
            }
        }
        [database close];
    }
}
- (IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidLayoutSubviews
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
        {
            self.scrollView.contentSize = CGSizeMake(1753,400);
            
        }
        else
        {
            self.scrollView.contentSize = CGSizeMake(1453,400);
            
        }
    }
    else
    {
        self.scrollView.contentSize = CGSizeMake(1053,400);
        
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

- (IBAction)mondayPeriod1Btn:(id)sender
{
    if (![self.mondayPeriod1.text isEqualToString:@""])
    {
        
        NSString *day = @"1";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;

        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)tudesdayperiod1Btn:(id)sender
{
    if (![self.tudesdayPeriod1.text isEqualToString:@""])
    {
        
        NSString *day = @"2";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;

        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            
        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)wednesdayPeriod1Btn:(id)sender
{
    if (![self.wednesdayPeriod1.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)thursadyaperiod1Btn:(id)sender
{
    if (![self.thursdayperiod1.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)fdayperiod1Btn:(id)sender
{
    if (![self.fdayperiod1.text isEqualToString:@""])
    {
        NSString *day = @"5";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)satdayperiod1Btn:(id)sender
{
    if (![self.satdayperiod1.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod2Btn:(id)sender
{
    if (![self.mondayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"1";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)tuesdayperiod2Btn:(id)sender
{
    if (![self.tuesdayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"2";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)wednesdayperiod2Btn:(id)sender
{
    if (![self.wednesdayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)thursadayperiod2Btn:(id)sender
{
    if (![self.thursdayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)fdayPeriod2Btn:(id)sender
{
    if (![self.fdayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"5";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)satdayperiod2Btn:(id)sender
{
    if (![self.satdayperiod2.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod3Btn:(id)sender
{
    if (![self.mondayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"1";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            
        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuesdayperiod3Btn:(id)sender
{
    if (![self.tuesdayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"2";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod3Btn:(id)sender
{
    if (![self.wednesdayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursadayperiod3Btn:(id)sender
{
    if (![self.thursdayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fdayperiod3Btn:(id)sender
{
    if (![self.fdayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"5";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod3Btn:(id)sender
{
    if (![self.satdayperiod3.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod4Btn:(id)sender
{
    if (![self.mondayperiod4.text isEqualToString:@""])
    {
        NSString *day = @"1";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuesdayperiod4Btn:(id)sender
{
    if (![self.tuesdayperiod4.text isEqualToString:@""])
    {
        NSString *day = @"2";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod4Btn:(id)sender
{
    if (![self.wednesdayperiod4.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursadayperiod4Btn:(id)sender
{
    if (![self.thursadayperiod4.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fdayperiod4Btn:(id)sender
{
    if (![self.fdayperiod4.text isEqualToString:@""])
    {
        
        NSString *day = @"5";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod4Btn:(id)sender
{
    if (![self.satdayperiod4.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod5Btn:(id)sender
{
    if (![self.mondayperiod5.text isEqualToString:@""])
    {
        
        NSString *day = @"1";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuesdayperiod5Btn:(id)sender
{
    if (![self.tuesdayperiod5.text isEqualToString:@""])
    {
        
        NSString *day = @"2";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod5Btn:(id)sender
{
    if (![self.wednesdayperiod5.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursdayperiod5Btn:(id)sender
{
    if (![self.thursdayperiod5.text isEqualToString:@""])
    {
        
        NSString *day = @"4";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fdayperiod5Btn:(id)sender
{
    if (![self.fdayperiod5.text isEqualToString:@""])
    {
        
        NSString *day = @"5";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod5Btn:(id)sender
{
    if (![self.satdayperiod5.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"5";
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod6Btn:(id)sender
{
    if (![self.mondayperiod6.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"1";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuesdayperiod6Btn:(id)sender
{
    if (![self.tuesdayperiod6.text isEqualToString:@""])
    {
        
        NSString *day = @"6";
        NSString *period = @"2";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod6Btn:(id)sender
{
    if (![self.wednesdayperiod6.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"3";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursdayperiod6Btn:(id)sender
{
    if (![self.thursdayperiod6.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"4";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fsayperiod6Btn:(id)sender
{
    if (![self.fdayperiod6.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"5";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod6Btn:(id)sender
{
    if (![self.satdayperiod6.text isEqualToString:@""])
    {
        
        NSString *day = @"6";
        NSString *period = @"6";
        

        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod7Btn:(id)sender
{
    if (![self.mondayperiod7.text isEqualToString:@""])
    {
        
        NSString *day = @"1";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuedayperiod7Btn:(id)sender
{
    if (![self.tuesdayperiod7.text isEqualToString:@""])
    {
        NSString *day = @"2";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod7Btn:(id)sender
{
    if (![self.wednesdayperiod7.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursdayperiod7Btn:(id)sender
{
    if (![self.thursadayperiod7.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fdayperiod7Btn:(id)sender
{
    if (![self.fdayperiod7.text isEqualToString:@""])
    {
        
        NSString *day = @"5";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod7Btn:(id)sender
{
    if (![self.satdayperiod7.text isEqualToString:@""])
    {
        
        NSString *day = @"6";
        NSString *period = @"7";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)mondayperiod8Btn:(id)sender
{
    if (![self.mondayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"1";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)tuesdayperiod8Btn:(id)sender
{
    if (![self.tuesdayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"2";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)wednesdayperiod8Btn:(id)sender
{
    if (![self.wednesdayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"3";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)thursdayperiod8Btn:(id)sender
{
    if (![self.thursdayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"4";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)fdayperiod8Btn:(id)sender
{
    if (![self.fdayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"5";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];

        }
        [database close];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}

- (IBAction)satdayperiod8Btn:(id)sender
{
    if (![self.satdayperiod8.text isEqualToString:@""])
    {
        NSString *day = @"6";
        NSString *period = @"8";
        
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        
        FMResultSet *rs = [database executeQuery:@"Select class_id,class_name,subject_id,subject_name,period from table_create_teacher_timetable where day = ? AND period = ?",day,period];
        
        NSString *class_id;
        NSString *subject_id;
        NSString *subject_name;
        NSString *strperiod;
        NSString *class_name;
        
        
        if(rs)
        {
            while ([rs next])
            {
                NSLog(@"class_id :%@",[rs stringForColumn:@"class_id"]);
                class_id =[rs stringForColumn:@"class_id"];
                class_name = [rs stringForColumn:@"class_name"];
                subject_id = [rs stringForColumn:@"subject_id"];
                subject_name = [rs stringForColumn:@"subject_name"];
                strperiod = [rs stringForColumn:@"period"];
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"class_id_key"];
            [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"clasName_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_name forKey:@"subject_name_key"];
            [[NSUserDefaults standardUserDefaults]setObject:strperiod forKey:@"period_key"];
            [[NSUserDefaults standardUserDefaults]setObject:subject_id forKey:@"subject_id_key"];
         
        }
        [database close];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherTimeTableAddNotes *teacherTimeTableAddNotes = (TeacherTimeTableAddNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableAddNotes"];
        [self.navigationController pushViewController:teacherTimeTableAddNotes animated:YES];
    }
}
- (IBAction)viewBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherTimeTableNotes *teacherTimeTableNotes = (TeacherTimeTableNotes *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherTimeTableNotes"];
    [self.navigationController pushViewController:teacherTimeTableNotes animated:YES];
}
@end
