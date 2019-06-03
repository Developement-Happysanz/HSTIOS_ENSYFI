//
//  AdminStudentViewController.m
//  EducationApp
//
//  Created by HappySanz on 19/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminStudentViewController.h"
#import "NIDropDown.h"

@interface AdminStudentViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;

    NSMutableArray *admisn_no;
    NSMutableArray *admisn_year;
    NSMutableArray *enroll_id;
    NSMutableArray *name;
    NSMutableArray *sex;
    NSMutableArray *class_id_Arr;

}
@end

@implementation AdminStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    
    admisn_no = [[NSMutableArray alloc]init];
    admisn_year = [[NSMutableArray alloc]init];
    enroll_id = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    sex = [[NSMutableArray alloc]init];
    class_id_Arr = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _classBtnOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classBtnOtlet.layer.borderWidth = 1.0f;
    [_classBtnOtlet.layer setCornerRadius:10.0f];
    
    _sectionBtnOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _sectionBtnOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionBtnOtlet.layer.borderWidth = 1.0f;
    [_sectionBtnOtlet.layer setCornerRadius:10.0f];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"class_btn_tapped"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Section_Value"];

    self.tableView.hidden = YES;

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
        
//        NSString *class_btn_tapped = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_btn_tapped"];
        NSString *selected_class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Class_Value"];
        
        
        if (![selected_class_name isEqualToString:@""])
        {
            
            NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
            
            NSUInteger fooIndex = [class_name indexOfObject:selected_class_name];
            
            NSArray *admin_class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_id"];
            NSString *tmpString1 = admin_class_id[fooIndex];
            
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
            NSString *forSections = @"/apiadmin/get_all_sections";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forSections, nil];
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
                         CGFloat f = 100;
                         dropDown = [[NIDropDown alloc]showDropDown:sender :&f :sec_name :nil :@"down"];
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
        [admisn_no removeAllObjects];
        [admisn_year removeAllObjects];
        [enroll_id removeAllObjects];
        [name removeAllObjects];
        [sex removeAllObjects];
        [class_id_Arr removeAllObjects];
        
        [self.tableView reloadData];
        
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down"];
        [_sectionBtnOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionBtnOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
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
            
            [self getStudentDetails];
        }
        else
        {
            dropDown = nil;

        }
    }
}
-(void)getStudentDetails
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
    NSString *forEvent = @"/apiadmin/get_all_students_in_classes";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *data = [responseObject objectForKey:@"data"];
         
         [admisn_no removeAllObjects];
         [admisn_year removeAllObjects];
         [enroll_id removeAllObjects];
         [name removeAllObjects];
         [sex removeAllObjects];
         [class_id_Arr removeAllObjects];

         
         if ([msg isEqualToString:@"success"])
         {
             for (int i = 0;i < [data count] ; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *stradmisn_no = [dict objectForKey:@"admisn_no"];
                 NSString *stradmisn_year = [dict objectForKey:@"admisn_year"];
                 NSString *strenroll_id = [dict objectForKey:@"enroll_id"];
                 NSString *strname = [dict objectForKey:@"name"];
                 NSString *strsex = [dict objectForKey:@"sex"];
                 NSString *strclassId = [dict objectForKey:@"class_id"];

                 [admisn_no addObject:stradmisn_no];
                 [admisn_year addObject:stradmisn_year];
                 [enroll_id addObject:strenroll_id];
                 [name addObject:strname];
                 [sex addObject:strsex];
                 [class_id_Arr addObject:strclassId];
                 
             }
             
             
             dropDown = nil;
             
             self.tableView.hidden = NO;
             
             [self.tableView reloadData];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         if ([data count]== 0)
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
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return name.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        AdminStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        // Configure the cell.....
        
        cell.rollNumber.text = [NSString stringWithFormat:@"%li", indexPath.row +1];
        //[enroll_id objectAtIndex:indexPath.row];
        cell.studentName.text = [name objectAtIndex:indexPath.row];
        cell.admisionNumber.text = [admisn_no objectAtIndex:indexPath.row];
    
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 49;
        
    }
    else
    {
        return 49;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

    AdminStudentTableViewCell *adminstudent = [tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger index_student_id = [name indexOfObject:adminstudent.studentName.text];
    
    appDel.student_id = enroll_id[index_student_id];
    
   // appDel.student_id = adminstudent.rollNumber.text;
    
    NSUInteger index = [name indexOfObject:adminstudent.studentName.text];
    
    appDel.class_id = class_id_Arr[index];
    
    [self performSegueWithIdentifier:@"to_adminStudentProfile" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
