//
//  AdminResultView.m
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminResultView.h"

@interface AdminResultView ()
{
    AppDelegate *appDel;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;
    NSString *tmpString1;
    
    NSMutableArray *Fromdate;
    NSMutableArray *MarkStatus;
    NSMutableArray *Todate;
    NSMutableArray *classmaster_id;
    NSMutableArray *exam_id;
    NSMutableArray *exam_name;
    NSMutableArray *exam_year;

    NSMutableArray *is_internal_external;

}
@end

@implementation AdminResultView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
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
            [self.sidebarBtn setTarget: self.revealViewController];
            [self.sidebarBtn setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
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
    
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    
    Fromdate = [[NSMutableArray alloc]init];
    MarkStatus = [[NSMutableArray alloc]init];
    Todate = [[NSMutableArray alloc]init];
    classmaster_id = [[NSMutableArray alloc]init];
    exam_id = [[NSMutableArray alloc]init];
    exam_name = [[NSMutableArray alloc]init];
    exam_year = [[NSMutableArray alloc]init];
    is_internal_external = [[NSMutableArray alloc]init];

//    SWRevealViewController *revealController = [self revealViewController];
//    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
//    tap.delegate = self;
//    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _classOtlet.layer.borderColor = [UIColor colorWithRed:64/255.0f green:64/255.0f blue:64/255.0f alpha:1.0].CGColor;
  //  _classOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classOtlet.layer.borderWidth = 1.0f;
    [_classOtlet.layer setCornerRadius:10.0f];
    
    _sectionOtlet.layer.borderColor = [UIColor colorWithRed:64/255.0f green:64/255.0f blue:64/255.0f alpha:1.0].CGColor;
  //  _sectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionOtlet.layer.borderWidth = 1.0f;
    [_sectionOtlet.layer setCornerRadius:10.0f];
    
    self.tableView.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Section_Value"];

}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)sectionBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Section" forKey:@"sec_class"];

    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Section_btn_tapped"];
    
    // NSString *class_Value = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"]
    ;
    
//    NSString *classStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_btn_tapped"];
    
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
             
             [self->sec_id removeAllObjects];
             [self->sec_name removeAllObjects];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *se_id = [dict objectForKey:@"sec_id"];
                     NSString *se_name = [dict objectForKey:@"sec_name"];
                     
                     [self->sec_id addObject:se_id];
                     [self->sec_name addObject:se_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:self->sec_id forKey:@"admin_sec_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:self->sec_name forKey:@"admin_sec_name"];
                 
                 
                 if(self->dropdown == nil)
                 {
                     CGFloat f = 300;
                     self->dropdown = [[NIDropDown alloc]showDropDown:sender :&f :self->sec_name :nil :@"down" :self.view];
                     self->dropdown.delegate = self;
                     
                 }
                 else {
                     [self->dropdown hideDropDown:sender];
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
    if(dropdown == nil)
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
        dropdown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down" :self.view];
        [_sectionOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
        dropdown.delegate = self;
        
    }
    else {
        [dropdown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
    
}
-(void)rel
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"dropDownKey"];
    
    if ([str isEqualToString:@"hide"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"dropDownKey"];
        dropdown = nil;
    }
    else
    {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"sec_class"];
        if ([str isEqualToString:@"Section"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"sec_class"];
            
            [self getResultDetails];
        }
        else
        {
            dropdown = nil;
            
        }
    }
}
-(void)getResultDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDel.class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_class_id"];
    
    NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
    
    NSArray *admin_sec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_sec_name"];
    
    NSUInteger fooIndex = [admin_sec_name indexOfObject:selected_Section];
    
    appDel.section_id = sec_id[fooIndex];
    
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
             
             [self->Fromdate removeAllObjects];
             [self->MarkStatus removeAllObjects];
             [self->Todate removeAllObjects];
             [self->classmaster_id removeAllObjects];
             [self->exam_id removeAllObjects];
             [self->exam_name removeAllObjects];
             [self->exam_year removeAllObjects];
             
             for (int i = 0;i < [Exams count] ; i++)
             {
                 NSDictionary *dict = [Exams objectAtIndex:i];
                 NSString *strFromdate = [dict objectForKey:@"Fromdate"];
                 NSString *strMarkStatus = [dict objectForKey:@"MarkStatus"];
                 NSString *strTodate = [dict objectForKey:@"Todate"];
                 NSString *strclassmaster_id = [dict objectForKey:@"classmaster_id"];
                 NSString *strexam_id = [dict objectForKey:@"exam_id"];
                 NSString *strexam_name = [dict objectForKey:@"exam_name"];
                 NSString *strexam_year = [dict objectForKey:@"exam_year"];
                 NSString *strinternal_external = [dict objectForKey:@"is_internal_external"];

                 [self->Fromdate addObject:strFromdate];
                 [self->MarkStatus addObject:strMarkStatus];
                 [self->Todate addObject:strTodate];
                 [self->classmaster_id addObject:strclassmaster_id];
                 [self->exam_id addObject:strexam_id];
                 [self->exam_name addObject:strexam_name];
//               [exam_year addObject:strexam_year];
                 [self->is_internal_external addObject:strinternal_external];

             }
             
             self->dropdown = nil;

             self.tableView.hidden = NO;
             
             [self.tableView reloadData];
             
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
    AdminResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.titleLabel.text = [exam_name objectAtIndex:indexPath.row];
    cell.fromLabel.text =  [NSString stringWithFormat:@"%@ %@ %@",[Fromdate objectAtIndex:indexPath.row],@"to",[Todate objectAtIndex:indexPath.row]];
//    cell.toLabel.text = ;
    cell.examId.text = [exam_id objectAtIndex:indexPath.row];
    
    if ([cell.fromLabel.text isEqualToString:@""])
    {
        cell.calenderImg.hidden = YES;
        cell.seprateLabel.hidden = YES;
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
    
    NSLog(@"%@",appDel.exam_id);
    
    [[NSUserDefaults standardUserDefaults]setObject:adminExam.examId.text forKey:@"examIDValueKey"];
    
    NSLog(@"%@",appDel.exam_id);

    [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];
    
    NSUInteger index = [exam_id indexOfObject:adminExam.examId.text];
    
    NSString *str = is_internal_external[index];
    
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"is_internal_external_key"];
//
//    if ([str isEqualToString:@"0"])
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ExamTestMarkView *examTestMarkView = (ExamTestMarkView *)[storyboard instantiateViewControllerWithIdentifier:@"ExamTestMarkView"];
//        [self.navigationController pushViewController:examTestMarkView animated:YES];
//
//    }
//    else
//    {
        [self performSegueWithIdentifier:@"to_result_studentList" sender:self];

//    }
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
