//
//  AdminExamViewController.m
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminExamViewController.h"

@interface AdminExamViewController ()
{
    AppDelegate *appDel;
    NSString *tmpString1;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;
    
    NSMutableArray *Fromdate;
    NSMutableArray *MarkStatus;
    NSMutableArray *Todate;
    NSMutableArray *classmaster_id;
    NSMutableArray *exam_id;
    NSMutableArray *exam_name;
    NSMutableArray *exam_year;

}
@end

@implementation AdminExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    Fromdate = [[NSMutableArray alloc]init];
    MarkStatus = [[NSMutableArray alloc]init];
    Todate = [[NSMutableArray alloc]init];
    classmaster_id = [[NSMutableArray alloc]init];
    exam_id = [[NSMutableArray alloc]init];
    exam_name = [[NSMutableArray alloc]init];
    exam_year = [[NSMutableArray alloc]init];
    
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];


    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"view_selection"];
    
    if ([str isEqualToString:@"mainMenu"])
    {
        UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-01.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
        button2.tintColor = UIColor.whiteColor;
        self.navigationItem.leftBarButtonItem = button2;
    }
    else
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if (revealViewController)
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
    _classOtlet.layer.borderColor = [UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1.0].CGColor;
  //  _classOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classOtlet.layer.borderWidth = 1.0f;
    [_classOtlet.layer setCornerRadius:10.0f];
    
    _sectionOtlet.layer.borderColor = [UIColor colorWithRed:154/255.0f green:154/255.0f blue:154/255.0f alpha:1.0].CGColor;
   // _sectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionOtlet.layer.borderWidth = 1.0f;
    [_sectionOtlet.layer setCornerRadius:10.0f];
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    
    self.tableView.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Section_Value"];

}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (IBAction)sectionBtn:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Section" forKey:@"sec_class"];

    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Section_btn_tapped"];
    
   // NSString *classStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_btn_tapped"];
    
    NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
    
    
    if (![selected_class_name isEqualToString:@""])
    {
        NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
        
        NSUInteger fooIndex = [class_name indexOfObject:selected_class_name];
        
        NSArray *admin_class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_id"];
        tmpString1 = admin_class_id[fooIndex];
        
        [[NSUserDefaults standardUserDefaults]setObject:tmpString1 forKey:@"selected_class_id"];
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:tmpString1 forKey:@"class_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_list_exam_class = @"/apiadmin/get_all_sections";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_list_exam_class, nil];
        
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             
             NSLog(@"%@",responseObject);
             
             [sec_id removeAllObjects];
             [sec_name removeAllObjects];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *se_id = [dict objectForKey:@"sec_id"];
                     NSString *se_name = [dict objectForKey:@"sec_name"];
                     
                     [sec_id addObject:se_id];
                     [sec_name addObject:se_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:sec_id forKey:@"admin_sec_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:sec_name forKey:@"admin_sec_name"];
                 
                 
                 if(dropDown == nil)
                 {
                     CGFloat f = 300;
                     dropDown = [[NIDropDown alloc]showDropDown:sender :&f :sec_name :nil :@"down" :self.view];
                     dropDown.delegate = self;
                     
                 }
                 else {
                     [dropDown hideDropDown:sender];
                     [[NSUserDefaults standardUserDefaults]setObject:@"hide" forKey:@"dropDownKey"];
                     [self rel];
                 }
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No Data Found."
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
             
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
                                   message:@"Please Select Your Class"
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
- (IBAction)classBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"class_btn_tapped"];
    
    NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
    
    if(dropDown == nil)
    {
        [Fromdate removeAllObjects];
        [MarkStatus removeAllObjects];
        [Todate removeAllObjects];
        [classmaster_id removeAllObjects];
        [exam_id removeAllObjects];
        [exam_name removeAllObjects];
        [exam_year removeAllObjects];
        
        [self.tableView reloadData];
         
        CGFloat f = 300;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down" :self.view];
        [_sectionOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
    
}
-(void)getExamDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDel.class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_class_id"];
    
    NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
    
    NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
    
    NSUInteger secIndex = [admin_sec_name indexOfObject:selected_Section];
    
    appDel.section_id = sec_id[secIndex];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.section_id forKey:@"section_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *list_of_exams_class = @"/apiadmin/list_of_exams_class/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,list_of_exams_class, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *Exams = [responseObject objectForKey:@"Exams"];
         
         
         if ([msg isEqualToString:@"success"])
         {
             [Fromdate removeAllObjects];
             [MarkStatus removeAllObjects];
             [Todate removeAllObjects];
             [classmaster_id removeAllObjects];
             [exam_id removeAllObjects];
             [exam_name removeAllObjects];
             [exam_year removeAllObjects];
             
             for (int i = 0;i < [Exams count] ; i++)
             {
                 NSDictionary *dict = [Exams objectAtIndex:i];
                 NSString *strFromdate = [dict objectForKey:@"Fromdate"];
                 NSString *strMarkStatus = [dict objectForKey:@"MarkStatus"];
                 NSString *strTodate = [dict objectForKey:@"Todate"];
                 NSString *strclassmaster_id = [dict objectForKey:@"classmaster_id"];
                 NSString *strexam_id = [dict objectForKey:@"exam_id"];
                 NSString *strexam_name = [dict objectForKey:@"exam_name"];
//                 NSString *strexam_year = [dict objectForKey:@"exam_year"];
                 
                 [Fromdate addObject:strFromdate];
                 [MarkStatus addObject:strMarkStatus];
                 [Todate addObject:strTodate];
                 [classmaster_id addObject:strclassmaster_id];
                 [exam_id addObject:strexam_id];
                 [exam_name addObject:strexam_name];
//                 [exam_year addObject:strexam_year];
                 
             }
             
             dropDown = nil;

             self.tableView.hidden = NO;
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
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
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
-(void)rel
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"dropDownKey"];
    
    if ([str isEqualToString:@"hide"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"dropDownKey"];
        dropDown = nil;
    }
    else
    {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"sec_class"];
        if ([str isEqualToString:@"Section"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"sec_class"];
            
            [self getExamDetails];
        }
        else
        {
            dropDown = nil;
            
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return exam_name.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.titleLabel.text = [exam_name objectAtIndex:indexPath.row];
    NSString *dates = [NSString stringWithFormat:@"%@ - %@",[Fromdate objectAtIndex:indexPath.row],[Todate objectAtIndex:indexPath.row]];
    cell.fromDateLabel.text = dates;
    cell.examId.text = [exam_id objectAtIndex:indexPath.row];
    
    cell.cellView.layer.cornerRadius = 6.0f;

    if ([cell.fromDateLabel.text isEqualToString:@""])
    {
        cell.calenderImg.hidden = YES;
        cell.sepratorLabel.hidden = YES;
    }
    
    cell.cellView.layer.cornerRadius = 8.0f;
    cell.cellView.clipsToBounds = YES;
    
    cell.cellView.layer.shadowRadius  = 5.5f;
    cell.cellView.layer.shadowColor   = UIColor.grayColor.CGColor;
    cell.cellView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    cell.cellView.layer.shadowOpacity = 0.6f;
    cell.cellView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(cell.cellView.bounds, shadowInsets)];
    cell.cellView.layer.shadowPath    = shadowPath.CGPath;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 106;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    AdminExamTableViewCell *adminExam = [tableView cellForRowAtIndexPath:indexPath];
    
    appDel.exam_id = adminExam.examId.text;
    NSUInteger index = [exam_id indexOfObject:adminExam.examId.text];
    appDel.class_id = classmaster_id[index];
    NSLog(@"%@",appDel.class_id);
    
//  [[NSUserDefaults standardUserDefaults]setObject:strClassMaster_id forKey:@"ClassMaster_id_Key"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

    [[NSUserDefaults standardUserDefaults]setObject:@"adminExam" forKey:@"adminExamKey"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExamDetailViewController *MainExam = (ExamDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamDetailViewController"];
    [self.navigationController pushViewController:MainExam animated:YES];
}
@end
