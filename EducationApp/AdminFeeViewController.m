//
//  AdminFeeViewController.m
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminFeeViewController.h"

@interface AdminFeeViewController ()
{
    AppDelegate *appDel;
    NSString *tmpString1;
    NSMutableArray *sec_id;
    NSMutableArray *sec_name;
    
    NSMutableArray *term_name;
    NSMutableArray *due_date_from;
    NSMutableArray *due_date_to;
    NSMutableArray *fees_id;
    NSMutableArray *from_year;
    NSMutableArray *to_year;

}
@end

@implementation AdminFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    term_name = [[NSMutableArray alloc]init];
    due_date_from = [[NSMutableArray alloc]init];
    due_date_to = [[NSMutableArray alloc]init];
    fees_id = [[NSMutableArray alloc]init];
    from_year = [[NSMutableArray alloc]init];
    to_year = [[NSMutableArray alloc]init];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    sec_id = [[NSMutableArray alloc]init];
    sec_name = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    _classOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _classOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _classOtlet.layer.borderWidth = 1.0f;
    [_classOtlet.layer setCornerRadius:10.0f];
    
    _sectionOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _sectionOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _sectionOtlet.layer.borderWidth = 1.0f;
    [_sectionOtlet.layer setCornerRadius:10.0f];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selected_Class_Value"];
    
    self.tableView.hidden = YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (IBAction)classBTn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Class" forKey:@"sec_class"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"class_btn_tapped"];
    
    NSArray *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_class_name"];
    if(dropDown == nil)
    {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :class_name :nil :@"down"];
        [_sectionOtlet setTitle:@"Section" forState:UIControlStateNormal];
        _sectionOtlet.titleLabel.textColor = [UIColor colorWithRed:102/255.0f green:52/255.0f blue:102/255.0f alpha:1.0];
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)sectionBTn:(id)sender
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
             
             [sec_id removeAllObjects];
             [sec_name removeAllObjects];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             [sec_id removeAllObjects];
             [sec_name removeAllObjects];
             
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
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
//    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Section_btn_tapped"];
//    if ([str isEqualToString:@"YES"])
//    {
//        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"Section_btn_tapped"];
//        [self getTermList];
//        
//    }
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
            
            [self getTermList];
        }
        else
        {
            dropDown = nil;
            
        }
    }
}
-(void)getTermList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDel.class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_class_id"];
    
    NSString *selected_Section = [[NSUserDefaults standardUserDefaults]objectForKey:@"selected_Section_Value"];
    
    NSArray *admin_section_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"admin_section_id"];
    
    NSUInteger fooIndex = [admin_section_id indexOfObject:selected_Section];
    
    appDel.section_id = sec_id[fooIndex];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    [parameters setObject:appDel.section_id forKey:@"section_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_fees_master_class = @"/apiadmin/get_fees_master_class/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_fees_master_class, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *data = [responseObject objectForKey:@"data"];
         
         [due_date_from removeAllObjects];
         [due_date_to removeAllObjects];
         [fees_id removeAllObjects];
         [from_year removeAllObjects];
         [term_name removeAllObjects];
         [to_year removeAllObjects];
         
         if ([msg isEqualToString:@"success"])
         {
             
             for (int i = 0;i < [data count] ; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *strFromdate = [dict objectForKey:@"due_date_from"];
                 NSString *strTodate = [dict objectForKey:@"due_date_to"];
                 NSString *strfees_id = [dict objectForKey:@"fees_id"];
                 NSString *strfrom_year = [dict objectForKey:@"from_year"];
                 NSString *strterm_name = [dict objectForKey:@"term_name"];
                 NSString *strto_year = [dict objectForKey:@"to_year"];
                 
                 [due_date_from addObject:strFromdate];
                 [due_date_to addObject:strTodate];
                 [fees_id addObject:strfees_id];
                 [from_year addObject:strfrom_year];
                 [term_name addObject:strterm_name];
                 [to_year addObject:strto_year];
                 
             }
             
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [term_name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdminFeeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell.....
    
    cell.termName.text = [term_name objectAtIndex:indexPath.row];
    cell.fromdate.text = [due_date_from objectAtIndex:indexPath.row];
    cell.toDate.text = [due_date_to objectAtIndex:indexPath.row];
    
    cell.feeID.text = [fees_id objectAtIndex:indexPath.row];
    
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.cellView.layer.cornerRadius = 6.0f;
    
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
    
    AdminFeeViewCell *adminExam = [tableView cellForRowAtIndexPath:indexPath];
    
    [[NSUserDefaults standardUserDefaults]setObject:adminExam.feeID.text forKey:@"fees_id"];

    [self performSegueWithIdentifier:@"to_fess_status" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
