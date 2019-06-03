//
//  GroupNotificationAddmember.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 10/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "GroupNotificationAddmember.h"

@interface GroupNotificationAddmember ()
{
    AppDelegate *appDel;
    NSMutableArray *selectorList;
    NSMutableArray *name;
    NSMutableArray *user_id;
    NSMutableArray *enroll_id;
    NSMutableArray *role_id;
    NSMutableArray *staff_status;
    NSMutableArray *status;
    NSMutableArray *user_type_name;
    NSMutableArray *class_sec_id;
    NSMutableArray *class_section;
    NSMutableArray *Selected_ids;
    NSMutableArray *Status;
    NSString *selectorFlag;
    NSString *textfieldFlag;
    NSString *group_idFlag;
    NSString *checkBoxFlag;
    NSString *statusFlag;
    NSString *selectAllFlag;

}
@end

@implementation GroupNotificationAddmember

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    name = [[NSMutableArray alloc]init];
    user_id = [[NSMutableArray alloc]init];
    enroll_id = [[NSMutableArray alloc]init];
    class_sec_id = [[NSMutableArray alloc]init];
    class_section = [[NSMutableArray alloc]init];
    selectorList = [[NSMutableArray alloc]init];
    Selected_ids = [[NSMutableArray alloc]init];
    role_id = [[NSMutableArray alloc]init];
    staff_status = [[NSMutableArray alloc]init];
    status = [[NSMutableArray alloc]init];
    user_type_name = [[NSMutableArray alloc]init];
    Status = [[NSMutableArray alloc]init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"1" forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *get_allteachersuserid = @"apiadmin/list_roles";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allteachersuserid, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         [role_id removeAllObjects];
         [staff_status removeAllObjects];
         [status removeAllObjects];
         [user_type_name removeAllObjects];
         
         if ([msg isEqualToString:@"Role List"])
         {
             NSArray *dataArray = [responseObject valueForKey:@"roleList"];
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *Data = [dataArray objectAtIndex:i];
                 NSString *strRole_id = [Data valueForKey:@"role_id"];
                 NSString *strStaff_status = [Data valueForKey:@"staff_status"];
                 NSString *strStatus = [Data valueForKey:@"status"];
                 NSString *strUser_type_name = [Data valueForKey:@"user_type_name"];
                 
                 [role_id addObject:strRole_id];
                 [staff_status addObject:strStaff_status];
                 [status addObject:strStatus];
                 [user_type_name addObject:strUser_type_name];
             }
                 [pickerView reloadAllComponents];
                 [pickerView selectRow:0 inComponent:0 animated:YES];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    _teacherTxtField.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _teacherTxtField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _teacherTxtField.layer.borderWidth = 1.0f;
    [_teacherTxtField.layer setCornerRadius:10.0f];
    _studentTxtField.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _studentTxtField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _studentTxtField.layer.borderWidth = 1.0f;
    [_studentTxtField.layer setCornerRadius:10.0f];
    self.titleTxtField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_Group_title"];
    self.leadName.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_lead_name"];
    group_idFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];
    statusFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_status"];
    self.studentTxtField.hidden = YES;
    self.studentArrowImage.hidden = YES;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedTeacherName)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.teacherTxtField setInputView:pickerView];
    [self.studentTxtField setInputView:pickerView];
    [self.teacherTxtField setInputAccessoryView:toolbar];
    [self.studentTxtField setInputAccessoryView:toolbar];
    [pickerView reloadAllComponents];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    [self.checkBoxOutlet setEnabled:NO];
    [self.checkBoxOutlet setTintColor: [UIColor clearColor]];
    checkBoxFlag = @"YES";
}
-(void)selectedValue
{
    if ([self.teacherTxtField.text isEqualToString:@"Teachers"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSUInteger indexValue = [user_type_name indexOfObject:self.teacherTxtField.text];
        NSString *strRole_id = role_id[indexValue];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:group_idFlag forKey:@"group_id"];
        [parameters setObject:strRole_id forKey:@"group_user_type"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *gn_stafflist = @"apiadmin/gn_stafflist";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,gn_stafflist, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             
             [name removeAllObjects];
             [user_id removeAllObjects];
             [status removeAllObjects];
             [Selected_ids removeAllObjects];
             
             if ([msg isEqualToString:@"Records Found"])
             {
                 NSArray *dataArray = [responseObject valueForKey:@"gnStafflist"];
                 for (int i = 0;i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strName = [Data valueForKey:@"name"];
                     NSString *strUser_id = [Data valueForKey:@"user_id"];
                     NSString *strStatus = [Data valueForKey:@"Status"];
                     
                     [name addObject:strName];
                     [user_id addObject:strUser_id];
                     [status addObject:strStatus];
                 }
                    [pickerView reloadAllComponents];
                    [pickerView selectRow:0 inComponent:0 animated:YES];
                     if ([status containsObject:@"0"])
                     {
                         [self.checkBoxOutlet setEnabled:YES];
                         [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                         UIImage *image = [UIImage imageNamed:@"select_all deselect.png"];
                         [_checkBoxOutlet setImage:image];
                     }
                     else
                     {
                         [self.checkBoxOutlet setEnabled:YES];
                         [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                         UIImage *image = [UIImage imageNamed:@"select_all"];
                         [_checkBoxOutlet setImage:image];
                     }
                    self.tableView.hidden = NO;
                    [self.tableView reloadData];
             }
             else
             {
                 [self.checkBoxOutlet setEnabled:NO];
                 [self.checkBoxOutlet setTintColor: [UIColor clearColor]];
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No data found"
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
    else if ([self.teacherTxtField.text isEqualToString:@"Board Members"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSUInteger indexValue = [user_type_name indexOfObject:self.teacherTxtField.text];
        NSString *strRole_id = role_id[indexValue];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:group_idFlag forKey:@"group_id"];
        [parameters setObject:strRole_id forKey:@"group_user_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_allstaffsuserid = @"apiadmin/gn_stafflist";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allstaffsuserid, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             
             [name removeAllObjects];
             [user_id removeAllObjects];
             [status removeAllObjects];
             [Selected_ids removeAllObjects];

             if ([msg isEqualToString:@"Records Found"])
             {
                 NSArray *dataArray = [responseObject valueForKey:@"gnStafflist"];
                 for (int i = 0;i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strName = [Data valueForKey:@"name"];
                     NSString *strUser_id = [Data valueForKey:@"user_id"];
                     NSString *strStatus = [Data valueForKey:@"Status"];

                     [name addObject:strName];
                     [user_id addObject:strUser_id];
                     [status addObject:strStatus];
                 }
                     [pickerView reloadAllComponents];
                     [pickerView selectRow:0 inComponent:0 animated:YES];
                     if ([status containsObject:@"0"])
                     {
                         [self.checkBoxOutlet setEnabled:YES];
                         [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                         UIImage *image = [UIImage imageNamed:@"select_all deselect.png"];
                         [_checkBoxOutlet setImage:image];
                     }
                     else
                     {
                         [self.checkBoxOutlet setEnabled:YES];
                         [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                         UIImage *image = [UIImage imageNamed:@"select_all"];
                         [_checkBoxOutlet setImage:image];
                     }
                     self.tableView.hidden = NO;
                     [self.tableView reloadData];
             }
             else
             {
                 [self.checkBoxOutlet setEnabled:NO];
                 [self.checkBoxOutlet setTintColor: [UIColor clearColor]];
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No data found"
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
    else if ([self.teacherTxtField.text isEqualToString:@"Students"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"1" forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_allstudentuserid = @"apiadmin/list_class_section";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allstudentuserid, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             [class_sec_id removeAllObjects];
             [class_section removeAllObjects];
             if ([msg isEqualToString:@"Class and Sections"])
             {
                 NSArray *dataArray = [responseObject valueForKey:@"listClasssection"];
                 for (int i = 0;i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strClass_sec_id = [Data valueForKey:@"class_sec_id"];
                     NSString *strClass_section = [Data valueForKey:@"class_section"];
                     
                     [class_sec_id addObject:strClass_sec_id];
                     [class_section addObject:strClass_section];
                 }
                     [class_section insertObject:@"Select Your Class" atIndex:0];
                     [pickerView reloadAllComponents];
                     [pickerView selectRow:0 inComponent:0 animated:YES];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No data found"
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
    else if ([self.teacherTxtField.text isEqualToString:@"Parents"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"1" forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_allstudentuserid = @"apiadmin/list_class_section";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allstudentuserid, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             [class_sec_id removeAllObjects];
             [class_section removeAllObjects];
             if ([msg isEqualToString:@"Class and Sections"])
             {
                 NSArray *dataArray = [responseObject valueForKey:@"listClasssection"];
                 for (int i = 0;i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strClass_sec_id = [Data valueForKey:@"class_sec_id"];
                     NSString *strClass_section = [Data valueForKey:@"class_section"];
                     
                     [class_sec_id addObject:strClass_sec_id];
                     [class_section addObject:strClass_section];
                 }
                 [class_section insertObject:@"Select Your Class" atIndex:0];
                 [pickerView reloadAllComponents];
                 [pickerView selectRow:0 inComponent:0 animated:YES];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No data found"
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
}
-(void)studentsList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (![self.studentTxtField.text isEqualToString:@"Select Your Class"])
    {
        NSUInteger indexValue = [user_type_name indexOfObject:self.teacherTxtField.text];
        NSString *strRole_id = role_id[indexValue];
        NSUInteger index = [class_section indexOfObject:self.studentTxtField.text];
        NSString *strclass_sec_id = class_sec_id[index];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:group_idFlag forKey:@"group_id"];
        [parameters setObject:strRole_id forKey:@"group_user_type"];
        [parameters setObject:strclass_sec_id forKey:@"class_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *get_allstudentuserid = @"apiadmin/gn_studentlist";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allstudentuserid, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             
             [name removeAllObjects];
             [user_id removeAllObjects];
             [status removeAllObjects];
             [Selected_ids removeAllObjects];

             if ([msg isEqualToString:@"Records Found"])
             {
                 NSArray *dataArray = [responseObject valueForKey:@"gnStudentlist"];
                 for (int i = 0;i < [dataArray count];i++)
                 {
                     NSArray *Data = [dataArray objectAtIndex:i];
                     NSString *strname = [Data valueForKey:@"name"];
                     NSString *strUser_id = [Data valueForKey:@"user_id"];
                     NSString *strStatus = [Data valueForKey:@"Status"];

                     [name addObject:strname];
                     [user_id addObject:strUser_id];
                     [status addObject:strStatus];
                     
                 }
                 [pickerView reloadAllComponents];
                 [pickerView selectRow:0 inComponent:0 animated:YES];
                 if ([status containsObject:@"0"])
                 {
                     [self.checkBoxOutlet setEnabled:YES];
                     [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                     UIImage *image = [UIImage imageNamed:@"select_all deselect.png"];
                     [_checkBoxOutlet setImage:image];
                 }
                 else
                 {
                     [self.checkBoxOutlet setEnabled:YES];
                     [self.checkBoxOutlet setTintColor: [UIColor whiteColor]];
                     UIImage *image = [UIImage imageNamed:@"select_all"];
                     [_checkBoxOutlet setImage:image];
                 }
                 self.tableView.hidden = NO;
                 [self.tableView reloadData];
             }
             else
             {
                 [self.checkBoxOutlet setEnabled:NO];
                 [self.checkBoxOutlet setTintColor: [UIColor clearColor]];
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"No data found"
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
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self->pickerView)
    {
        return 1;
    }
    return 0;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.teacherTxtField isFirstResponder])
        {
            return [user_type_name count];
        }
        else if ([self.studentTxtField isFirstResponder])
        {
            return [class_section count];
        }
    }
       return 0;
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.teacherTxtField isFirstResponder])
        {
            return user_type_name[row];
        }
        else if ([self.studentTxtField isFirstResponder])
        {
            return class_section[row];
        }
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.teacherTxtField isFirstResponder])
        {
            selectorFlag = user_type_name[row];
        }
        else if ([self.studentTxtField isFirstResponder])
        {
            selectorFlag = class_section[row];
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([self.teacherTxtField isFirstResponder])
    {
        textField.text = [user_type_name objectAtIndex:[self->pickerView selectedRowInComponent:0]];//component index may differ for u
    }
    else if ([self.studentTxtField isFirstResponder])
    {
        textField.text = [class_section objectAtIndex:[self->pickerView selectedRowInComponent:0]];//component index may differ for u

    }
 }
-(void)SelectedTeacherName
{
    if([self.teacherTxtField isFirstResponder])
    {
        textfieldFlag =@"teacherTextfield";
        if ([selectorFlag isEqualToString:@"Students"])
        {
            self.tableView.hidden = YES;
            self.teacherTxtField.text = selectorFlag;
            self.studentTxtField.hidden = NO;
            self.studentArrowImage.hidden = NO;
            [self selectedValue];
            [self.teacherTxtField resignFirstResponder];
        }
        else if ([selectorFlag isEqualToString:@"Parents"])
        {
            self.tableView.hidden = YES;
            self.teacherTxtField.text = selectorFlag;
            self.studentTxtField.hidden = NO;
            self.studentArrowImage.hidden = NO;
            [self selectedValue];
            [self.teacherTxtField resignFirstResponder];
        }
        else
        {
            self.tableView.hidden = YES;
            self.teacherTxtField.text = selectorFlag;
            self.studentTxtField.hidden = YES;
            self.studentArrowImage.hidden = YES;
            [self selectedValue];
            [self.teacherTxtField resignFirstResponder];
        }
    }
    else
    {
        self.tableView.hidden = YES;
        textfieldFlag =@"studentTextfield";
        self.studentTxtField.text = selectorFlag;
        [self studentsList];
        [self.studentTxtField resignFirstResponder];
    }
}
-(void)CancelButton
{
    if([self.teacherTxtField isFirstResponder])
    {
        [self.teacherTxtField resignFirstResponder];
    }
    else if ([self.studentTxtField isFirstResponder])
    {
        [self.studentTxtField resignFirstResponder];
    }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupNotificationAddMenberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([selectAllFlag isEqualToString:@"YES"])
    {
        cell.nameLabel.text = [name objectAtIndex:indexPath.row];
        cell.teacherId.text = [user_id objectAtIndex:indexPath.row];
        cell.selectImageView.image = [UIImage imageNamed:@"select.png"];
        NSArray *array = [user_id copy];
        [Selected_ids addObject:array];
    }
    else if([selectAllFlag isEqualToString:@"NO"])
    {
        cell.nameLabel.text = [name objectAtIndex:indexPath.row];
        cell.teacherId.text = [user_id objectAtIndex:indexPath.row];
        cell.selectImageView.image = [UIImage imageNamed:@"deselect.png"];
        [Selected_ids removeAllObjects];
    }
    else
    {
        cell.nameLabel.text = [name objectAtIndex:indexPath.row];
        cell.teacherId.text = [user_id objectAtIndex:indexPath.row];
        NSString *strStatus = [status objectAtIndex:indexPath.row];
        if ([strStatus isEqualToString:@"0"])
        {
            cell.selectImageView.image = [UIImage imageNamed:@"deselect.png"];
        }
        else
        {
            cell.selectImageView.image = [UIImage imageNamed:@"select.png"];
            NSString *strSelectedid  = [user_id objectAtIndex:indexPath.row];
            [Selected_ids addObject:strSelectedid];
            
        }
    }
    cell.clickButtonOutlet.tag = indexPath.row;
    [cell.clickButtonOutlet addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (NSIndexPath *)indexPathWithSubview:(UIView *)subview
{
    while (![subview isKindOfClass:[GroupNotificationAddMenberCell self]] && subview)
    {
        subview = subview.superview;
    }
    return [self.tableView indexPathForCell:(GroupNotificationAddMenberCell *)subview];
}
-(void)yourButtonClicked:(UIButton*)sender
{
    if ([textfieldFlag isEqualToString:@"teacherTextfield"])
    {
        NSInteger integer = sender.tag;
        NSLog(@"%lu",(unsigned long)index);
        NSString *strIndex = user_id[integer];
    
        if (![Selected_ids containsObject:strIndex])
        {
            NSIndexPath *path = [self indexPathWithSubview:(UIButton *)sender];
            GroupNotificationAddMenberCell* cell = (GroupNotificationAddMenberCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selectImageView.image =[UIImage imageNamed:@"select.png"];
            [Selected_ids addObject:strIndex];
        }
        else
        {
            NSIndexPath *path = [self indexPathWithSubview:(UIButton *)sender];
            GroupNotificationAddMenberCell* cell = (GroupNotificationAddMenberCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selectImageView.image =[UIImage imageNamed:@"deselect.png"];
            [Selected_ids removeObject:strIndex];
        }
    }
    else
    {
        NSInteger integer = sender.tag;
        NSLog(@"%lu",(unsigned long)index);
        NSString *strIndex = user_id[integer];
        
        if (![Selected_ids containsObject:strIndex])
        {
            NSIndexPath *path = [self indexPathWithSubview:(UIButton *)sender];
            GroupNotificationAddMenberCell* cell = (GroupNotificationAddMenberCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selectImageView.image =[UIImage imageNamed:@"select.png"];
            [Selected_ids addObject:strIndex];
        }
        else
        {
            NSIndexPath *path = [self indexPathWithSubview:(UIButton *)sender];
            GroupNotificationAddMenberCell* cell = (GroupNotificationAddMenberCell *)[self.tableView cellForRowAtIndexPath:path];
            cell.selectImageView.image =[UIImage imageNamed:@"deselect.png"];
            [Selected_ids removeObject:strIndex];
        }
    }
}
- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sendButton:(id)sender
{
        NSArray *newArr = [user_id copy];
        NSArray *myArray  = [NSArray arrayWithArray:newArr];
        NSString *selectedIDs = [myArray componentsJoinedByString:@","];;
        NSUInteger indexValue = [user_type_name indexOfObject:self.teacherTxtField.text];
        NSString *strRole_id = role_id[indexValue];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:group_idFlag forKey:@"group_id"];
        [parameters setObject:selectedIDs forKey:@"group_member_id"];
        [parameters setObject:strRole_id forKey:@"group_user_type"];
        [parameters setObject:statusFlag forKey:@"status"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *add_gn_members = @"apiadmin/add_gn_members";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_gn_members, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"Group Members Added"])
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
                                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                                          GroupNotificationStatusViewController *groupNotificationStatusViewController = (GroupNotificationStatusViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GroupNotificationStatusViewController"];
                                          [self.navigationController pushViewController:groupNotificationStatusViewController animated:YES];
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             else
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
- (IBAction)checkBoxButton:(id)sender
{
    if ([checkBoxFlag isEqualToString:@"YES"])
    {
        checkBoxFlag = @"NO";
        UIImage *image = [UIImage imageNamed:@"select_all.png"];
        [_checkBoxOutlet setImage:image];
        selectAllFlag = @"YES";
        [self.tableView reloadData];
        NSArray *array = [[NSArray alloc] initWithArray:user_id];
        [Selected_ids addObject:array];
    }
    else
    {
        checkBoxFlag = @"YES";
        UIImage *image = [UIImage imageNamed:@"select_all deselect.png"];
        [_checkBoxOutlet setImage:image];
        selectAllFlag = @"NO";
        [self.tableView reloadData];
        [Selected_ids removeObject:user_id];
    }
}
@end
