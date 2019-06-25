//
//  GroupNotificationStatusViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "GroupNotificationStatusViewController.h"

@interface GroupNotificationStatusViewController ()
{
    AppDelegate *appDel;
    NSString *group_id_Flag;
    NSString *switchFlag;
    NSString *editButtonFlag;
    NSString *group_lead_id;
    NSString *buttonFlag;
    NSMutableArray *groupLead;
    NSMutableArray *userID;
    
    UIToolbar *toolBar;
    UIToolbar *listToolBar;
    UIPickerView *listpickerView;
    NSString *groupLeadName;

}
@end

@implementation GroupNotificationStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    
    groupLead = [[NSMutableArray alloc]init];
    userID = [[NSMutableArray alloc]init];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_list_exam_class = @"/apiadmin/get_allteachersuserid/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_list_exam_class, nil];
    
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *data = [responseObject objectForKey:@"teacherList"];
         
         [groupLead removeAllObjects];
         [userID removeAllObjects];
         
         if ([msg isEqualToString:@"Teacher Details"])
         {
             for (int i = 0;i < [data count] ; i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *name = [dict objectForKey:@"name"];
                 NSString *user_id = [dict objectForKey:@"user_id"];
                 
                
                 [groupLead addObject:name];
                 [userID addObject:user_id];
                 
             }
              [groupLead insertObject:@"Group Lead Name" atIndex:0];
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
    
    _updateOutlet.layer.cornerRadius = 8.0;
    _updateOutlet.clipsToBounds = YES;
    _titleTxtfield.delegate = self;
    
    _LeadTxtfield.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _LeadTxtfield.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _LeadTxtfield.layer.borderWidth = 1.0f;
    [_LeadTxtfield.layer setCornerRadius:10.0f];
    
    listpickerView = [[UIPickerView alloc] init];
    listpickerView.delegate = self;
    listpickerView.dataSource = self;
    [self.LeadTxtfield setInputView:listpickerView];
    
    listToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [listToolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedDate)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [listToolBar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    
    [self.LeadTxtfield setInputAccessoryView:listToolBar];
    
    self.titleTxtfield.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_Group_title"];
    self.deactiveLeadLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_lead_name"];
    self.statusLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_status"];
    
    self.titleTxtfield.enabled = NO;
    self.deactiveLeadLabel.enabled = NO;
    self.statusLabel.enabled = NO;
//    self.addMemberOutlet.enabled = YES;
//    self.notificationOutlet.enabled = YES;
    self.titleDownView.hidden = YES;
    self.LeadTxtfield.hidden = YES;
    self.dropDownImageView.hidden = YES;
    self.switchOutlet.hidden = YES;
    group_id_Flag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];
    group_lead_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_lead_id"];
    switchFlag = @"Active";
    NSString *stat_View = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([stat_View isEqualToString:@"teachers"])
    {

        [self.editButtonOutlet setEnabled:NO];
        [self.editButtonOutlet setTintColor: [UIColor clearColor]];
    }
    else
    {
        [self.editButtonOutlet setEnabled:YES];
        [self.editButtonOutlet setTintColor: [UIColor whiteColor]];
    }
    editButtonFlag = @"YES";
    buttonFlag = @"NO";
    [_updateOutlet setTitle:@"View Group Members" forState:UIControlStateNormal];
    
    self.LeadTxtfield.enabled = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == listpickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.LeadTxtfield isFirstResponder])
        {
            return [groupLead count];
        }
    }
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.LeadTxtfield isFirstResponder])
        {
            return groupLead[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.LeadTxtfield isFirstResponder])
        {
           groupLeadName = groupLead[row];
        }
    }
}
-(void)CancelButton
{
    if ([self.LeadTxtfield isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.LeadTxtfield resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
}
-(void)SelectedDate
{
    if ([self.LeadTxtfield isFirstResponder])
    {
        self.LeadTxtfield.text = groupLeadName;
        [self.LeadTxtfield resignFirstResponder];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButton:(id)sender
{
    NSString *stat_View  = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([stat_View isEqualToString:@"teachers"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"stat_user_type"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)switchButton:(id)sender
{
    if ([self.switchOutlet isOn])
    {
        switchFlag = @"Active";
    }
    else
    {
        switchFlag = @"Deactive";
    }
}
- (IBAction)editButton:(id)sender
{
    if ([editButtonFlag isEqualToString:@"YES"])
    {
        [_updateOutlet setTitle:@"Update" forState:UIControlStateNormal];
        self.updateOutlet.bounds = CGRectMake(139, 218, 98, 45);
        self.deactiveLeadLabel.hidden = YES;
        self.dropDownImageView.hidden = NO;
        self.titleTxtfield.userInteractionEnabled = YES;
        self.titleDownView.hidden = NO;
        self.LeadTxtfield.hidden = NO;
        self.LeadTxtfield.enabled = YES;
        self.statusLabel.hidden = YES;
        self.switchOutlet.hidden = NO;
        self.switchOutlet.enabled = YES;
       
        editButtonFlag = @"NO";
        buttonFlag = @"YES";
        [_titleTxtfield becomeFirstResponder];

    }
    else
    {
        [_titleTxtfield resignFirstResponder];
        self.updateOutlet.bounds = CGRectMake(52, 218, 271, 45);
        [_updateOutlet setTitle:@"View Group Members" forState:UIControlStateNormal];
        self.deactiveLeadLabel.hidden = NO;
        self.deactiveLeadLabel.enabled = NO;
        self.statusLabel.hidden = NO;
        self.statusLabel.enabled = YES;
        self.dropDownImageView.hidden = YES;
        self.titleDownView.hidden = NO;
        self.titleTxtfield.enabled = YES;
        self.deactiveLeadLabel.enabled = YES;
        self.LeadTxtfield.enabled = NO;
        self.LeadTxtfield.hidden = YES;
        self.switchOutlet.enabled = NO;
        self.switchOutlet.hidden = YES;
        editButtonFlag = @"YES";
        buttonFlag = @"NO";
    }
}

- (IBAction)updateButton:(id)sender
{
    if ([buttonFlag isEqualToString:@"YES"])
    {
        if ([self.LeadTxtfield.text isEqualToString:@""])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"group lead is empty"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([self.LeadTxtfield.text isEqualToString:@"Group Lead Name"])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Please Select the group lead"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [groupLead removeObjectAtIndex:0];
            NSUInteger index_student_id = [groupLead indexOfObject:self.LeadTxtfield.text];
            NSString *group_lead_id = userID[index_student_id];
            
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_id forKey:@"user_id"];
            [parameters setObject:group_id_Flag forKey:@"group_id"];
            [parameters setObject:self.titleTxtfield.text forKey:@"group_title"];
            [parameters setObject:group_lead_id forKey:@"group_lead_id"];
            [parameters setObject:switchFlag forKey:@"status"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            /* concordanate with baseurl */
            NSString *update_groupmaster = @"apiadmin/update_groupmaster";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,update_groupmaster, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 if ([msg isEqualToString:@"Group Master Updated"])
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [self dismissViewControllerAnimated:YES completion:nil];
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
        
    }
    else
    {
        [self performSegueWithIdentifier:@"viewGroupMembers" sender:self];
    }
}
    
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.titleTxtfield)
    {
        [_titleTxtfield resignFirstResponder];
    }
    return YES;
}

- (IBAction)notificationPageBTn:(id)sender
{
    [self performSegueWithIdentifier:@"to_notificationPage" sender:self];
}

- (IBAction)addButton:(id)sender
{
    [self performSegueWithIdentifier:@"addMembers" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
